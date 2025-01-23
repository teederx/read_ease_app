import '../../data/models/book/book.dart';

class UserEntity {
  final String id;
  final String name;
  final String email;
  final List<Book> books;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.books,
  });
}

class UserDetails {
  final String id;
  final String name;
  final String email;

  UserDetails({
    required this.id,
    required this.name,
    required this.email,
  });
}
