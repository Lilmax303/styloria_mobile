// lib/portfolio_viewer_screen.dart

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';

class PortfolioViewerScreen extends StatefulWidget {
  final List<dynamic> posts;
  final int initialIndex;

  const PortfolioViewerScreen({
    super.key,
    required this.posts,
    required this.initialIndex,
  });

  @override
  State<PortfolioViewerScreen> createState() => _PortfolioViewerScreenState();
}

class _PortfolioViewerScreenState extends State<PortfolioViewerScreen> {
  late PageController _pageController;

  VideoPlayerController? _videoController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
    _initForIndex(widget.initialIndex);
  }

  Future<void> _initForIndex(int index) async {
    _disposeVideo();

    final post = widget.posts[index] as Map<String, dynamic>;
    final mediaType = (post['media_type'] ?? 'image').toString();
    final mediaUrl = (post['media_url'] ?? '').toString();

    if (mediaType == 'video' && mediaUrl.isNotEmpty) {
      final vc = VideoPlayerController.networkUrl(Uri.parse(mediaUrl));
      await vc.initialize();

      _videoController = vc;
      _chewieController = ChewieController(
        videoPlayerController: vc,
        autoPlay: true,
        looping: false,
        allowPlaybackSpeedChanging: true,
      );

      if (mounted) setState(() {});
    }
  }

  void _disposeVideo() {
    _chewieController?.dispose();
    _videoController?.dispose();
    _chewieController = null;
    _videoController = null;
  }

  @override
  void dispose() {
    _disposeVideo();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.posts.length,
        onPageChanged: _initForIndex,
        itemBuilder: (context, index) {
          final post = widget.posts[index] as Map<String, dynamic>;
          final mediaType = (post['media_type'] ?? 'image').toString();
          final mediaUrl = (post['media_url'] ?? '').toString();
          final caption = (post['caption'] ?? '').toString();

          return Column(
            children: [
              Expanded(
                child: Center(
                  child: mediaType == 'video'
                      ? (_chewieController == null
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Chewie(controller: _chewieController!))
                      : InteractiveViewer(
                          child: Image.network(
                            mediaUrl,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) =>
                                Text(l10n.failedToLoadImage, style: const TextStyle(color: Colors.white)),
                          ),
                        ),
                ),
              ),
              if (caption.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    caption,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}