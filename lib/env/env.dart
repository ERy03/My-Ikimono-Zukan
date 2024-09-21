import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'KEY1', obfuscate: true)
  static final String key1 = _Env.key1;
  @EnviedField(varName: 'SUPAURL', obfuscate: true)
  static final String supaurl = _Env.supaurl;
}
