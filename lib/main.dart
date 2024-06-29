import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictok_clone/constants/theme.dart';
import 'package:tictok_clone/features/videos/repos/playback_config_repo.dart';
import 'package:tictok_clone/features/videos/view_models/playback_config_view_model.dart';
import 'package:tictok_clone/firebase_options.dart';
import 'package:tictok_clone/generated/l10n.dart';
import 'package:tictok_clone/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  final preferences = await SharedPreferences.getInstance();
  final repository = PlaybackConfigRepository(preferences);

  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle.light,
  // );

  GoRouter.optionURLReflectsImperativeAPIs = true;

  runApp(
    ProviderScope(
      overrides: [
        playbackConfigProvider.overrideWith(
          () => PlaybackConfigViewModel(repository),
        ),
      ],
      child: const TikTokApp(),
    ),
  );
}

class TikTokApp extends ConsumerWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    S.load(const Locale("ko"));
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'TikTok Clone',
      // themeMode: context.watch<ThemeConfig>().themeMode,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en"),
        Locale("ko"),
        Locale("es"), // spanish
      ],
      themeMode: ThemeMode.system,
      theme: TikTokTheme.lightTheme,
      darkTheme: TikTokTheme.darkTheme,
      routerConfig: ref.watch(routerProvider),
    );
  }
}
