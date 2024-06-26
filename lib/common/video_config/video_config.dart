import 'package:flutter/material.dart';

class ThemeConfig extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  void changeThemeMode(ThemeMode themeMode) {
    themeMode = themeMode;
    notifyListeners();
  }
}

class VideoConfig extends ChangeNotifier {
  bool isMuted = false;
  bool isAutoplay = false;

  void toggleIsMuted() {
    isMuted = !isMuted;
    notifyListeners();
  }

  void toggleAutoplay() {
    isAutoplay = !isAutoplay;
    notifyListeners();
  }
}

// final videoMuteConfig = ValueNotifier(false);
// final themeConfig = ValueNotifier(ThemeMode.system);

// // ChangeNotifier version
//
// class VideoConfig extends ChangeNotifier {
//   bool autoMute = true;

//   void toggleAutoMute() {
//     autoMute = !autoMute;
//     notifyListeners();
//   }
// }

// final videoConfig = VideoConfig();

// // InheritedWidget version
// 
//class VideoConfigData extends InheritedWidget {
//   const VideoConfigData({
//     super.key,
//     required super.child,
//     required this.autoMute,
//     required this.toggleMuted,
//   });

//   final bool autoMute;
//   final Function() toggleMuted;

//   static VideoConfigData of(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<VideoConfigData>()!;
//   }

//   @override
//   bool updateShouldNotify(covariant InheritedWidget oldWidget) {
//     return true;
//   }
// }

// class VideoConfig extends StatefulWidget {
//   const VideoConfig({
//     super.key,
//     required this.child,
//   });

//   final Widget child;

//   @override
//   State<VideoConfig> createState() => _VideoConfigState();
// }

// class _VideoConfigState extends State<VideoConfig> {
//   bool autoMute = false;

//   void toggleMuted() {
//     setState(() {
//       autoMute = !autoMute;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return VideoConfigData(
//       autoMute: autoMute,
//       toggleMuted: toggleMuted,
//       child: widget.child,
//     );
//   }
// }
