import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:perdidos_e_achados/models/categoria.dart';
import 'package:perdidos_e_achados/models/estado.dart';
import 'package:perdidos_e_achados/models/item.dart';
import 'package:perdidos_e_achados/models/localizacao.dart';
import 'package:perdidos_e_achados/models/registo.dart';
import 'package:perdidos_e_achados/servicies/categoriaService.dart';
import 'package:perdidos_e_achados/servicies/itemService.dart';
import 'package:perdidos_e_achados/servicies/localizacaoService.dart';
import 'package:perdidos_e_achados/widgets_reutilizaveis/MyInputField.dart';

class FormItemScreen extends StatefulWidget {
  const FormItemScreen({Key? key}) : super(key: key);

  @override
  State<FormItemScreen> createState() => _FormItemScreenState();
}

class _FormItemScreenState extends State<FormItemScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController descricao = TextEditingController();
  final TextEditingController textEditingController = TextEditingController();

  LocalizacaoDTO? localizacaoDTO;
  CategoriaDTO? categoriaDTO;
  EstadoDTO? estadoDTO;
  int? id;
  String? foto = '/';

  XFile? _image;
  List<LocalizacaoDTO>? localizacaoDTOs = [];
  List<CategoriaDTO>? categoriaDTOs = [];
  List<EstadoDTO>? estadoDTOs = [];
  bool _loading = false;
  bool _isUpdate = false;
  bool _isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _fetchAtributos();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchItemInfo();
    });
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedImage;
    });
  }

  void _fetchItemInfo() async {
    final Item? item = ModalRoute.of(context)?.settings.arguments as Item?;

    if (item != null) {
      setState(() {
        foto = item.foto;
        id = item.id;
        _isUpdate = true;
        firstNameController.text = item.nome ?? '';
        descricao.text = item.descricao ?? '';
        localizacaoDTO = item.localizacaoDTO;
        categoriaDTO = item.categoriaDTO;
        estadoDTO = item.estadoDTO;
        textEditingController.text = item.dataEhoraEncontradoOuPerdido != null
            ? DateFormat("yyyy-MM-dd")
                .format(item.dataEhoraEncontradoOuPerdido!)
            : '';
        _isDataLoaded = true;
      });
    } else {
      setState(() {
        _isDataLoaded = true;
      });
    }
  }

  void _fetchAtributos() async {
    try {
      final fetchedLocalizacoes =
          await localizacaoService().LocalizacaoDTOFeed();
      final fetchedCategorias = await categoriaService().CategoriaDTOFeed();

      setState(() {
        localizacaoDTOs = fetchedLocalizacoes;
        categoriaDTOs = fetchedCategorias;
        estadoDTOs = [
          EstadoDTO(id: 2, nome: "Perdido"),
          EstadoDTO(id: 1, nome: "Achado")
        ];

        if (!_isUpdate) {
          localizacaoDTO = fetchedLocalizacoes?.first;
          categoriaDTO = fetchedCategorias?.first;
          estadoDTO = estadoDTOs?.first;
        }
      });
    } catch (e) {
      print('Error fetching attributes: $e');
    }
  }

  void _registerItem() async {
    setState(() {
      _loading = true;
    });
    if (firstNameController.text.isEmpty ||
        localizacaoDTO == null ||
        categoriaDTO == null ||
        estadoDTO == null) {
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    DateTime date = DateFormat("yyyy-MM-dd").parse(textEditingController.text);
    String formattedDateTime =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(date);

    final Itemregister newItem = Itemregister(
      nome: firstNameController.text,
      localizacaoDTO: localizacaoDTO!,
      categoriaDTO: categoriaDTO!,
      estadoDTO: estadoDTO!,
      descricao: descricao.text,
      dataEhoraEncontradoOuPerdido: formattedDateTime,
      expriracaoNoFeed: "2025-05-12T08:00:00Z",
      foto: "/",
    );

    try {
      int? status = await ItemService().registerItem(newItem);
      if (status == 201) {
        setState(() {
          _loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Item registrado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      } else {
        setState(() {
          _loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao registrar o item.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao registrar o item.'),
          backgroundColor: Colors.red,
        ),
      );
      print('Error registering item: $e');
    }
  }

  void _atualizarItem() async {
    setState(() {
      _loading = true;
    });
    if (firstNameController.text.isEmpty ||
        localizacaoDTO == null ||
        categoriaDTO == null ||
        estadoDTO == null) {
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    DateTime date = DateFormat("yyyy-MM-dd").parse(textEditingController.text);
    String formattedDateTime =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(date);

    final Itemregister newItem = Itemregister(
      id: id,
      nome: firstNameController.text,
      localizacaoDTO: localizacaoDTO!,
      categoriaDTO: categoriaDTO!,
      estadoDTO: estadoDTO!,
      descricao: descricao.text,
      dataEhoraEncontradoOuPerdido: formattedDateTime,
      expriracaoNoFeed: "2025-05-12T08:00:00Z",
      foto: foto!,
    );

    try {
      int? status = await ItemService().atualizarItem(newItem);
      if (status == 200) {
        setState(() {
          _loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Item ataulizado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      } else {
        setState(() {
          _loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao atualizar o item.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao atualizar o item.'),
          backgroundColor: Colors.red,
        ),
      );
      print('Error atualizar item: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          _isUpdate ? 'Atualizar Item' : 'Adicionar Item',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: _isDataLoaded
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  if (_image != null) Image.file(File(_image!.path)),
                  ElevatedButton(
                    onPressed: _getImage,
                    child: const Text('Selecionar Imagem'),
                  ),
                  const SizedBox(height: 20),
                  MyInputField(
                    label: "Nome",
                    placeholder: "Insira o nome do item",
                    textEditingController: firstNameController,
                    isPasswordField: false,
                  ),
                  const SizedBox(height: 20),
                  DropdownButton<int>(
                    value: localizacaoDTO?.id,
                    hint: Text(
                      "Selecione a localização",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    icon: RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.chevron_right,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    underline: Container(
                      height: 2,
                      color: Theme.of(context).primaryColor,
                    ),
                    onChanged: (int? idSelecionado) {
                      setState(() {
                        localizacaoDTO = localizacaoDTOs!.firstWhere(
                          (localizacao) => localizacao.id == idSelecionado,
                        );
                      });
                    },
                    items: localizacaoDTOs!
                        .map<DropdownMenuItem<int>>(
                          (localizacao) => DropdownMenuItem<int>(
                            value: localizacao.id!,
                            child: Text(localizacao.nome!),
                          ),
                        )
                        .toList(),
                  ),
                  DropdownButton<int>(
                    value: categoriaDTO?.id,
                    hint: const Text("Selecione uma categoria"),
                    icon: const RotatedBox(
                      quarterTurns: 1,
                      child: Icon(Icons.chevron_right),
                    ),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Theme.of(context).primaryColor,
                    ),
                    onChanged: (int? idSelecionado) {
                      setState(() {
                        categoriaDTO = categoriaDTOs!.firstWhere(
                          (categoria) => categoria.id == idSelecionado,
                        );
                      });
                    },
                    items: categoriaDTOs!
                        .map<DropdownMenuItem<int>>(
                          (categoria) => DropdownMenuItem<int>(
                            value: categoria.id!,
                            child: Text(categoria.nome!),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                  DropdownButton<int>(
                    value: estadoDTO?.id,
                    hint: const Text("Perdido ou encontrado?"),
                    icon: const RotatedBox(
                      quarterTurns: 1,
                      child: Icon(Icons.chevron_right),
                    ),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Theme.of(context).primaryColor,
                    ),
                    onChanged: (int? idSelecionado) {
                      setState(() {
                        estadoDTO = estadoDTOs!.firstWhere(
                          (estado) => estado.id == idSelecionado,
                        );
                      });
                    },
                    items: estadoDTOs!
                        .map<DropdownMenuItem<int>>(
                          (estado) => DropdownMenuItem<int>(
                            value: estado.id!,
                            child: Text(estado.nome!),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                  MyInputField(
                    placeholder: "Selecione a data",
                    textEditingController: textEditingController,
                    label: "Data",
                    isDateField: true,
                    isPasswordField: false,
                  ),
                  const SizedBox(height: 20),
                  MyInputField(
                    label: "Descrição",
                    placeholder: "Insira a descrição do item",
                    textEditingController: descricao,
                    isPasswordField: false,
                    isEmailField: false,
                  ),
                  const SizedBox(height: 20),
                  _loading
                      ? const Center(child: CircularProgressIndicator())
                      : GestureDetector(
                          onTap: _isUpdate ? _atualizarItem : _registerItem,
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
                            child: Center(
                              child: Text(
                                _isUpdate ? "Atualizar" : "Registrar",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
