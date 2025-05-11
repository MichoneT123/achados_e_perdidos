import 'dart:convert';

import 'package:perdidos_e_achados/Environments.dart';
import 'package:perdidos_e_achados/models/usuario.dart';

import 'package:http/http.dart' as http;
import 'package:perdidos_e_achados/servicies/tokenService.dart';

class UserService {
  Future<int?> registerUser(UsuarioDto user) async {
    final url = Uri.parse('$ApiUrl/usuarios/registar');
    final response = await http.post(
      url,
      body: jsonEncode(user.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      print(response.body);
      return response.statusCode;
    } else {
      print('Registration failed');
      print(response.body);
      return response.statusCode;
    }
  }

  Future<int?> loginUser(String email, String password) async {
    final url = Uri.parse('$ApiUrl/usuarios/login');
    final response = await http.post(
      url,
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      var token = responseData['token'];
      await AuthService().saveToken(token);
      print('Login successful');
      print(response.body);

      return response.statusCode;
    } else {
      print('Login failed');
      print(response.body);
      return response.statusCode;
    }
  }

  Future<UsuarioDto?> userDetails() async {
    String? authToken = await AuthService().getToken();
    final url = Uri.parse('$ApiUrl/usuarios/usuario-logado');

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
    });

    if (response.statusCode == 200) {
      final dynamic responseData = jsonDecode(response.body);
      try {
        UsuarioDto usuarioDto = UsuarioDto.fromJson(responseData);
        return usuarioDto;
      } catch (e) {
        print('Erro ao converter os dados: $e');
        return null;
      }
    } else {
      print('Código de status da resposta: ${response.statusCode}');
      return null;
    }
  }

  Future<int?> updateUser(UsuarioDto usuarioDto) async {
    String? token = await AuthService().getToken();
    final url = Uri.parse('$ApiUrl/usuarios/update/${usuarioDto.id}');
    final response = await http.put(
      url,
      body: jsonEncode(usuarioDto.toJson()),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
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
}
