import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/videos/models/video_model.dart';
import 'package:tictok_clone/features/videos/view_models/playback_config_view_model.dart';
import 'package:tictok_clone/features/videos/views/widgets/more_rich_text.dart';
import 'package:tictok_clone/features/videos/views/widgets/video_button.dart';
import 'package:tictok_clone/features/videos/views/widgets/video_comments.dart';
import 'package:tictok_clone/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends ConsumerStatefulWidget {
  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.pageIndex,
    required this.videoData,
  });

  final Function() onVideoFinished;
  final int pageIndex;
  final VideoModel videoData;

  @override
  VideoPostState createState() => VideoPostState();
}

class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  late final VideoPlayerController _videoController =
      VideoPlayerController.networkUrl(Uri.parse(widget.videoData.fileUrl));
  final Duration _animationDuration = const Duration(milliseconds: 200);

  late final AnimationController _animationController;

  bool _isPaused = false;
  bool _isMuted = false;

  double _volume = 1.0;

  // void _onVideoChange() {
  //   if (_videoController.value.isInitialized) {
  //     if (_videoController.value.duration == _videoController.value.position) {
  //       widget.onVideoFinished();
  //     }
  //   }
  // }

  Future<void> _initVideoPlayer() async {
    await _videoController.initialize();
    if (kIsWeb) {
      _isMuted = true;
      _volume = 0.0;
    }
    await _videoController.setVolume(_volume);
    await _videoController.setLooping(true);
    setState(() {});
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoController.value.isPlaying) {
      final autoplay = ref.read(playbackConfigProvider).autoplay;
      if (autoplay) {
        _videoController.play();
      }
    }
    if (_videoController.value.isPlaying && info.visibleFraction == 0) {
      _onTogglePause();
    }
  }

  void _onTogglePause() {
    if (_videoController.value.isPlaying) {
      _videoController.pause();
      _animationController.reverse();
    } else {
      _videoController.play();
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  Future<void> _onCommentsTap(BuildContext context) async {
    if (_videoController.value.isPlaying) {
      _onTogglePause();
    }
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const VideoComments(),
    );
    _onTogglePause();
  }

  Future<void> _toggleMute() async {
    if (_isMuted) {
      await _videoController.setVolume(1.0);
    } else {
      await _videoController.setVolume(0.0);
    }

    setState(() {
      _isMuted = !_isMuted;
    });
  }

  Future<void> _onPlaybackConfigChanged() async {
    if (!mounted) return;
    final muted = ref.read(playbackConfigProvider).muted;
    if (muted) {
      _volume = 0.0;
    } else {
      _volume = 1.0;
    }
    await _videoController.setVolume(_volume);
  }

  @override
  void initState() {
    super.initState();
    // ref.listen(playbackConfigProvider, (prev, next) {
    //   if (prev == null) return;
    //   if (prev.muted != next.muted) {
    //     _onPlaybackConfigChanged();
    //   }
    // });

    _isMuted = ref.read(playbackConfigProvider).muted;
    if (_isMuted) _volume = 0.0;

    _initVideoPlayer();
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.pageIndex}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoController.value.aspectRatio,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _videoController.value.size.width,
                        height: _videoController.value.size.height,
                        child: VideoPlayer(_videoController),
                      ),
                    ),
                  )
                : Image(
                    image: NetworkImage(widget.videoData.thumbnailUrl),
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child,
                    );
                  },
                  child: AnimatedOpacity(
                    duration: _animationDuration,
                    opacity: _isPaused ? 1 : 0,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "@${widget.videoData.creator}",
                  style: const TextStyle(
                    fontSize: Sizes.size20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v10,
                SizedBox(
                  width: MediaQuery.of(context).size.width - 100,
                  child: MoreRichText(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    text: widget.videoData.description,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 20,
            top: 40,
            child: GestureDetector(
              onTap: () => _toggleMute(),
              child: Center(
                child: FaIcon(
                  _isMuted
                      ? FontAwesomeIcons.volumeXmark
                      : FontAwesomeIcons.volumeHigh,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            right: 10,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 25,
                  foregroundImage: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/tiktok-clone-c2476.appspot.com/o/avatars%2F${widget.videoData.creatorUid}?alt=media",
                  ),
                  child: Text(widget.videoData.creator),
                ),
                Gaps.v24,
                VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: S.of(context).likeCount(widget.videoData.likes),
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: () => _onCommentsTap(context),
                  child: VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: S.of(context).commentCount(widget.videoData.comments),
                  ),
                ),
                Gaps.v24,
                const VideoButton(
                  icon: FontAwesomeIcons.share,
                  text: "Share",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
