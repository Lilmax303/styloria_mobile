// lib/my_reviews_screen.dart

import 'package:flutter/material.dart';
import 'api_client.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';
import 'utils/datetime_helper.dart';

class MyReviewsScreen extends StatefulWidget {
  const MyReviewsScreen({super.key});

  @override
  State<MyReviewsScreen> createState() => _MyReviewsScreenState();
}

class _MyReviewsScreenState extends State<MyReviewsScreen> {
  bool _loading = true;
  String? _error;
  List<dynamic>? _reviews;

  @override
  void initState() {
    super.initState();
    _loadReviews();
  }

  Future<void> _loadReviews() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final data = await ApiClient.getMyReviews();

    setState(() {
      _loading = false;
      if (data == null) {
        _error = AppLocalizations.of(context).failedToLoadReviews;
      } else {
        _reviews = data;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.myReviewsTitle)),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : _reviews == null || _reviews!.isEmpty
                  ? Center(child: Text(l10n.noReviewsYet))
                  : RefreshIndicator(
                      onRefresh: _loadReviews,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: _reviews!.length,
                        itemBuilder: (context, index) {
                          final r = _reviews![index] as Map<String, dynamic>;
                          final ratingRaw = r['rating'];
                          final rating = (ratingRaw is int) 
                              ? ratingRaw 
                              : int.tryParse(ratingRaw?.toString() ?? '0') ?? 0;
                          final comment = r['comment']?.toString() ?? '';
                          final createdAt = r['created_at']?.toString() ?? '';
                          
                          // ✅ IMPROVED: Format timestamp with timezone
                          final timeDisplay = createdAt.isNotEmpty
                              ? DateTimeHelper.formatMetadataTime(createdAt)
                              : '';
                          
                          // Get provider info
                          final provider = r['service_provider'] as Map<String, dynamic>?;
                          String providerName = '';
                          String? profilePicUrl;
                          
                          if (provider != null) {
                            final providerUser = provider['user'] as Map<String, dynamic>?;
                            if (providerUser != null) {
                              providerName = providerUser['username']?.toString() ?? '';
                              profilePicUrl = providerUser['profile_picture_url']?.toString();
                            }
                          }
                          
                          // ✅ IMPROVED: Color based on rating
                          Color ratingColor;
                          if (rating >= 4) {
                            ratingColor = Colors.green;
                          } else if (rating >= 3) {
                            ratingColor = Colors.orange;
                          } else {
                            ratingColor = Colors.red;
                          }
                          
                          return Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ✅ IMPROVED: Provider header with avatar
                                  Row(
                                    children: [
                                      // Provider avatar
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.grey.shade200,
                                        backgroundImage: profilePicUrl != null && profilePicUrl.isNotEmpty
                                            ? NetworkImage(profilePicUrl)
                                            : null,
                                        child: profilePicUrl == null || profilePicUrl.isEmpty
                                            ? Icon(
                                                Icons.person,
                                                size: 20,
                                                color: Colors.grey.shade600,
                                              )
                                            : null,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              providerName.isNotEmpty
                                                  ? providerName
                                                  : l10n.providerGeneric,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            // ✅ IMPROVED: Time display with icon
                                            if (timeDisplay.isNotEmpty)
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.access_time,
                                                    size: 11,
                                                    color: Colors.grey.shade600,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    timeDisplay,
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.grey.shade600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ),
                                      // ✅ IMPROVED: Star rating badge
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: ratingColor.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(
                                            color: ratingColor.withOpacity(0.5),
                                            width: 1,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              size: 16,
                                              color: ratingColor,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '$rating/5',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: ratingColor,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  // ✅ IMPROVED: Star display
                                  if (rating > 0) ...[
                                    const SizedBox(height: 12),
                                    Row(
                                      children: List.generate(
                                        5,
                                        (index) => Icon(
                                          index < rating ? Icons.star : Icons.star_border,
                                          color: Colors.amber,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                  
                                  // ✅ IMPROVED: Comment section
                                  if (comment.isNotEmpty) ...[
                                    const SizedBox(height: 12),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade50,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.format_quote,
                                            size: 16,
                                            color: Colors.grey.shade600,
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              comment,
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey.shade800,
                                                fontStyle: FontStyle.italic,
                                                height: 1.4,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
    );
  }
}