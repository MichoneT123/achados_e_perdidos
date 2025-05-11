import 'package:flutter/material.dart';
import 'package:perdidos_e_achados/models/item.dart'; // Importe o modelo do item
import 'package:url_launcher/url_launcher.dart'; // Importe o pacote para fazer chamadas e enviar mensagens

class ItemDetailsScreen extends StatelessWidget {
  final Item item;

  ItemDetailsScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Detalhes do Item'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              item.foto,
              height: 200,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 16.0),
            Text(
              item.nome,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Categoria: ${item.categoriaDTO.nome}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Localização: ${item.localizacaoDTO.nome}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Data e Hora Encontrado ou Perdido: ${item.dataEhoraEncontradoOuPerdido != null ? item.dataEhoraEncontradoOuPerdido!.toString() : 'N/A'}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            SizedBox(height: 8.0),
            Text(
              'Estado: ${item.estadoDTO.nome}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Descrição: ${item.descricao ?? 'N/A'}',
              style: TextStyle(fontSize: 18.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    if (item.usuarioDTO?.telefone != null) {
                      await launchUrl(
                          Uri.parse('tel:${item.usuarioDTO!.telefone}'));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Numero de telefone nao encontrado.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.phone,
                    color: Colors.green,
                  ),
                  label: const Text('Ligar'),
                  style: ElevatedButton.styleFrom(),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (item.usuarioDTO?.telefone != null) {
                      String message =
                          'Mensagem sobre o item ${item.nome} encontrado em ${item.localizacaoDTO.nome}. Descrição: ${item.descricao ?? 'N/A'}';

                      Uri smsUri = Uri(
                        scheme: 'sms',
                        path: item.usuarioDTO!.telefone,
                        queryParameters: {'body': message},
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Numero de telefone nao encontrado.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.sms,
                    color: Colors.green,
                  ),
                  label: const Text('SMS'),
                  style: ElevatedButton.styleFrom(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
