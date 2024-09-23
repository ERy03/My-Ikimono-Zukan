import 'package:my_ikimono_zukan/domain/profile.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'profile_repository.g.dart';

class ProfileRepository {
  ProfileRepository({required this.supabaseClient});

  final SupabaseClient supabaseClient;

  Future<Profile> fetchUser() async {
    final response = await supabaseClient
        .from('profiles')
        .select('id, username, avatar_url')
        .eq('id', supabaseClient.auth.currentUser!.id);
    return Profile.fromJson(response.first);
  }
}

@Riverpod(keepAlive: true)
ProfileRepository profileRepository(
  ProfileRepositoryRef ref,
) {
  return ProfileRepository(supabaseClient: Supabase.instance.client);
}

@Riverpod(keepAlive: true)
Future<Profile> fetchUser(
  FetchUserRef ref,
) {
  return ref.watch(profileRepositoryProvider).fetchUser();
}
