// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ikimono_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ikimonoRepositoryHash() => r'c46922fda7898b6b0d566c4643b9f3648810132d';

/// See also [ikimonoRepository].
@ProviderFor(ikimonoRepository)
final ikimonoRepositoryProvider =
    AutoDisposeProvider<IkimonoRepository>.internal(
  ikimonoRepository,
  name: r'ikimonoRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$ikimonoRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IkimonoRepositoryRef = AutoDisposeProviderRef<IkimonoRepository>;
String _$fetchIkimonosHash() => r'3b57a7dbf0b840f182af3a621dc878c284bea580';

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

/// See also [fetchIkimonos].
@ProviderFor(fetchIkimonos)
const fetchIkimonosProvider = FetchIkimonosFamily();

/// See also [fetchIkimonos].
class FetchIkimonosFamily extends Family<AsyncValue<List<Ikimono>>> {
  /// See also [fetchIkimonos].
  const FetchIkimonosFamily();

  /// See also [fetchIkimonos].
  FetchIkimonosProvider call({
    required String query,
  }) {
    return FetchIkimonosProvider(
      query: query,
    );
  }

  @override
  FetchIkimonosProvider getProviderOverride(
    covariant FetchIkimonosProvider provider,
  ) {
    return call(
      query: provider.query,
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
  String? get name => r'fetchIkimonosProvider';
}

/// See also [fetchIkimonos].
class FetchIkimonosProvider extends AutoDisposeFutureProvider<List<Ikimono>> {
  /// See also [fetchIkimonos].
  FetchIkimonosProvider({
    required String query,
  }) : this._internal(
          (ref) => fetchIkimonos(
            ref as FetchIkimonosRef,
            query: query,
          ),
          from: fetchIkimonosProvider,
          name: r'fetchIkimonosProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchIkimonosHash,
          dependencies: FetchIkimonosFamily._dependencies,
          allTransitiveDependencies:
              FetchIkimonosFamily._allTransitiveDependencies,
          query: query,
        );

  FetchIkimonosProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  Override overrideWith(
    FutureOr<List<Ikimono>> Function(FetchIkimonosRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchIkimonosProvider._internal(
        (ref) => create(ref as FetchIkimonosRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Ikimono>> createElement() {
    return _FetchIkimonosProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchIkimonosProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchIkimonosRef on AutoDisposeFutureProviderRef<List<Ikimono>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _FetchIkimonosProviderElement
    extends AutoDisposeFutureProviderElement<List<Ikimono>>
    with FetchIkimonosRef {
  _FetchIkimonosProviderElement(super.provider);

  @override
  String get query => (origin as FetchIkimonosProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
