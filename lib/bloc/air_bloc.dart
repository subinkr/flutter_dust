import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dust/models/air_result.dart';
import 'package:rxdart/rxdart.dart';

class AirBloc {
  final _airSubject = BehaviorSubject<AirResult>();
  AirBloc() {
   fetch();
  }
  Future<AirResult> fetch() async {
    print('fetch');
    var airResult = await fetchData();
    _airSubject.add(airResult);
  }

  Future<AirResult> fetchData() async {
    var response = await http.get('https://api.airvisual.com/v2/nearest_city?key=0f77b530-2d4d-4691-b98c-57760202a5f9');
    AirResult result = AirResult.fromJson(json.decode(response.body));
    return result;
  }
  Stream<AirResult> get airResult => _airSubject.stream;
}