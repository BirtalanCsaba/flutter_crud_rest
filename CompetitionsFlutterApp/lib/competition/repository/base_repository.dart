import '../models/competition_model.dart';

abstract class BaseRepository <T, ID> {
  Future<List<T>> get();
  Future<T?> findById(ID id);
  Future<T> add(T item);
  Future<void> update(T item);
  Future<void> delete(ID id);
  Future<void> populate(List<T> items);
}