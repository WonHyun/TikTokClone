import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tictok_clone/features/videos/views/widgets/video_post.dart';

class ViedoTimelineScreen extends StatefulWidget {
  const ViedoTimelineScreen({super.key});

  @override
  State<ViedoTimelineScreen> createState() => _ViedoTimelineScreenState();
}

class _ViedoTimelineScreenState extends State<ViedoTimelineScreen> {
  final PageController _controller = PageController();
  final int _itemCount = 4;

  final _scrollDuration = const Duration(milliseconds: 250);
  final _scrollCurve = Curves.linear;

  void _onPageChanged(int page) {
    _controller.animateToPage(
      page,
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
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
    return RefreshIndicator(
      displacement: 50,
      edgeOffset: 20,
      color: Theme.of(context).primaryColor,
      onRefresh: _onRefresh,
      child: PageView.builder(
        controller: _controller,
        scrollDirection: Axis.vertical,
        onPageChanged: _onPageChanged,
        itemCount: _itemCount,
        itemBuilder: (context, index) => VideoPost(
          onVideoFinished: _onVideoFinished,
          pageIndex: index,
        ),
      ),
    );
  }
}
