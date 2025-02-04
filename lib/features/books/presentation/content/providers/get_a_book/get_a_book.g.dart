// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_a_book.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getABookHash() => r'd6a237366f9cfae76ca15f32d9d5c6e38fb731d4';

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

abstract class _$GetABook extends BuildlessAutoDisposeNotifier<Book> {
  late final String bookId;

  Book build(
    String bookId,
  );
}

/// See also [GetABook].
@ProviderFor(GetABook)
const getABookProvider = GetABookFamily();

/// See also [GetABook].
class GetABookFamily extends Family<Book> {
  /// See also [GetABook].
  const GetABookFamily();

  /// See also [GetABook].
  GetABookProvider call(
    String bookId,
  ) {
    return GetABookProvider(
      bookId,
    );
  }

  @override
  GetABookProvider getProviderOverride(
    covariant GetABookProvider provider,
  ) {
    return call(
      provider.bookId,
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
  String? get name => r'getABookProvider';
}

/// See also [GetABook].
class GetABookProvider extends AutoDisposeNotifierProviderImpl<GetABook, Book> {
  /// See also [GetABook].
  GetABookProvider(
    String bookId,
  ) : this._internal(
          () => GetABook()..bookId = bookId,
          from: getABookProvider,
          name: r'getABookProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getABookHash,
          dependencies: GetABookFamily._dependencies,
          allTransitiveDependencies: GetABookFamily._allTransitiveDependencies,
          bookId: bookId,
        );

  GetABookProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.bookId,
  }) : super.internal();

  final String bookId;

  @override
  Book runNotifierBuild(
    covariant GetABook notifier,
  ) {
    return notifier.build(
      bookId,
    );
  }

  @override
  Override overrideWith(GetABook Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetABookProvider._internal(
        () => create()..bookId = bookId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        bookId: bookId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<GetABook, Book> createElement() {
    return _GetABookProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetABookProvider && other.bookId == bookId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, bookId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetABookRef on AutoDisposeNotifierProviderRef<Book> {
  /// The parameter `bookId` of this provider.
  String get bookId;
}

class _GetABookProviderElement
    extends AutoDisposeNotifierProviderElement<GetABook, Book>
    with GetABookRef {
  _GetABookProviderElement(super.provider);

  @override
  String get bookId => (origin as GetABookProvider).bookId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
