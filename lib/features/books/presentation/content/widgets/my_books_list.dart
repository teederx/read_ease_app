import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/book/book.dart';
import 'book_tiles.dart';

class MyBooksList extends StatefulWidget {
  const MyBooksList({
    super.key,
    required this.ref,
    required this.books,
  });

  final WidgetRef ref;
  final List<Book> books;

  @override
  State<MyBooksList> createState() => _MyBooksListState();
}

class _MyBooksListState extends State<MyBooksList> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 0.5,
      controller: _scrollController,
      child: Align(
        alignment: AlignmentDirectional.topStart,
        child: ListView.separated(
          controller: _scrollController,
          shrinkWrap: true,
          reverse: true,
          itemBuilder: (context, index) {
            final myBook = widget.books[index];
            final bookID = myBook.bookID;
            final image = myBook.imageURL;
            return BookTiles(
              myBook: myBook,
              image: image,
              ref: widget.ref,
              bookID: bookID,
            );
          },
          separatorBuilder: (context, _) => const Divider(),
          itemCount: widget.books.length,
        )..reverse,
      ),
    );
  }
}
