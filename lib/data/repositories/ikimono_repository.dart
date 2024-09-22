import 'package:my_ikimono_zukan/domain/ikimono.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'ikimono_repository.g.dart';

class IkimonoRepository {
  IkimonoRepository({required this.supabaseClient});

  final SupabaseClient supabaseClient;

  Future<List<Ikimono>> fetchIkimono() async {
    final response = await supabaseClient
        .from('ikimono')
        .select(
            'id, name, description, user, location, tag, captured_date, ikimono_url')
        .eq('user', supabaseClient.auth.currentUser!.id);
    return response.map(Ikimono.fromJson).toList();
  }
}

@Riverpod(keepAlive: true)
IkimonoRepository ikimonoRepository(
  IkimonoRepositoryRef ref,
) {
  return IkimonoRepository(supabaseClient: Supabase.instance.client);
}

@Riverpod(keepAlive: true)
Future<List<Ikimono>> fetchIkimono(
  FetchIkimonoRef ref,
) {
  return ref.watch(ikimonoRepositoryProvider).fetchIkimono();
}
