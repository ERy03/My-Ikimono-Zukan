import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_ikimono_zukan/env/env.dart';
import 'package:my_ikimono_zukan/view/screens/bottom_navigation.dart';
import 'package:my_ikimono_zukan/view/screens/home_screen.dart';
import 'package:my_ikimono_zukan/view/screens/login_screen.dart';
import 'package:my_ikimono_zukan/view/theme/theme_mode_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  await Supabase.initialize(
    url: Env.supaurl,
    anonKey: Env.key1,
  );
  runApp(
    ProviderScope(
      overrides: [
        // ここでUnimplementedErrorを実際のSharedPreferencesのインスタンスと上書きする
        sharedPreferencesProvider.overrideWith((ref) => prefs),
      ],
      child: EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('ja'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const MyApp(),
      ),
    ),
  );
}

final supabase = Supabase.instance.client;

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeState = ref.watch(themeModeNotifierProvider);
    return MaterialApp(
      title: 'Supabase Flutter',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        navigationBarTheme: const NavigationBarThemeData(
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(
              color: Colors.white,
            ),
          ),
          iconTheme: WidgetStatePropertyAll(
            IconThemeData(
              color: Colors.white,
            ),
          ),
        ),
        iconTheme:
            const IconThemeData(color: Colors.white), // Dark mode icon color
      ),
      themeMode: themeModeState ? ThemeMode.dark : ThemeMode.light,
      home: supabase.auth.currentSession == null
          ? const LoginScreen()
          : const BottomNavigation(),
    );
  }
}

extension ContextExtension on BuildContext {
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? Theme.of(this).colorScheme.error
            : Theme.of(this).snackBarTheme.backgroundColor,
      ),
    );
  }
}
