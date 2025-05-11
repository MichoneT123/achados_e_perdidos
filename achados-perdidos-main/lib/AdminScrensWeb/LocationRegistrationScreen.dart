import 'package:flutter/material.dart';
import 'package:perdidos_e_achados/models/localizacao.dart';
import 'package:perdidos_e_achados/servicies/localizacaoService.dart';
import 'package:perdidos_e_achados/widgets_reutilizaveis/MyInputField.dart';

class LocationRegistrationScreen extends StatefulWidget {
  @override
  _LocationRegistrationScreenState createState() =>
      _LocationRegistrationScreenState();
}

class _LocationRegistrationScreenState
    extends State<LocationRegistrationScreen> {
  final TextEditingController _locationController = TextEditingController();
  List<LocalizacaoDTO>? localizacaoDTOs = [];
  bool _isLoading = false;
  String? nome;

  @override
  void initState() {
    super.initState();
    _fetchLocalizacoes();
  }

  Future<void> _fetchLocalizacoes() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final fetchedLocalizacoes =
          await localizacaoService().LocalizacaoDTOFeed();
      setState(() {
        localizacaoDTOs = fetchedLocalizacoes;
      });
    } catch (e) {
      print('Erro ao buscar localizações: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _addLocalizacao() async {
    if (_locationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha o campo.'),
          backgroundColor: Color.fromARGB(255, 255, 0, 0),
        ),
      );
      return;
    }

    setState(() {
      nome = _locationController.text;
    });

    try {
      final responseStatus = await localizacaoService()
          .registerLocalizacao(LocalizacaoDTO(nome: nome));
      if (responseStatus == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Localização registrada com sucesso.'),
            backgroundColor: Colors.green,
          ),
        );
        _fetchLocalizacoes();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Falha ao registrar localização.'),
            backgroundColor: Color.fromARGB(255, 255, 0, 0),
          ),
        );
      }
    } catch (e) {
      print('Erro ao registrar localização: $e');
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
                    placeholder: "Nome da Localização",
                    textEditingController: _locationController,
                    label: "Localização",
                    isPasswordField: false,
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: _addLocalizacao,
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
            const SizedBox(width: 20),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
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
                        dataTextStyle: const TextStyle(fontSize: 16.0),
                        columns: const [
                          DataColumn(
                            label: Text(
                              'Nome',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'ID',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Ações',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                        rows: localizacaoDTOs!.map((localizacao) {
                          return DataRow(cells: [
                            DataCell(Text(localizacao.nome ?? '')),
                            DataCell(Text(localizacao.id.toString())),
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
                                              // Implement delete functionality here
                                              int? status =
                                                  204; // Update this with the real status from your delete operation
                                              if (status == 204) {
                                                Navigator.of(context).pop();
                                                _fetchLocalizacoes();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content:
                                                        Text('Item apagado.'),
                                                    backgroundColor:
                                                        Colors.green,
                                                  ),
                                                );
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'Item não apagado'),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              }
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
                            )),
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
