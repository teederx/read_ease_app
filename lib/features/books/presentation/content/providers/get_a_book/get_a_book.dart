import 'package:read_ease_app/features/books/presentation/content/providers/book_list_provider/book_list_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../data/models/book/book.dart';

part 'get_a_book.g.dart';

@riverpod
class GetABook extends _$GetABook {
  @override
  Book build(String bookId) {
    final books = ref.watch(bookListProvider);
    return books.value!.firstWhere((element)=>element.bookID == bookId);
  }
}