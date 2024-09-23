import 'dart:async';
import 'package:my_ikimono_zukan/domain/ikimono.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'ikimono_repository.g.dart';

class IkimonoRepository {
  IkimonoRepository({required this.supabaseClient});

  final SupabaseClient supabaseClient;

  Future<List<Ikimono>> fetchIkimono() async {
    final response = await supabaseClient.from('ikimono').select(
      '''
id, name, description, user, location, tag, captured_date, ikimono_url''',
    ).eq('user', supabaseClient.auth.currentUser!.id);
    return response.map(Ikimono.fromJson).toList();
  }

  Future<List<Ikimono>> searchIkimono(String query) async {
    final response = await supabaseClient
        .from('ikimono')
        .select(
          '''
id, name, description, user, location, tag, captured_date, ikimono_url''',
        )
        .eq('user', supabaseClient.auth.currentUser!.id)
        .ilike('name', '%$query%');
    return response.map(Ikimono.fromJson).toList();
  }

  Future<void> deleteIkimono(int ikimonoId, String name) async {
    await supabaseClient.from('ikimono').delete().eq('id', ikimonoId);
  }
}

@riverpod
IkimonoRepository ikimonoRepository(
  IkimonoRepositoryRef ref,
) {
  return IkimonoRepository(supabaseClient: Supabase.instance.client);
}

@riverpod
Future<List<Ikimono>> fetchIkimonos(
  FetchIkimonosRef ref, {
  required String query,
}) async {
  await Future<void>.delayed(const Duration(milliseconds: 500));
  final repository = ref.watch(ikimonoRepositoryProvider);
  final link = ref.keepAlive();
  Timer? timer;
  ref.onDispose(() {
    timer?.cancel();
  });
  ref.onCancel(() {
    timer = Timer(const Duration(seconds: 30), link.close);
  });
  ref.onResume(() {
    timer?.cancel();
  });

  if (query.isEmpty) {
    return repository.fetchIkimono();
  } else {
    return repository.searchIkimono(query);
  }
}
