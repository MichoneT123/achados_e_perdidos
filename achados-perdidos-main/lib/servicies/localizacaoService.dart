import 'dart:convert';

import 'package:perdidos_e_achados/Environments.dart';
import 'package:perdidos_e_achados/models/categoria.dart';
import 'package:perdidos_e_achados/models/localizacao.dart';
import 'package:perdidos_e_achados/servicies/tokenService.dart';
import 'package:http/http.dart' as http;

class localizacaoService {
  Future<List<LocalizacaoDTO>?> LocalizacaoDTOFeed() async {
    String? authToken = await AuthService().getToken();
    final url = Uri.parse('$ApiUrl/localizacoes');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJwaXp6dXJnLWFwaSIsImlhdCI6MTcxNzQ2MTE3Niwic3ViIjoieWFuaWNrLnJpYmVpcm8yM0BnbWFpbC5jb20iLCJ1c2VySW5mbyI6eyJ1c2VySWQiOjksImVtYWlsIjoieWFuaWNrLnJpYmVpcm8yM0BnbWFpbC5jb20iLCJ1c2VybmFtZSI6Inlhbmljay5yaWJlaXJvMjNAZ21haWwuY29tIn19.5LRFRHHLR1SDJmIMajou4B5gxgPMIzr0Yk3hpUyf2J0',
        },
      );

      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);

        if (responseData is List) {
          final List<LocalizacaoDTO> LocalizacaoDTOs = responseData
              .map((LocalizacaoDTOData) => LocalizacaoDTO.fromJson(
                  LocalizacaoDTOData as Map<String, dynamic>))
              .toList();

          print('Listing LocalizacaoDTOs successful');
          return LocalizacaoDTOs;
        } else {
          print('Error: Response data is not a list');
          return null;
        }
      } else {
        print(
            'Listing LocalizacaoDTOs failed (status code: ${response.statusCode})');
        print(response.body);
        return null;
      }
    } catch (e) {
      print('Error fetching LocalizacaoDTOs: $e');
      return null;
    }
  }

  Future<int?> registerLocalizacao(LocalizacaoDTO localizacao) async {
    final url = Uri.parse('$ApiUrl/localizacoes/registar');
    final response = await http.post(
      url,
      body: jsonEncode(localizacao.toJson()),
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
