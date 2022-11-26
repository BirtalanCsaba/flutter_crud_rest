abstract class BaseModel <ID> {
  ID? id;

  Map<String, dynamic> toJson();
}