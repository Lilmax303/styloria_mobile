// lib/widgets/portfolio_section_widget.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';
import '../api_client.dart';
import '../portfolio_viewer_screen.dart';

class PortfolioSectionWidget extends StatefulWidget {
  final List<dynamic> portfolioPosts;
  final bool isLoading;
  final bool isUploading;
  final String? error;
  final VoidCallback onRefresh;
  final Future<void> Function() onAddPost;
  final Future<void> Function(int postId) onDeletePost;

  const PortfolioSectionWidget({
    super.key,
    required this.portfolioPosts,
    required this.isLoading,
    required this.isUploading,
    this.error,
    required this.onRefresh,
    required this.onAddPost,
    required this.onDeletePost,
  });

  @override
  State<PortfolioSectionWidget> createState() =>
      _PortfolioSectionWidgetState();
}

class _PortfolioSectionWidgetState extends State<PortfolioSectionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _entryController;

  static const Color _goldAccent = Color(0xFFD4AF37);
  static const Color _goldLight = Color(0xFFF4D03F);

  @override
  void initState() {
    super.initState();
    _entryController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _entryController.forward();
  }

  @override
  void dispose() {
    _entryController.dispose();
    super.dispose();
  }

  String _resolveUrl(String? raw) {
    if (raw == null || raw.isEmpty) return '';
    if (raw.startsWith('http://') || raw.startsWith('https://'))
      return raw;
    if (raw.startsWith('/')) return '${ApiClient.baseUrl}$raw';
    return raw;
  }

  List<Map<String, dynamic>> _flattenPortfolio(List<dynamic> posts) {
    final items = <Map<String, dynamic>>[];
    for (final p in posts) {
      final post = Map<String, dynamic>.from(p as Map);
      final caption = (post['caption'] ?? '').toString();
      final media = (post['media'] as List?) ?? [];

      for (final m in media) {
        final mm = Map<String, dynamic>.from(m as Map);
        final url = _resolveUrl(mm['file_url']?.toString());
        if (url.isEmpty) continue;

        items.add({
          'media_type': (mm['media_type'] ?? 'image').toString(),
          'media_url': url,
          'caption': caption,
        });
      }
    }
    return items;
  }

  int _initialMediaIndexForPost(int postIndex) {
    int idx = 0;
    for (int i = 0; i < postIndex; i++) {
      final post =
          widget.portfolioPosts[i] as Map<String, dynamic>;
      final media = (post['media'] as List?) ?? const [];
      idx += media.length;
    }
    return idx;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final headerColor =
        isDark ? Colors.white : const Color(0xFF1A1A2E);
    final subtitleColor =
        isDark ? Colors.grey.shade400 : const Color(0xFF4A4A5A);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(headerColor, subtitleColor, isDark),
        const SizedBox(height: 20),
        if (widget.error != null)
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.red.shade900.withOpacity(0.3)
                  : Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark
                    ? Colors.red.shade700
                    : Colors.red.shade200,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: isDark
                      ? Colors.red.shade300
                      : Colors.red.shade700,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.error!,
                    style: TextStyle(
                      color: isDark
                          ? Colors.red.shade300
                          : Colors.red.shade700,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        if (widget.isLoading)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(40),
              child: CircularProgressIndicator(),
            ),
          )
        else if (widget.portfolioPosts.isEmpty)
          _buildEmptyState(isDark, headerColor, subtitleColor)
        else
          _buildPortfolioGrid(isDark),
        const SizedBox(height: 20),
        _buildAddButton(),
      ],
    );
  }

  Widget _buildHeader(
      Color headerColor, Color subtitleColor, bool isDark) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.portfolioShowcaseTitle,
                      style: TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: headerColor,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l10n.portfolioShowcaseSubtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: subtitleColor,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed:
                    widget.isLoading ? null : widget.onRefresh,
                icon: const Icon(Icons.refresh),
                color: _goldAccent,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: 60,
            height: 3,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_goldAccent, _goldLight],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(
      bool isDark, Color headerColor, Color subtitleColor) {
    final l10n = AppLocalizations.of(context);

    return Container(
      padding:
          const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.grey.shade800.withOpacity(0.5)
            : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.grey.shade700
              : Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  _goldAccent.withOpacity(0.2),
                  _goldLight.withOpacity(0.1),
                ],
              ),
            ),
            child: const Icon(
              Icons.photo_library_outlined,
              size: 40,
              color: _goldAccent,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.portfolioEmptyTitle,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: headerColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.portfolioEmptySubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: subtitleColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioGrid(bool isDark) {
    return AnimatedBuilder(
      animation: _entryController,
      builder: (context, child) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.portfolioPosts.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.0,
          ),
          itemBuilder: (context, index) {
            final delay = index * 0.1;
            final animation =
                Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(
                parent: _entryController,
                curve: Interval(
                  delay.clamp(0.0, 0.6),
                  (delay + 0.4).clamp(0.0, 1.0),
                  curve: Curves.easeOutBack,
                ),
              ),
            );

            return AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: animation.value,
                  child: Opacity(
                    opacity:
                        animation.value.clamp(0.0, 1.0),
                    child: _buildPortfolioItem(
                        index, isDark),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildPortfolioItem(int index, bool isDark) {
    final post =
        widget.portfolioPosts[index] as Map<String, dynamic>;
    final postId = post['id'];
    final caption = (post['caption'] ?? '').toString();
    final mediaList = (post['media'] is List)
        ? (post['media'] as List)
        : const <dynamic>[];
    final cover = mediaList.isNotEmpty
        ? (mediaList.first as Map<String, dynamic>)
        : <String, dynamic>{};

    final mediaType =
        (cover['media_type'] ?? 'image').toString();
    final mediaUrl =
        _resolveUrl(cover['file_url']?.toString());

    return GestureDetector(
      onTap: () {
        final flattened =
            _flattenPortfolio(widget.portfolioPosts);
        if (flattened.isEmpty) return;

        final initialIndex =
            _initialMediaIndexForPost(index);
        final safeIndex =
            initialIndex.clamp(0, flattened.length - 1);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PortfolioViewerScreen(
              posts: flattened,
              initialIndex: safeIndex,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(isDark ? 0.3 : 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                color: isDark
                    ? Colors.grey.shade800
                    : Colors.grey.shade200,
                child: mediaUrl.isEmpty
                    ? Center(
                        child: Icon(
                          Icons.broken_image,
                          size: 40,
                          color: isDark
                              ? Colors.grey.shade600
                              : Colors.grey.shade400,
                        ),
                      )
                    : Image.network(
                        mediaUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Center(
                          child: Icon(
                            Icons.broken_image,
                            color: isDark
                                ? Colors.grey.shade600
                                : Colors.grey.shade400,
                          ),
                        ),
                      ),
              ),
              if (mediaType == 'video')
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(
                    child: Icon(
                      Icons.play_circle_fill,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                ),
              if (postId is int)
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () =>
                        widget.onDeletePost(postId),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color:
                            Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              if (caption.isNotEmpty)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                    child: Text(
                      caption,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              if (mediaList.length > 1)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color:
                          Colors.black.withOpacity(0.6),
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.collections,
                            color: Colors.white,
                            size: 14),
                        const SizedBox(width: 4),
                        Text(
                          '${mediaList.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    final l10n = AppLocalizations.of(context);

    return Center(
      child: GestureDetector(
        onTap:
            widget.isUploading ? null : widget.onAddPost,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(
              horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.isUploading
                  ? [
                      Colors.grey.shade400,
                      Colors.grey.shade500
                    ]
                  : [
                      _goldAccent,
                      const Color(0xFFB8860B)
                    ],
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: (widget.isUploading
                        ? Colors.grey
                        : _goldAccent)
                    .withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.isUploading)
                const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              else
                const Icon(Icons.add_photo_alternate,
                    color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Text(
                widget.isUploading
                    ? l10n.portfolioUploading
                    : l10n.portfolioAddButton,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}