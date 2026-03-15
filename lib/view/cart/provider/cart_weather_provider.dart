import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/apis/weather_apis.dart';
import '../../../res/models/weather_model.dart';

final cartWeatherProvider = FutureProvider<WeatherModel>((ref) async {
  final raw = await WeatherApis().getWeather(
    lat: "30.205108645284692",
    lng: "71.53462216005558",
  );
  return WeatherModel.fromMap(raw);
});
