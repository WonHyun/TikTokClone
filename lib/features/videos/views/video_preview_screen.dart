import 'dart:io';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:tictok_clone/features/videos/view_models/upload_video_view_model.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends ConsumerStatefulWidget {
  const VideoPreviewScreen({
    super.key,
    required this.video,
    required this.isPicked,
  });

  final XFile video;
  final bool isPicked;

  @override
  ConsumerState<VideoPreviewScreen> createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends ConsumerState<VideoPreviewScreen> {
  late final VideoPlayerController _videoController;

  bool _savedVideo = false;

  Future<void> _initVideo() async {
    _videoController = VideoPlayerController.file(
      File(widget.video.path),
    );

    await _videoController.initialize();
    await _videoController.setLooping(true);
    await _videoController.play();
    setState(() {});
  }

  Future<void> _saveToGallery() async {
    if (_savedVideo) return;

    await GallerySaver.saveVideo(
      widget.video.path,
      albumName: "TikTok Clone!",
    );

    _savedVideo = true;
    setState(() {});
  }

  Future<void> _onUploadPressed() async {
    await ref.read(uploadVideoProvider.notifier).uploadVideo(
          File(widget.video.path),
          context,
        );
  }

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Preview video"),
        actions: [
          if (!widget.isPicked)
            IconButton(
              onPressed: _saveToGallery,
              icon: FaIcon(
                _savedVideo
                    ? FontAwesomeIcons.check
                    : FontAwesomeIcons.download,
              ),
            ),
          IconButton(
            onPressed: ref.watch(uploadVideoProvider).isLoading
                ? null
                : _onUploadPressed,
            icon: ref.watch(uploadVideoProvider).isLoading
                ? const CircularProgressIndicator()
                : const FaIcon(
                    FontAwesomeIcons.cloudArrowUp,
                  ),
          ),
        ],
      ),
      body: _videoController.value.isInitialized
          ? Center(
              child: SizedBox(
                height: _videoController.value.aspectRatio > 1
                    ? null
                    : MediaQuery.of(context).size.width,
                child: Transform.rotate(
                  angle: _videoController.value.aspectRatio > 1 ? 0 : pi / 2,
                  child: AspectRatio(
                    aspectRatio: _videoController.value.aspectRatio > 1
                        ? _videoController.value.aspectRatio
                        : 1 / _videoController.value.aspectRatio,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _videoController.value.aspectRatio > 1
                            ? _videoController.value.size.width
                            : _videoController.value.size.height,
                        height: _videoController.value.aspectRatio > 1
                            ? _videoController.value.size.height
                            : _videoController.value.size.width,
                        child: VideoPlayer(_videoController),
                      ),
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
