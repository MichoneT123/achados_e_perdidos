import 'package:flutter/material.dart';
import 'package:perdidos_e_achados/models/categoria.dart';
import 'package:perdidos_e_achados/servicies/categoriaService.dart';
import 'package:perdidos_e_achados/widgets_reutilizaveis/MyInputField.dart';

class CategoryRegistrationScreen extends StatefulWidget {
  @override
  _CategoryRegistrationScreenState createState() =>
      _CategoryRegistrationScreenState();
}

class _CategoryRegistrationScreenState
    extends State<CategoryRegistrationScreen> {
  List<CategoriaDTO>? categories = [];
  final TextEditingController _nameController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchCategorias();
  }

  Future<void> _fetchCategorias() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final fetchedCategorias = await categoriaService().CategoriaDTOFeed();
      setState(() {
        categories = fetchedCategorias;
      });
    } catch (e) {
      print('Erro ao buscar categorias: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _addCategoria() async {
    final String name = _nameController.text;
    if (name.isEmpty) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await categoriaService()
          .registerLocalizacao(CategoriaDTO(nome: name, id: null));
      _nameController.clear();
      _fetchCategorias();
    } catch (e) {
      print('Erro ao adicionar categoria: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteCategoria(int id) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final status = 9;
      if (status == 204) {
        _fetchCategorias();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Item apagado.'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Item não apagado'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Erro ao deletar categoria: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyInputField(
                    placeholder: "Nome da Categoria",
                    textEditingController: _nameController,
                    label: "Categoria",
                    isPasswordField: false,
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: _addCategoria,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14),
                          bottomLeft: Radius.circular(14),
                          bottomRight: Radius.circular(14),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Registrar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : categories == null
                        ? Center(child: Text('Erro ao carregar categorias'))
                        : DataTable(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(14),
                                bottomLeft: Radius.circular(14),
                                bottomRight: Radius.circular(14),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 16,
                                  color: Colors.black.withOpacity(.2),
                                ),
                              ],
                            ),
                            columnSpacing: 32.0,
                            dataTextStyle: TextStyle(fontSize: 16.0),
                            columns: [
                              DataColumn(
                                label: Text(
                                  'Nome',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'ID',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Ações',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                            rows: categories!.map((categoria) {
                              return DataRow(cells: [
                                DataCell(Text(categoria.nome ?? '')),
                                DataCell(Text(categoria.id.toString())),
                                DataCell(Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        // Handle edit action
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.orange,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text("Excluir"),
                                            content: const Text(
                                              "Tem certeza?",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () async {
                                                  //  await _deleteCategoria(categoria.id);
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Sim"),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Não"),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        // Handle view action
                                      },
                                      icon: const Icon(
                                        Icons.remove_red_eye_sharp,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ))
                              ]);
                            }).toList(),
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
