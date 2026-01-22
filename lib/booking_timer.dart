// lib/booking_timer.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';

class BookingTimer extends StatefulWidget {
  final DateTime acceptedAt;
  final int bookingId;
  final VoidCallback? onPenaltyStart;
  final VoidCallback? onTimerComplete;
  
  const BookingTimer({
    super.key,
    required this.acceptedAt,
    required this.bookingId,
    this.onPenaltyStart,
    this.onTimerComplete,
  });

  @override
  State<BookingTimer> createState() => _BookingTimerState();
}

class _BookingTimerState extends State<BookingTimer> {
  late Timer _timer;
  Duration _timeLeft = Duration.zero;
  bool _penaltyPeriod = false;

  @override
  void initState() {
    super.initState();
    _calculateTimeLeft();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _calculateTimeLeft() {
    final now = DateTime.now().toUtc();
    final acceptedTime = widget.acceptedAt.toUtc();
    final sevenMinutes = const Duration(minutes: 7);
    final deadline = acceptedTime.add(sevenMinutes);
    
    if (now.isAfter(deadline)) {
      _timeLeft = Duration.zero;
      _penaltyPeriod = true;
      if (widget.onTimerComplete != null) {
        widget.onTimerComplete!();
      }
    } else {
      _timeLeft = deadline.difference(now);
      _penaltyPeriod = false;
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      
      setState(() {
        _calculateTimeLeft();
        
        // Check if just entered penalty period
        if (_timeLeft.inSeconds <= 0 && !_penaltyPeriod) {
          _penaltyPeriod = true;
          if (widget.onPenaltyStart != null) {
            widget.onPenaltyStart!();
          }
        }
      });
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _penaltyPeriod ? Colors.orange[100] : Colors.green[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _penaltyPeriod ? Colors.orange : Colors.green,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _penaltyPeriod ? Icons.warning : Icons.timer,
                color: _penaltyPeriod ? Colors.orange : Colors.green,
              ),
              const SizedBox(width: 8),
              Text(
                _penaltyPeriod 
                    ? l10n.bookingTimerPenaltyPeriodActive 
                    : l10n.bookingTimerFreeCancellationPeriod,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _penaltyPeriod ? Colors.orange[800] : Colors.green[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (!_penaltyPeriod)
            Text(
              l10n.bookingTimerTimeRemaining(_formatDuration(_timeLeft)),
              style: const TextStyle(fontSize: 16),
            ),
          const SizedBox(height: 4),
          Text(
            _penaltyPeriod 
                ? l10n.bookingTimerCancellingNowPenalty
                : l10n.bookingTimerCancelNoPenalty,
            style: TextStyle(
              color: _penaltyPeriod ? Colors.orange[800] : Colors.green[800],
            ),
          ),
        ],
      ),
    );
  }
}