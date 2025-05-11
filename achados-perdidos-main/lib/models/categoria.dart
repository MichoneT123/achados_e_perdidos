class CategoriaDTO {
  CategoriaDTO({
    required this.id,
    required this.nome,
  });

  final int? id;
  final String? nome;

  factory CategoriaDTO.fromJson(Map<String, dynamic> json) {
    return CategoriaDTO(
      id: json["id"],
      nome: json["nome"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
      };

  @override
  String toString() {
    return "$id, $nome";
  }
}
