class Produto {
  int id;
  String name;

  Produto(this.id, this.name);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
    };
    return map;
  }

  Produto.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }
}
