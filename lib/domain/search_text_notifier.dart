import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_text_notifier.g.dart';

@riverpod
class SearchTextNotifier
    extends _$SearchTextNotifier {
  @override
  String build() {
    return '';
  }

  // ignore: use_setters_to_change_properties
  void setQuery(String query) {
    state = query;
  }
}
