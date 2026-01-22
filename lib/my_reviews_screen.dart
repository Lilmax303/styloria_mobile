// lib/my_reviews_screen.dart

import 'package:flutter/material.dart';
import 'api_client.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';

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
                          final r =
                              _reviews![index] as Map<String, dynamic>;
                          final rating = r['rating']?.toString() ?? '';
                          final comment = r['comment']?.toString() ?? '';
                          final createdAt =
                              r['created_at']?.toString() ?? '';

                          final provider =
                              r['service_provider'] as Map<String, dynamic>?;
                          String providerName = '';
                          if (provider != null) {
                            final providerUser = provider['user']
                                as Map<String, dynamic>?;
                            if (providerUser != null) {
                              providerName =
                                  providerUser['username']?.toString() ?? '';
                            }
                          }

                          return Card(
                            child: ListTile(
                              title: Text(
                                providerName.isNotEmpty
                                    ? l10n.providerWithName(providerName)
                                    : l10n.providerGeneric,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(l10n.ratingWithValue(rating)),
                                  if (comment.isNotEmpty) Text(comment),
                                  Text(
                                    createdAt,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
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