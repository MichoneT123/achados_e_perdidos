class LocalizacaoDTO {
  LocalizacaoDTO({
    this.id,
    this.nome,
  });

  final int? id;
  final String? nome;

  factory LocalizacaoDTO.fromJson(Map<String, dynamic> json) {
    return LocalizacaoDTO(
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
