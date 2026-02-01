// lib/my_reputation_screen.dart

import 'package:flutter/material.dart';
import 'api_client.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';


class MyReputationScreen extends StatefulWidget {
  const MyReputationScreen({super.key});

  @override
  State<MyReputationScreen> createState() => _MyReputationScreenState();
}

class _MyReputationScreenState extends State<MyReputationScreen> {
  Map<String, dynamic>? _reputation;
  bool _isLoading = true;
  String? _error;

  AppLocalizations get l10n => AppLocalizations.of(context);

  @override
  void initState() {
    super.initState();
    _loadReputation();
  }

  Future<void> _loadReputation() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final reputation = await ApiClient.getMyReputation();
      if (!mounted) return;

      if (reputation != null) {
        setState(() {
          _reputation = reputation;
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'Failed to load reputation data';
          _isLoading = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.reputationTitle),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _buildErrorState()
              : _buildContent(isDark),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              _error ?? 'Something went wrong',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadReputation,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(bool isDark) {
    final avgRating = (_reputation?['average_rating'] as num?)?.toDouble() ?? 0.0;
    final totalReviews = (_reputation?['total_reviews'] as int?) ?? 0;
    final reviews = _reputation?['reviews'] as List<dynamic>? ?? [];

    return RefreshIndicator(
      onRefresh: _loadReputation,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Rating summary card
            _buildRatingSummaryCard(avgRating, totalReviews, isDark),

            const SizedBox(height: 24),

            // Section title
            Row(
              children: [
                Icon(
                  Icons.rate_review,
                  color: Colors.blue.shade700,
                  size: 22,
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.reputationWhatProvidersSay,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Reviews list
            if (reviews.isEmpty)
              _buildEmptyState(isDark)
            else
              _ReputationReviewsList(
                reviews: reviews,
                isDark: isDark,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingSummaryCard(double avgRating, int totalReviews, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade600, Colors.blue.shade800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade200.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            l10n.reputationYourCustomerRating,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            avgRating.toStringAsFixed(1),
            style: const TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Icon(
                index < avgRating.round() ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 28,
              );
            }),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.reputationBasedOnReviews(totalReviews),
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _getRatingBadge(avgRating, l10n),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getRatingBadge(double rating, AppLocalizations l10n) {
    if (rating >= 4.5) return l10n.reputationExcellentCustomer;
    if (rating >= 4.0) return l10n.reputationGreatCustomer;
    if (rating >= 3.0) return l10n.reputationGoodCustomer;
    if (rating >= 2.0) return l10n.reputationAverage;
    if (rating > 0) return l10n.reputationNeedsImprovement;
    return l10n.reputationNoRatingYet;
  }

  Widget _buildEmptyState(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            Icons.rate_review_outlined,
            size: 48,
            color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.reputationNoReviews,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.reputationNoReviewsHelp,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================
// EXPANDABLE REVIEWS LIST WIDGET
// =====================

class _ReputationReviewsList extends StatefulWidget {
  final List<dynamic> reviews;
  final bool isDark;

  const _ReputationReviewsList({
    required this.reviews,
    required this.isDark,
  });

  @override
  State<_ReputationReviewsList> createState() => _ReputationReviewsListState();
}

class _ReputationReviewsListState extends State<_ReputationReviewsList> {
  bool _isExpanded = false;
  static const int _initialDisplayCount = 3;
  static const int _maxLinesPerComment = 2;

  AppLocalizations get l10n => AppLocalizations.of(context);

  @override
  Widget build(BuildContext context) {  
    final totalReviews = widget.reviews.length;
    final displayCount = _isExpanded 
        ? totalReviews 
        : totalReviews.clamp(0, _initialDisplayCount);
    final hasMore = totalReviews > _initialDisplayCount;

    return Column(
      children: [
        // Reviews list
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: displayCount,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final review = widget.reviews[index];
            return _buildReviewCard(review);
          },
        ),

        // Show More / Show Less button
        if (hasMore) ...[
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                color: widget.isDark 
                    ? Colors.grey.shade800 
                    : Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: widget.isDark 
                      ? Colors.grey.shade700 
                      : Colors.blue.shade200,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _isExpanded 
                        ? l10n.reputationShowLess 
                        : l10n.reputationShowMore(totalReviews - _initialDisplayCount),
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    _isExpanded 
                        ? Icons.keyboard_arrow_up 
                        : Icons.keyboard_arrow_down,
                    color: Colors.blue.shade700,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildReviewCard(dynamic review) {
    final rating = (review['rating'] as int?) ?? 0;
    final comment = (review['comment'] as String?) ?? '';
    final providerName = (review['provider_name'] as String?) ?? 'Provider';
    final serviceType = (review['service_type'] as String?) ?? '';
    final createdAt = review['created_at'];

    String timeAgo = '';
    if (createdAt != null) {
      try {
        final date = DateTime.parse(createdAt.toString());
        final diff = DateTime.now().difference(date);
        if (diff.inDays > 365) {
          final years = (diff.inDays / 365).floor();
          timeAgo = l10n.reputationYearsAgo(years);
        } else if (diff.inDays > 30) {
          final months = (diff.inDays / 30).floor();
          timeAgo = l10n.reputationMonthsAgo(months);
        } else if (diff.inDays > 6) {
          final weeks = (diff.inDays / 7).floor();
          timeAgo = l10n.reputationWeeksAgo(weeks);
        } else if (diff.inDays > 0) {
          timeAgo = l10n.reputationDaysAgo(diff.inDays);
        } else if (diff.inHours > 0) {
          timeAgo = l10n.reputationHoursAgo(diff.inHours);
        } else if (diff.inMinutes > 0) {
          timeAgo = l10n.reputationMinutesAgo(diff.inMinutes);
        } else {
          timeAgo = l10n.reputationJustNow;
        }
      } catch (_) {}
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: widget.isDark ? Colors.grey.shade800 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: widget.isDark ? Colors.grey.shade700 : Colors.grey.shade200,
        ),
        boxShadow: widget.isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.grey.shade100,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Provider name + rating + time
          Row(
            children: [
              // Provider avatar
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.blue.shade100,
                child: Text(
                  providerName.isNotEmpty ? providerName[0].toUpperCase() : 'P',
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Provider name and service type
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      providerName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    if (serviceType.isNotEmpty)
                      Text(
                        serviceType,
                        style: TextStyle(
                          fontSize: 12,
                          color: widget.isDark 
                              ? Colors.grey.shade400 
                              : Colors.grey.shade600,
                        ),
                      ),
                  ],
                ),
              ),
              // Rating stars
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getRatingColor(rating).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      color: _getRatingColor(rating),
                      size: 14,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '$rating',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: _getRatingColor(rating),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Comment (if any)
          if (comment.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              '"$comment"',
              maxLines: _maxLinesPerComment,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                fontStyle: FontStyle.italic,
                color: widget.isDark 
                    ? Colors.grey.shade300 
                    : Colors.grey.shade700,
              ),
            ),
          ],

          // Time ago
          if (timeAgo.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              timeAgo,
              style: TextStyle(
                fontSize: 11,
                color: widget.isDark 
                    ? Colors.grey.shade500 
                    : Colors.grey.shade500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getRatingColor(int rating) {
    switch (rating) {
      case 5:
        return Colors.green;
      case 4:
        return Colors.lightGreen;
      case 3:
        return Colors.amber;
      case 2:
        return Colors.orange;
      case 1:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}