import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_mode_provider.g.dart';

// SharedPreferencesのインスタンスがないので, UnimplementedErrorをthrowする
// 参考：https://riverpod.dev/docs/concepts/scopes#initialization-of-synchronous-provider-for-async-apis
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(SharedPreferencesRef ref) {
  throw UnimplementedError();
}

@Riverpod(keepAlive: true)
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  bool build() {
    final preferences = ref.watch(sharedPreferencesProvider);
    return preferences.getBool('darkMode') ?? false;
  }

  void toggle() {
    final preferences = ref.read(sharedPreferencesProvider);
    final currentMode = state;
    state = !currentMode;
    preferences.setBool('darkMode', state);
  }
}
