abstract class BaseModelSqlite<T> {
  T fromObject(Map<String, dynamic> map);
  Map<String, dynamic> toObject();
}
