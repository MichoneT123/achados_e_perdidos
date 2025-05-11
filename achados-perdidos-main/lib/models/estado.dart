class EstadoDTO {
  EstadoDTO({
    required this.id,
    required this.nome,
  });

  final int? id;
  final String? nome;

  factory EstadoDTO.fromJson(Map<String, dynamic> json){
    return EstadoDTO(
      id: json["id"],
      nome: json["nome"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "nome": nome,
  };

  @override
  String toString(){
    return "$id, $nome, ";
  }
}