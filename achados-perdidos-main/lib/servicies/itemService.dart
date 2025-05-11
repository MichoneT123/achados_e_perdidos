import 'dart:convert';

import 'package:perdidos_e_achados/Environments.dart';
import 'package:perdidos_e_achados/models/item.dart';
import 'package:http/http.dart' as http;
import 'package:perdidos_e_achados/models/registo.dart';
import 'package:perdidos_e_achados/servicies/tokenService.dart';

class ItemService {
  Future<int?> registerItem(Itemregister item) async {
    String? authToken = await AuthService().getToken();
    final url = Uri.parse('$ApiUrl/itens/registar');
    final response = await http.post(
      url,
      body: jsonEncode(item.toJson()),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 201) {
      print(response.body);
      return 201;
    } else {
      print(response.body);
      return response.statusCode;
    }
  }

  Future<int?> atualizarItem(Itemregister item) async {
    String? authToken = await AuthService().getToken();
    final url = Uri.parse('$ApiUrl/itens/update/${item.id}');
    final response = await http.put(
      url,
      body: jsonEncode(item.toJson()),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      return 200;
    } else {
      print(response.body);
      return response.statusCode;
    }
  }

  Future<int?> delete(int id) async {
    String? authToken = await AuthService().getToken();
    final url = Uri.parse('$ApiUrl/itens/delete/$id');
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );
    print(response.statusCode);

    return response.statusCode;
  }

  Future<List<Item>?> itemFeed() async {
    String? authToken = await AuthService().getToken();
    final url = Uri.parse('$ApiUrl/itens/feed');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);

        if (responseData is List) {
          final List<Item> items = responseData
              .map(
                  (itemData) => Item.fromJson(itemData as Map<String, dynamic>))
              .toList();

          print('Listing items successful');
          return items;
        } else {
          print('Error: Response data is not a list');
          return null;
        }
      } else {
        print('Listing items failed (status code: ${response.statusCode})');
        print(response.body);
        return null;
      }
    } catch (e) {
      print('Error fetching items: $e');
      return null;
    }
  }

  Future<List<Item>?> itensUsuarioLogado() async {
    String? authToken = await AuthService().getToken();
    if (authToken == null) {
      print('Error: Authentication token is null');
      return null;
    }

    final url = Uri.parse('$ApiUrl/itens/itens_do_usuario_logado');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);

        if (responseData is List) {
          final List<Item> items = responseData
              .map(
                  (itemData) => Item.fromJson(itemData as Map<String, dynamic>))
              .toList();

          print('Listing items successful');
          return items;
        } else {
          print('Error: Response data is not a list');
          return null;
        }
      } else {
        print('Listing items failed (status code: ${response.statusCode})');
        print(response.body);
        return null;
      }
    } catch (e) {
      print('Error fetching items: $e');
      return null;
    }
  }
}
