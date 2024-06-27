import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tictok_clone/constants/breakpoints.dart';
import 'package:tictok_clone/features/videos/view_models/playback_config_view_model.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = false;

  void _onNotificationChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _notifications = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final themeConfig = context.watch<ThemeConfig>();
    // final videoConfig = context.watch<VideoConfig>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: Breakpoints.md,
        ),
        child: ListView(
          children: [
            // ListTile(
            //   title: const Text("Dark Theme"),
            //   subtitle: const Text("Enable dark theme."),
            //   trailing: SizedBox(
            //     width: 150,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         IconButton(
            //           onPressed: () =>
            //               themeConfig.changeThemeMode(ThemeMode.system),
            //           icon: Icon(
            //             FontAwesomeIcons.gear,
            //             color: ThemeMode.system == themeConfig.themeMode
            //                 ? Colors.amber
            //                 : Theme.of(context).colorScheme.inverseSurface,
            //           ),
            //         ),
            //         IconButton(
            //           onPressed: () =>
            //               themeConfig.changeThemeMode(ThemeMode.dark),
            //           icon: Icon(
            //             FontAwesomeIcons.solidMoon,
            //             color: ThemeMode.dark == themeConfig.themeMode
            //                 ? Colors.amber
            //                 : Theme.of(context).colorScheme.inverseSurface,
            //           ),
            //         ),
            //         IconButton(
            //           onPressed: () =>
            //               themeConfig.changeThemeMode(ThemeMode.light),
            //           icon: Icon(
            //             FontAwesomeIcons.solidSun,
            //             color: ThemeMode.light == themeConfig.themeMode
            //                 ? Colors.amber
            //                 : Theme.of(context).colorScheme.inverseSurface,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            SwitchListTile.adaptive(
              value: context.watch<PlaybackConfigViewModel>().muted,
              onChanged: (value) =>
                  context.read<PlaybackConfigViewModel>().setMuted(value),
              title: const Text("Mute video"),
              subtitle: const Text("Videos will be muted by default."),
            ),
            SwitchListTile.adaptive(
              value: context.watch<PlaybackConfigViewModel>().autoplay,
              onChanged: (value) =>
                  context.read<PlaybackConfigViewModel>().setAutoplay(value),
              title: const Text("Autoplay"),
              subtitle: const Text("Videos will start playing automatically."),
            ),
            // AnimatedBuilder(
            //   animation: videoMuteConfig,
            //   builder: (context, child) {
            //     return Builder(
            //       builder: (context) {
            //         return SwitchListTile.adaptive(
            //           value: videoMuteConfig.value,
            //           onChanged: (value) =>
            //               videoMuteConfig.value = !videoMuteConfig.value,
            //           title: const Text("Mute video"),
            //           subtitle: const Text("Videos will be muted by default."),
            //         );
            //       },
            //     );
            //   },
            // ),
            SwitchListTile.adaptive(
              value: _notifications,
              onChanged: _onNotificationChanged,
              title: const Text("Enable notifications"),
              subtitle: const Text("Enable notifications"),
            ),
            CheckboxListTile.adaptive(
              activeColor: Colors.black,
              value: _notifications,
              onChanged: _onNotificationChanged,
              title: const Text("Enable notifications"),
            ),
            ListTile(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1980),
                  lastDate: DateTime(2030),
                );
                print(date);
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                print(time);
                final booking = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(1980),
                  lastDate: DateTime(2030),
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData(
                        appBarTheme: const AppBarTheme(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                print(booking);
              },
              title: const Text("What is your birthday?"),
            ),
            ListTile(
              title: const Text("Log out (iOS)"),
              textColor: Colors.red,
              onTap: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Text("Are your sure?"),
                    content: const Text("Please don't go"),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("No"),
                      ),
                      CupertinoDialogAction(
                        onPressed: () => Navigator.pop(context),
                        isDestructiveAction: true,
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("Log out (Android)"),
              textColor: Colors.red,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    icon: const FaIcon(FontAwesomeIcons.skull),
                    title: const Text("Are your sure?"),
                    content: const Text("Please don't go"),
                    actions: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const FaIcon(FontAwesomeIcons.car),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("Log out (iOS / Bottom)"),
              textColor: Colors.red,
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                    title: const Text("Are your sure?"),
                    message: const Text("please dooont goooooo"),
                    actions: [
                      CupertinoActionSheetAction(
                        isDefaultAction: true,
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Not log out"),
                      ),
                      CupertinoActionSheetAction(
                        isDestructiveAction: true,
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Yes plz."),
                      ),
                    ],
                  ),
                );
              },
            ),
            const AboutListTile(),
          ],
        ),
      ),
    );
  }
}
