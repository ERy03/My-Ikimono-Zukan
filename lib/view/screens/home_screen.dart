import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_ikimono_zukan/view/components/custom_appbar.dart';
import 'package:my_ikimono_zukan/view/components/custom_search_bar.dart';
import 'package:my_ikimono_zukan/view/theme/theme_mode_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final themeModeState = ref.watch(themeModeNotifierProvider);
    return Scaffold(
      appBar: CustomAppBar(
        themeModeProvider: themeModeState,
        context: context,
        toggle: (_) {
          ref.read(themeModeNotifierProvider.notifier).toggle();
        },
      ),
      body: const Column(
        children: [
          CustomSearchBar(),
        ],
      ),
    );
  }
}
