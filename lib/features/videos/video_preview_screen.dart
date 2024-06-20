import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends StatefulWidget {
  const VideoPreviewScreen({
    super.key,
    required this.video,
    required this.isPicked,
  });

  final XFile video;
  final bool isPicked;

  @override
  State<VideoPreviewScreen> createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
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
        ],
      ),
      body: _videoController.value.isInitialized
          // ? Transform.rotate(
          //     angle: 90 * 3.14 / 180,
          //     child: AspectRatio(
          //       aspectRatio: _videoController.value.aspectRatio,
          //       child: FittedBox(
          //         fit: BoxFit.cover,
          //         child: SizedBox(
          //           width: _videoController.value.size.height,
          //           height: _videoController.value.size.width,
          //           child: VideoPlayer(_videoController),
          //         ),
          //       ),
          //     ),
          //   )
          ? SizedBox(
              width: _videoController.value.size.width,
              height: _videoController.value.size.height,
              child: VideoPlayer(_videoController),
            )
          : null,
    );
  }
}
