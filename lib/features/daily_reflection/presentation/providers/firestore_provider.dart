import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/reflection_repository_impl.dart';

final reflectionRepositoryProvider = Provider<ReflectionRepositoryImpl>(
  (ref) => ReflectionRepositoryImpl(),
);

final reflectionsStreamProvider = StreamProvider<List<Map<String, dynamic>>>((ref) {
  return ref.watch(reflectionRepositoryProvider).getReflections();
});
