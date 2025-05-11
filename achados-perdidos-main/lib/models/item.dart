import 'package:perdidos_e_achados/models/categoria.dart';
import 'package:perdidos_e_achados/models/estado.dart';
import 'package:perdidos_e_achados/models/localizacao.dart';

import 'package:perdidos_e_achados/models/usuario.dart';

class Item {
  final int? id;
  final String nome;
  final String? estadoDeDevolucao;
  final CategoriaDTO categoriaDTO;
  final LocalizacaoDTO localizacaoDTO;
  final DateTime? dataEhoraEncontradoOuPerdido;
  final DateTime? expriracaoNoFeed;
  final EstadoDTO estadoDTO;
  final String foto;
  final UsuarioDto? usuarioDTO;
  final String? descricao;
  final DateTime? datapublicacao;

  Item({
    this.id,
    required this.nome,
    this.estadoDeDevolucao,
    required this.categoriaDTO,
    required this.localizacaoDTO,
    this.dataEhoraEncontradoOuPerdido,
    this.expriracaoNoFeed,
    required this.estadoDTO,
    required this.foto,
    this.usuarioDTO,
    this.descricao,
    this.datapublicacao,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        id: json["id"],
        nome: json["nome"],
        estadoDeDevolucao: json["estadoDeDevolucao"],
        datapublicacao: DateTime.tryParse(json["datapublicacao"] ?? ""),
        categoriaDTO: CategoriaDTO.fromJson(json["categoriaDTO"]),
        localizacaoDTO: LocalizacaoDTO.fromJson(json["localizacaoDTO"]),
        dataEhoraEncontradoOuPerdido:
            DateTime.tryParse(json["dataEhoraEncontradoOuPerdido"] ?? ""),
        expriracaoNoFeed: DateTime.tryParse(json["expriracaoNoFeed"] ?? ""),
        estadoDTO: EstadoDTO.fromJson(json["estadoDTO"]),
        foto: json["foto"],
        descricao: json["descricao"],
        usuarioDTO: UsuarioDto.fromJson(json["usuarioDTO"]));
  }

  get telefone => null;

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "estadoDeDevolucao": estadoDeDevolucao,
        "categoriaDTO": categoriaDTO?.toJson(),
        "localizacaoDTO": localizacaoDTO?.toJson(),
        "dataEhoraEncontradoOuPerdido":
            dataEhoraEncontradoOuPerdido?.toIso8601String(),
        "expriracaoNoFeed": expriracaoNoFeed?.toIso8601String(),
        "estadoDTO": estadoDTO?.toJson(),
        "foto": foto,
        "usuarioDTO": usuarioDTO?.toJson(),
        "descricao": descricao,
        "datapublicacao": datapublicacao?.toIso8601String()
      };
}
