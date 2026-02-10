import 'dart:convert';

import 'package:http/http.dart' as http;

class Openweather {
  final String apiKey;

  const Openweather({required this.apiKey});

  Future<Map> getWeatherDetails({
    required double lat,
    required double lon,
  }) async {
    print('weather details');

    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'units': 'metric',
      'appid': apiKey,
    });

    var res = await http.get(url); // Remove Uri.parse(), add await
    print('Response status: ${res.statusCode}');
    print('Response body: ${res.body}');
    print('done');
    return jsonDecode(res.body);
  }

  Future<List<dynamic>> getTodoDetails() async {
    print('todo details');
    var url2 = Uri.https('jsonplaceholder.typicode.com', 'posts/1/comments');
    var res2 = await http.get(url2);
    print('response body : ${res2.body}');
    print('done');
    return jsonDecode(res2.body);
  }

  String getWeatherIcon(String icon) {
    return "https://openweathermap.org/img/wn/$icon@4x.png";
  }
}
