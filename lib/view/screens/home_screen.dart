import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_ikimono_zukan/data/repositories/ikimono_repository.dart';
import 'package:my_ikimono_zukan/domain/search_text_notifier.dart';
import 'package:my_ikimono_zukan/view/components/custom_search_bar.dart';
import 'package:my_ikimono_zukan/view/components/ikimono_container.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final query = ref.watch(searchTextNotifierProvider);
    final ikimonoList = ref.watch(fetchIkimonosProvider(query: query));
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomSearchBar(),
            Expanded(
              child: ikimonoList.when(
                loading: () => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
                error: (e, _) => Center(
                  child: Text(e.toString()),
                ),
                data: (ikimonoList) {
                  if (ikimonoList.isEmpty) {
                    return const Center(
                      child: Text('Not found'),
                    );
                  }
                  return GridView.builder(
                    itemCount: ikimonoList.length,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: width < 600 ? 2 : 5,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return IkimonoContainer(
                        ikimono: ikimonoList[index],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
