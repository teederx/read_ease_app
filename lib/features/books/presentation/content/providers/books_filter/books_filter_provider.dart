import 'package:read_ease_app/features/books/data/models/book/book.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'books_filter_provider.g.dart';

@riverpod
class BooksFilter extends _$BooksFilter {
  @override
  Filter build() {
    return Filter.all;
  }

  void changeFilter(Filter newFilter){
    state = newFilter;
  }
}