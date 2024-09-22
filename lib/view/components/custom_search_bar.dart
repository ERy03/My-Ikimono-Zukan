import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_ikimono_zukan/domain/search_text_notifier.dart';
import 'package:my_ikimono_zukan/generated/locale_keys.g.dart';

class CustomSearchBar extends ConsumerStatefulWidget {
  const CustomSearchBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomSearchBarState();
}

class _CustomSearchBarState extends ConsumerState<CustomSearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      child: SafeArea(
        top: false,
        bottom: false,
        child: SearchBar(
          onTapOutside: (_) => FocusManager.instance.primaryFocus
              ?.unfocus(), //キーボードが表示されてる時、キーボード以外の画面をタップするとキーボードが表示されなくなる
          elevation: WidgetStateProperty.all(1),
          shadowColor: WidgetStateProperty.all(Colors.transparent),
          controller: _searchController,
          padding: const WidgetStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          leading: const Icon(Icons.search),
          hintText: LocaleKeys.search.tr(),
          onChanged: (text) => {
            ref.read(searchTextNotifierProvider.notifier).setQuery(text),
          },
        ),
      ),
    );
  }
}
