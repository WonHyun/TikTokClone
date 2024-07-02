import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictok_clone/features/videos/view_models/video_timeline_view_model.dart';
import 'package:tictok_clone/features/videos/views/widgets/video_post.dart';

class ViedoTimelineScreen extends ConsumerStatefulWidget {
  const ViedoTimelineScreen({super.key});

  @override
  ConsumerState<ViedoTimelineScreen> createState() =>
      _ViedoTimelineScreenState();
}

class _ViedoTimelineScreenState extends ConsumerState<ViedoTimelineScreen> {
  final PageController _controller = PageController();

  final _scrollDuration = const Duration(milliseconds: 250);
  final _scrollCurve = Curves.linear;

  int _itemCount = 0;

  void _onPageChanged(int page) {
    _controller.animateToPage(
      page,
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
    if (page == _itemCount - 1) {
      ref.read(timelineProvider.notifier).fetchNextPage();
    }
  }

  void _onVideoFinished() {
    // _controller.nextPage(duration: _scrollDuration, curve: _scrollCurve);
  }

  Future<void> _onRefresh() {
    return Future.delayed(const Duration(seconds: 5));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(timelineProvider).when(
          data: (videos) {
            _itemCount = videos.length;
            return RefreshIndicator(
              displacement: 50,
              edgeOffset: 20,
              color: Theme.of(context).primaryColor,
              onRefresh: _onRefresh,
              child: PageView.builder(
                controller: _controller,
                scrollDirection: Axis.vertical,
                onPageChanged: _onPageChanged,
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  final videoData = videos[index];
                  return VideoPost(
                    onVideoFinished: _onVideoFinished,
                    pageIndex: index,
                    videoData: videoData,
                  );
                },
              ),
            );
          },
          error: (err, stack) => Center(
            child: Text(
              "Could not load videos: $err",
              style: const TextStyle(color: Colors.white),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
  }
}
