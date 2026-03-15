import 'package:dio/dio.dart';

import '../../configs/keys/keys.dart';
import '../configs/network_clients.dart';

class WeatherApis {
  static final NetworkClients _networkClients = NetworkClients();
  final Dio _apiClient = _networkClients.weatherClient;

  Future<Map> getWeather({required String lat, required String lng}) async {
    Map<String, dynamic> queryParams = {
      'lat': lat,
      'lon': lng,
      'appid': AppKeys.weatherKey,
      'units': 'metric',
    };
    final response = await _apiClient.get(
      "/weather",
      queryParameters: queryParams,
    );
    return {...response.data};
  }
}
