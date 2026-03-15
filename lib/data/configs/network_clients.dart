import 'package:dio/dio.dart';

class NetworkClients {
  Dio get weatherClient {
    return Dio(
      BaseOptions(
        baseUrl: "https://api.openweathermap.org/data/2.5",
        contentType: 'application/json',
        responseType: ResponseType.json,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        validateStatus: (status) => true,
      ),
    );
  }
}
