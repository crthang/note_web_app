import 'cloud_store.dart';

/// Interface
abstract class Repository<T> {
  CloudStore cloudStore;

  Future<dynamic> insert(T item);

  Future<dynamic> update(T item);

  Future<dynamic> delete(T item);

  Future<List<T>> items();
}
