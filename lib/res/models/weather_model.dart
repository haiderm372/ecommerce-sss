class WeatherModel {
  final String cityName;
  final String country;
  final double temp;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final String description;
  final String icon;

  const WeatherModel({
    required this.cityName,
    required this.country,
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.description,
    required this.icon,
  });

  factory WeatherModel.fromMap(Map map) {
    return WeatherModel(
      cityName: map['name'] as String? ?? '',
      country: (map['sys'] as Map?)?.containsKey('country') == true
          ? map['sys']['country'] as String
          : '',
      temp: ((map['main'] as Map?)?['temp'] ?? 0).toDouble(),
      feelsLike: ((map['main'] as Map?)?['feels_like'] ?? 0).toDouble(),
      humidity: ((map['main'] as Map?)?['humidity'] ?? 0) as int,
      windSpeed: ((map['wind'] as Map?)?['speed'] ?? 0).toDouble(),
      description: ((map['weather'] as List?)?.isNotEmpty == true
          ? (map['weather'][0] as Map?)?.containsKey('description') == true
                ? map['weather'][0]['description'] as String
                : ''
          : ''),
      icon: ((map['weather'] as List?)?.isNotEmpty == true
          ? (map['weather'][0] as Map?)?.containsKey('icon') == true
                ? map['weather'][0]['icon'] as String
                : ''
          : ''),
    );
  }

  String get iconUrl => 'https://openweathermap.org/img/wn/$icon@2x.png';
}
