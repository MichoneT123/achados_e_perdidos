import 'package:flutter/material.dart';
import 'package:perdidos_e_achados/models/item.dart';
import 'package:perdidos_e_achados/screens/details_item_screen.dart';
import 'package:perdidos_e_achados/servicies/itemService.dart';
import 'package:perdidos_e_achados/widgets_reutilizaveis/postCard.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  List<Item>? itens = [];
  late List<Item>? _itensFiltrados = [];
  String _pesquisa = '';
  late String filtroSelected = 'Todos';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchitens();
  }

  void _fetchitens() async {
    final fetcheditens = await ItemService().itemFeed();

    setState(() {
      itens = fetcheditens;
      _itensFiltrados = fetcheditens;
      _isLoading = false;
    });
  }

  void _filtrarItens(String TipoFiltro, String pesquisa) {
    setState(() {
      if (TipoFiltro == "Localizacao") {
        _itensFiltrados = itens!.where((item) {
          final nomeLocalizacao = item.localizacaoDTO!.nome!.toLowerCase();
          final pesquisaLower = pesquisa.toLowerCase();
          return item.estadoDeDevolucao == "NAO_DEVOLVIDO" &&
              (pesquisa.isEmpty || nomeLocalizacao.contains(pesquisaLower));
        }).toList();
      } else if (TipoFiltro == "Nome" || TipoFiltro == 'Todos') {
        _itensFiltrados = itens!.where((item) {
          final nome = item.nome!.toLowerCase();
          final pesquisaLower = pesquisa.toLowerCase();
          return item.estadoDeDevolucao == "NAO_DEVOLVIDO" &&
              (pesquisa.isEmpty || nome.contains(pesquisaLower));
        }).toList();
      } else if (TipoFiltro == "Categoria") {
        _itensFiltrados = itens!.where((item) {
          final categoria = item.categoriaDTO!.nome!.toLowerCase();
          final pesquisaLower = pesquisa.toLowerCase();
          return item.estadoDeDevolucao == "NAO_DEVOLVIDO" &&
              (pesquisa.isEmpty || categoria.contains(pesquisaLower));
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                DropdownButton<String>(
                  value: filtroSelected,
                  onChanged: (value) {
                    if (value == 'Todos') {
                      setState(() {
                        filtroSelected = value!;
                        _itensFiltrados = itens!;
                        _pesquisa = '';
                      });
                    } else {
                      setState(() {
                        filtroSelected = value!;
                        _filtrarItens(filtroSelected, _pesquisa);
                      });
                    }
                  },
                  items: <String>['Todos', 'Localizacao', 'Categoria', 'Nome']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _pesquisa = value;
                          _filtrarItens(filtroSelected, _pesquisa);
                        });
                      },
                      decoration: InputDecoration(
                        label: Text('Pesquisar'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _isLoading
              ? Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : itens == null
                  ? Center(child: Text("Sem itens"))
                  : Expanded(
                      child: ListView.builder(
                        itemCount: _itensFiltrados!.length,
                        itemBuilder: (context, index) {
                          final item = _itensFiltrados![index];
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ItemDetailsScreen(item: item),
                                    ));
                              },
                              child: PostCard(item: item));
                        },
                      ),
                    ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/add_item");
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
