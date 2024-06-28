import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/constants/breakpoints.dart';
import 'package:tictok_clone/features/videos/view_models/playback_config_view_model.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const String routeName = "settings";
  static const String routeURL = "/settings";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final themeConfig = context.watch<ThemeConfig>();
    final videoConfig = ref.watch(playbackConfigProvider);
    final videoConfigNotifier = ref.read(playbackConfigProvider.notifier);
    return Localizations.override(
      context: context,
      // locale: const Locale("es"),
      child: Scaffold(
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
                value: videoConfig.muted,
                onChanged: (value) => videoConfigNotifier.setMuted(value),
                title: const Text("Mute video"),
                subtitle: const Text("Videos will be muted by default."),
              ),
              SwitchListTile.adaptive(
                value: videoConfig.autoplay,
                onChanged: (value) => videoConfigNotifier.setAutoplay(value),
                title: const Text("Autoplay"),
                subtitle:
                    const Text("Videos will start playing automatically."),
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
                value: false,
                onChanged: (value) => {},
                title: const Text("Enable notifications"),
                subtitle: const Text("Enable notifications"),
              ),
              CheckboxListTile.adaptive(
                activeColor: Colors.black,
                value: false,
                onChanged: (value) => {},
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

                  if (kDebugMode) {
                    print(date);
                  }

                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  if (kDebugMode) {
                    print(time);
                  }

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
                  if (kDebugMode) {
                    print(booking);
                  }
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
      ),
    );
  }
}
