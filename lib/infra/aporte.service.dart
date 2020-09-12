import 'package:http/http.dart' as http;
import 'package:InvestAportes/model/aporte.dart';
import 'dart:convert';

class AporteService {
  final String apiUrl = 'https://invest-aportes-api.herokuapp.com/v1/api/aportes';

  Future<List<Aporte>> fetchAportesByUserIdAndAno(int userId, int ano) async {
    final response = await http.get('$apiUrl?usuarioId=$userId&ano=$ano');
    if(response.statusCode == 200 ){
      Iterable resultList = json.decode(response.body);
      return resultList.map((model) => Aporte.fromJson(model)).toList();
    }else{
      throw Exception('Erro ao obter aportes');
    }
  }

  Future<void> saveAporte(Aporte aporte) async {
    aporte.usuarioid = 1;
    var body = jsonEncode(aporte);
    final response = await http.post('$apiUrl', headers: {'Content-Type': 'application/json; charset=UTF-8',}, body: body);
    if(response.statusCode != 201 ){
      throw Exception('Erro ao salvar aporte');
    }
  }

  Future<void> delete(int id) async {
    final response = await http.delete('$apiUrl/$id');
    if(response.statusCode != 204 ){
      throw Exception('Erro ao deletar aporte');
    }
  }
}