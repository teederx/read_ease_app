// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bookListHash() => r'6e162d283b479363a4f0f3d7d7e73c60d71fcdde';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$BookList
    extends BuildlessAutoDisposeAsyncNotifier<List<Book>> {
  late final String userId;

  FutureOr<List<Book>> build(
    String userId,
  );
}

/// See also [BookList].
@ProviderFor(BookList)
const bookListProvider = BookListFamily();

/// See also [BookList].
class BookListFamily extends Family<AsyncValue<List<Book>>> {
  /// See also [BookList].
  const BookListFamily();

  /// See also [BookList].
  BookListProvider call(
    String userId,
  ) {
    return BookListProvider(
      userId,
    );
  }

  @override
  BookListProvider getProviderOverride(
    covariant BookListProvider provider,
  ) {
    return call(
      provider.userId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'bookListProvider';
}

/// See also [BookList].
class BookListProvider
    extends AutoDisposeAsyncNotifierProviderImpl<BookList, List<Book>> {
  /// See also [BookList].
  BookListProvider(
    String userId,
  ) : this._internal(
          () => BookList()..userId = userId,
          from: bookListProvider,
          name: r'bookListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$bookListHash,
          dependencies: BookListFamily._dependencies,
          allTransitiveDependencies: BookListFamily._allTransitiveDependencies,
          userId: userId,
        );

  BookListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  FutureOr<List<Book>> runNotifierBuild(
    covariant BookList notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(BookList Function() create) {
    return ProviderOverride(
      origin: this,
      override: BookListProvider._internal(
        () => create()..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<BookList, List<Book>>
      createElement() {
    return _BookListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BookListProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin BookListRef on AutoDisposeAsyncNotifierProviderRef<List<Book>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _BookListProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<BookList, List<Book>>
    with BookListRef {
  _BookListProviderElement(super.provider);

  @override
  String get userId => (origin as BookListProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
