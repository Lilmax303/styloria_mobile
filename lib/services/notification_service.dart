// lib/services/notification_service.dart

import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import '../api_client.dart';

/// Global notification service for real-time WebSocket notifications
class NotificationService {
  static NotificationService? _instance;
  static NotificationService get instance {
    _instance ??= NotificationService._internal();
    return _instance!;
  }

  NotificationService._internal();

  WebSocketChannel? _channel;
  StreamSubscription? _subscription;
  bool _isConnected = false;
  int? _userId;
  Timer? _reconnectTimer;
  Timer? _pingTimer;

  // Stream controllers for different notification types
  final _notificationController = StreamController<Map<String, dynamic>>.broadcast();
  final _chatMessageController = StreamController<Map<String, dynamic>>.broadcast();

  /// Stream of all notifications
  Stream<Map<String, dynamic>> get notifications => _notificationController.stream;

  /// Stream of chat message notifications specifically
  Stream<Map<String, dynamic>> get chatMessages => _chatMessageController.stream;

  /// Whether WebSocket is connected
  bool get isConnected => _isConnected;

  /// Initialize and connect to WebSocket
  Future<void> connect() async {
    if (_isConnected) return;

    try {
      // Get current user ID
      final user = await ApiClient.getCurrentUser();
      if (user == null) {
        debugPrint('NotificationService: No user logged in');
        return;
      }

      _userId = user['id'] as int?;
      if (_userId == null) {
        debugPrint('NotificationService: Invalid user ID');
        return;
      }

      await _connectWebSocket();
    } catch (e) {
      debugPrint('NotificationService: Error connecting: $e');
      _scheduleReconnect();
    }
  }

  Future<void> _connectWebSocket() async {
    if (_userId == null) return;

    // Build WebSocket URL
    // Replace with your actual server URL
    final baseUrl = ApiClient.baseUrl;
    final wsUrl = baseUrl
        .replaceFirst('https://', 'wss://')
        .replaceFirst('http://', 'ws://');
    
    final uri = Uri.parse('$wsUrl/ws/notifications/$_userId/');

    debugPrint('NotificationService: Connecting to $uri');

    try {
      _channel = WebSocketChannel.connect(uri);
      
      _subscription = _channel!.stream.listen(
        _onMessage,
        onError: _onError,
        onDone: _onDone,
      );

      _isConnected = true;
      debugPrint('NotificationService: Connected successfully');

      // Start ping timer to keep connection alive
      _startPingTimer();
    } catch (e) {
      debugPrint('NotificationService: WebSocket connection failed: $e');
      _scheduleReconnect();
    }
  }

  void _onMessage(dynamic data) {
    try {
      final decoded = jsonDecode(data.toString());
      debugPrint('NotificationService: Received: $decoded');

      if (decoded is Map<String, dynamic>) {
        final message = decoded['message'];
        
        if (message is Map<String, dynamic>) {
          // Emit to general notifications stream
          _notificationController.add(message);

          // Check if it's a chat message notification
          final type = message['type']?.toString();
          if (type == 'chat_message') {
            _chatMessageController.add(message);
          }
        } else if (message is String) {
          // Simple text message (like connection confirmation)
          _notificationController.add({'type': 'info', 'text': message});
        }
      }
    } catch (e) {
      debugPrint('NotificationService: Error parsing message: $e');
    }
  }

  void _onError(dynamic error) {
    debugPrint('NotificationService: WebSocket error: $error');
    _isConnected = false;
    _scheduleReconnect();
  }

  void _onDone() {
    debugPrint('NotificationService: WebSocket closed');
    _isConnected = false;
    _scheduleReconnect();
  }

  void _scheduleReconnect() {
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(const Duration(seconds: 5), () {
      if (!_isConnected && _userId != null) {
        debugPrint('NotificationService: Attempting to reconnect...');
        _connectWebSocket();
      }
    });
  }

  void _startPingTimer() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (_isConnected && _channel != null) {
        try {
          _channel!.sink.add(jsonEncode({'type': 'ping'}));
        } catch (e) {
          debugPrint('NotificationService: Ping failed: $e');
        }
      }
    });
  }

  /// Disconnect from WebSocket
  void disconnect() {
    _reconnectTimer?.cancel();
    _pingTimer?.cancel();
    _subscription?.cancel();
    _channel?.sink.close(status.goingAway);
    _channel = null;
    _isConnected = false;
    _userId = null;
    debugPrint('NotificationService: Disconnected');
  }

  /// Dispose resources
  void dispose() {
    disconnect();
    _notificationController.close();
    _chatMessageController.close();
    _instance = null;
  }
}