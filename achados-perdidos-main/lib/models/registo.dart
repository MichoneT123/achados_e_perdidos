import 'package:perdidos_e_achados/models/categoria.dart';
import 'package:perdidos_e_achados/models/estado.dart';
import 'package:perdidos_e_achados/models/localizacao.dart';

class Itemregister {
  int? id;
  String nome;
  CategoriaDTO categoriaDTO;
  LocalizacaoDTO localizacaoDTO;
  String dataEhoraEncontradoOuPerdido;
  String expriracaoNoFeed;
  EstadoDTO estadoDTO;
  String foto;
  String descricao;

  Itemregister({
    this.id,
    required this.nome,
    required this.categoriaDTO,
    required this.localizacaoDTO,
    required this.dataEhoraEncontradoOuPerdido,
    required this.expriracaoNoFeed,
    required this.estadoDTO,
    required this.foto,
    required this.descricao,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'categoriaDTO': categoriaDTO.toJson(),
      'localizacaoDTO': localizacaoDTO.toJson(),
      'dataEhoraEncontradoOuPerdido': dataEhoraEncontradoOuPerdido,
      'expriracaoNoFeed': expriracaoNoFeed,
      'estadoDTO': estadoDTO.toJson(),
      'foto': foto,
      'descricao': descricao,
    };
  }
}
