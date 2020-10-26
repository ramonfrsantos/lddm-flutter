class Item {
  String nome;
  bool concluido;

  Item({this.nome, this.concluido});

  Item.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    concluido = json['concluido'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['concluido'] = this.concluido;
    return data;
  }
}