// lib/services/notification_service.dart

import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing real-time WebSocket notifications.
/// 
/// Usage:
/// ```dart
/// // Connect when user logs in
/// await NotificationService.instance.connect();
/// 
/// // Listen for general notifications
/// NotificationService.instance.notifications.listen((notification) {
///   print('New notification: $notification');
/// });
/// 
/// // Listen for chat messages specifically
/// NotificationService.instance.chatMessages.listen((message) {
///   print('New chat message: $message');
/// });
/// 
/// // Disconnect when user logs out
/// NotificationService.instance.disconnect();
/// ```
class NotificationService {
  // Singleton instance
  static final NotificationService instance = NotificationService._internal();
  
  NotificationService._internal();

  WebSocketChannel? _channel;
  StreamController<Map<String, dynamic>>? _notificationController;
  StreamController<Map<String, dynamic>>? _chatMessageController;
  Timer? _reconnectTimer;
  Timer? _pingTimer;
  bool _isConnected = false;
  bool _shouldReconnect = true;
  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 5;
  static const Duration _reconnectDelay = Duration(seconds: 3);
  static const Duration _pingInterval = Duration(seconds: 30);

  /// Stream of incoming general notifications
  Stream<Map<String, dynamic>> get notifications {
    _notificationController ??= StreamController<Map<String, dynamic>>.broadcast();
    return _notificationController!.stream;
  }

  /// Stream of incoming chat messages
  /// Filters notifications to only include chat-related messages
  Stream<Map<String, dynamic>> get chatMessages {
    _chatMessageController ??= StreamController<Map<String, dynamic>>.broadcast();
    return _chatMessageController!.stream;
  }

  /// Whether the WebSocket is currently connected
  bool get isConnected => _isConnected;

  /// Connect to the WebSocket notification server
  Future<void> connect() async {
    if (_isConnected) {
      debugPrint('NotificationService: Already connected');
      return;
    }

    _shouldReconnect = true;
    await _establishConnection();
  }

  Future<void> _establishConnection() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id') ?? prefs.getString('user_id');
      
      if (userId == null) {
        debugPrint('NotificationService: No user ID found, cannot connect');
        return;
      }

      // Get the base URL and convert to WebSocket URL
      String baseUrl = prefs.getString('base_url') ?? 'https://your-api-domain.com';
      
      // Convert HTTP to WS protocol
      String wsUrl;
      if (baseUrl.startsWith('https://')) {
        wsUrl = baseUrl.replaceFirst('https://', 'wss://');
      } else if (baseUrl.startsWith('http://')) {
        wsUrl = baseUrl.replaceFirst('http://', 'ws://');
      } else {
        wsUrl = 'wss://$baseUrl';
      }

      // Remove trailing slash if present
      if (wsUrl.endsWith('/')) {
        wsUrl = wsUrl.substring(0, wsUrl.length - 1);
      }

      final fullUrl = '$wsUrl/ws/notifications/$userId/';
      debugPrint('NotificationService: Connecting to $fullUrl');

      _channel = WebSocketChannel.connect(Uri.parse(fullUrl));
      
      _notificationController ??= StreamController<Map<String, dynamic>>.broadcast();
      _chatMessageController ??= StreamController<Map<String, dynamic>>.broadcast();

      _channel!.stream.listen(
        _onMessage,
        onError: _onError,
        onDone: _onDone,
        cancelOnError: false,
      );

      _isConnected = true;
      _reconnectAttempts = 0;
      debugPrint('NotificationService: Connected successfully');

      // Start ping timer to keep connection alive
      _startPingTimer();

    } catch (e) {
      debugPrint('NotificationService: Connection error: $e');
      _isConnected = false;
      _scheduleReconnect();
    }
  }

  void _onMessage(dynamic message) {
    try {
      debugPrint('NotificationService: Received message: $message');
      
      final data = message is String ? jsonDecode(message) : message;
      
      if (data is Map<String, dynamic>) {
        // Extract the notification message
        final notification = data['message'];
        Map<String, dynamic> parsedNotification;
        
        if (notification is Map<String, dynamic>) {
          parsedNotification = notification;
        } else if (notification is String) {
          // Simple string message
          parsedNotification = {
            'type': 'info',
            'text': notification,
            'timestamp': DateTime.now().toIso8601String(),
          };
        } else {
          // Pass through the entire data object
          parsedNotification = data;
        }
        
        // Add to general notifications stream
        _notificationController?.add(parsedNotification);
        
        // Check if this is a chat message and add to chat stream
        final type = parsedNotification['type']?.toString().toLowerCase() ?? '';
        if (_isChatMessage(type, parsedNotification)) {
          _chatMessageController?.add(parsedNotification);
          debugPrint('NotificationService: Chat message detected and forwarded');
        }
      }
    } catch (e) {
      debugPrint('NotificationService: Error parsing message: $e');
    }
  }

  /// Check if a notification is a chat-related message
  bool _isChatMessage(String type, Map<String, dynamic> notification) {
    // Check by type
    if (type.contains('chat') || 
        type.contains('message') || 
        type == 'new_message' ||
        type == 'chat_message') {
      return true;
    }
    
    // Check if it has thread_id (indicates it's a chat message)
    if (notification.containsKey('thread_id')) {
      return true;
    }
    
    // Check by text content
    final text = notification['text']?.toString().toLowerCase() ?? '';
    if (text.contains('new message') || text.contains('💬')) {
      return true;
    }
    
    return false;
  }

  void _onError(dynamic error) {
    debugPrint('NotificationService: WebSocket error: $error');
    _isConnected = false;
    _stopPingTimer();
    _scheduleReconnect();
  }

  void _onDone() {
    debugPrint('NotificationService: WebSocket connection closed');
    _isConnected = false;
    _stopPingTimer();
    _scheduleReconnect();
  }

  void _scheduleReconnect() {
    if (!_shouldReconnect) {
      debugPrint('NotificationService: Reconnection disabled');
      return;
    }

    if (_reconnectAttempts >= _maxReconnectAttempts) {
      debugPrint('NotificationService: Max reconnect attempts reached');
      return;
    }

    _reconnectTimer?.cancel();
    _reconnectAttempts++;
    
    final delay = _reconnectDelay * _reconnectAttempts;
    debugPrint('NotificationService: Scheduling reconnect in ${delay.inSeconds}s (attempt $_reconnectAttempts)');

    _reconnectTimer = Timer(delay, () {
      if (_shouldReconnect && !_isConnected) {
        _establishConnection();
      }
    });
  }

  void _startPingTimer() {
    _stopPingTimer();
    _pingTimer = Timer.periodic(_pingInterval, (_) {
      if (_isConnected && _channel != null) {
        try {
          _channel!.sink.add(jsonEncode({'type': 'ping'}));
          debugPrint('NotificationService: Ping sent');
        } catch (e) {
          debugPrint('NotificationService: Ping failed: $e');
        }
      }
    });
  }

  void _stopPingTimer() {
    _pingTimer?.cancel();
    _pingTimer = null;
  }

  /// Send a message through the WebSocket
  void send(Map<String, dynamic> message) {
    if (_isConnected && _channel != null) {
      try {
        _channel!.sink.add(jsonEncode(message));
        debugPrint('NotificationService: Message sent: $message');
      } catch (e) {
        debugPrint('NotificationService: Failed to send message: $e');
      }
    } else {
      debugPrint('NotificationService: Cannot send - not connected');
    }
  }

  /// Disconnect from the WebSocket server
  void disconnect() {
    debugPrint('NotificationService: Disconnecting...');
    _shouldReconnect = false;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _stopPingTimer();
    
    _channel?.sink.close();
    _channel = null;
    _isConnected = false;
    _reconnectAttempts = 0;
  }

  /// Reset and reconnect (useful after login)
  Future<void> reconnect() async {
    disconnect();
    await Future.delayed(const Duration(milliseconds: 500));
    _shouldReconnect = true;
    _reconnectAttempts = 0;
    await connect();
  }

  /// Dispose of resources
  void dispose() {
    disconnect();
    _notificationController?.close();
    _notificationController = null;
    _chatMessageController?.close();
    _chatMessageController = null;
  }
}