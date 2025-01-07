import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_search_provider.g.dart';

@riverpod
class BookSearch extends _$BookSearch {
  @override
  String build() {
    return '';
  }

  void setSearchTerm({required String newSearchTerm}){
    state = newSearchTerm;
  }
}