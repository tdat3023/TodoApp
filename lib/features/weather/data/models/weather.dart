// To parse this JSON data, do
//
//     final weather = weatherFromMap(jsonString);

import 'dart:convert';

class WeatherModel {
  WeatherModel({
    required this.latitude,
    required this.longitude,
    required this.generationtimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.currentWeather,
    required this.hourly,
    required this.daily,
  });

  final double latitude;
  final double longitude;
  final double generationtimeMs;
  final int utcOffsetSeconds;
  final String timezone;
  final String timezoneAbbreviation;
  final double elevation;
  final CurrentWeather? currentWeather;
  final Hourly? hourly;
  final Daily? daily;

  factory WeatherModel.fromJson(String str) =>
      WeatherModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromMap(Map<String, dynamic> json) => WeatherModel(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        generationtimeMs: json["generationtime_ms"]?.toDouble(),
        utcOffsetSeconds: json["utc_offset_seconds"],
        timezone: json["timezone"],
        timezoneAbbreviation: json["timezone_abbreviation"],
        elevation: json["elevation"]?.toDouble(),
        currentWeather: CurrentWeather.fromMap(json["current_weather"]),
        hourly: Hourly.fromMap(json["hourly"]),
        daily: Daily.fromMap(json["daily"]),
      );

  Map<String, dynamic> toMap() => {
        "latitude": latitude,
        "longitude": longitude,
        "generationtime_ms": generationtimeMs,
        "utc_offset_seconds": utcOffsetSeconds,
        "timezone": timezone,
        "timezone_abbreviation": timezoneAbbreviation,
        "elevation": elevation,
        "current_weather": currentWeather?.toMap(),
        "hourly": hourly?.toMap(),
        "daily": daily?.toMap(),
      };
}

class CurrentWeather {
  CurrentWeather({
    required this.temperature,
    required this.windspeed,
    required this.winddirection,
    required this.weathercode,
    required this.isDay,
    required this.time,
  });

  final double temperature;
  final double windspeed;
  final double winddirection;
  final int weathercode;
  final int isDay;
  final String time;

  factory CurrentWeather.fromJson(String str) =>
      CurrentWeather.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CurrentWeather.fromMap(Map<String, dynamic> json) => CurrentWeather(
        temperature: json['temperature'],
        windspeed: json["windspeed"]?.toDouble(),
        winddirection: json["winddirection"],
        weathercode: json["weathercode"],
        isDay: json["is_day"],
        time: json["time"],
      );

  Map<String, dynamic> toMap() => {
        "temperature": temperature,
        "windspeed": windspeed,
        "winddirection": winddirection,
        "weathercode": weathercode,
        "is_day": isDay,
        "time": time,
      };
}

class Hourly {
  final List relativehumidity;
  final List rain;
  final List uvIndex;

  Hourly({
    required this.relativehumidity,
    required this.rain,
    required this.uvIndex,
  });

  factory Hourly.fromJson(String str) => Hourly.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory Hourly.fromMap(Map<String, dynamic> json) => Hourly(
        relativehumidity: json['relativehumidity_2m']?.toList(),
        rain: json['rain']?.toList(),
        uvIndex: json['uv_index']?.toList(),
      );

  Map<String, dynamic> toMap() => {
        "relativehumidity_2m": relativehumidity,
        "rain": rain,
        "uv_index": uvIndex,
      };
}

class Daily {
  final List sunrise;
  final List sunset;
  final List uvIndexMax;
  final List rainSum;
  final List tempMax;
  final List tempMin;

  Daily({
    required this.sunrise,
    required this.sunset,
    required this.uvIndexMax,
    required this.rainSum,
    required this.tempMax,
    required this.tempMin,
  });

  factory Daily.fromJson(String str) => Daily.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory Daily.fromMap(Map<String, dynamic> json) => Daily(
        sunrise: json['sunrise']?.toList(),
        sunset: json['sunset']?.toList(),
        uvIndexMax: json['uv_index_max']?.toList(),
        rainSum: json['rain_sum'].toList(),
        tempMax: json['temperature_2m_max'].toList(),
        tempMin: json['temperature_2m_min'].toList(),
      );

  Map<String, dynamic> toMap() => {
        "sunrise": sunrise,
        "sunset": sunset,
        "uv_index_max": uvIndexMax,
        "rain_sum": rainSum,
        "temperature_2m_max": tempMax,
        "temperature_2m_min": tempMin,
      };
}
