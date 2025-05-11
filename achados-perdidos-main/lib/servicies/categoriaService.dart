import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:perdidos_e_achados/Environments.dart';
import 'package:perdidos_e_achados/models/categoria.dart';
import 'package:perdidos_e_achados/servicies/tokenService.dart';

class categoriaService {
  Future<List<CategoriaDTO>?> CategoriaDTOFeed() async {
    String? authToken = await AuthService().getToken();
    final url = Uri.parse('$ApiUrl/categorias');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJwaXp6dXJnLWFwaSIsImlhdCI6MTcxNzQ2NDM5NSwic3ViIjoieWFuaWNrLnJpYmVpcm8yM0BnbWFpbC5jb20iLCJ1c2VySW5mbyI6eyJ1c2VySWQiOjksImVtYWlsIjoieWFuaWNrLnJpYmVpcm8yM0BnbWFpbC5jb20iLCJ1c2VybmFtZSI6Inlhbmljay5yaWJlaXJvMjNAZ21haWwuY29tIn19.5ikX0DzGGB1toRpplEWuJlNGkdz2nB16wA5g9G_hvnw',
        },
      );

      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);

        if (responseData is List) {
          final List<CategoriaDTO> CategoriaDTOs = responseData
              .map((CategoriaDTOData) => CategoriaDTO.fromJson(
                  CategoriaDTOData as Map<String, dynamic>))
              .toList();

          CategoriaDTOs.forEach(
            (element) {
              print(element.nome);
            },
          );

          print('Listing CategoriaDTOs successful');
          return CategoriaDTOs;
        } else {
          print('Error: Response data is not a list');
          return null;
        }
      } else {
        print(
            'Listing CategoriaDTOs failed (status code: ${response.statusCode})');
        print(response.body);
        return null;
      }
    } catch (e) {
      print('Error fetching CategoriaDTOs: $e');
      return null;
    }
  }

  Future<int?> registerLocalizacao(CategoriaDTO categoria) async {
    final url = Uri.parse('$ApiUrl/categorias/registar');
    final response = await http.post(
      url,
      body: jsonEncode(categoria.toJson()),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJwaXp6dXJnLWFwaSIsImlhdCI6MTcxNzQ2MTE3Niwic3ViIjoieWFuaWNrLnJpYmVpcm8yM0BnbWFpbC5jb20iLCJ1c2VySW5mbyI6eyJ1c2VySWQiOjksImVtYWlsIjoieWFuaWNrLnJpYmVpcm8yM0BnbWFpbC5jb20iLCJ1c2VybmFtZSI6Inlhbmljay5yaWJlaXJvMjNAZ21haWwuY29tIn19.5LRFRHHLR1SDJmIMajou4B5gxgPMIzr0Yk3hpUyf2J0',
      },
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
}
