import 'dart:async';

import 'package:dio/dio.dart';
import 'package:hcm23_03/features/weather/data/models/weather.dart';

import '../../../../shared/network/app_interceptor.dart';
import '../models/location.dart';

/// Exception thrown when locationSearch fails.
class LocationRequestFailure implements Exception {}

/// Exception thrown when the provided location is not found.
class LocationNotFoundFailure implements Exception {}

/// Exception thrown when getWeather fails.
class WeatherRequestFailure implements Exception {}

/// Exception thrown when weather for provided location is not found.
class WeatherNotFoundFailure implements Exception {}

class OpenMeteoApi {
  OpenMeteoApi(void print);

  // static const _baseUrlWeather = 'api.open-meteo.com';
  // static const _baseUrlGeocoding = 'geocoding-api.open-meteo.com';

  static Future<Location> locationSearch(String cityName) async {
    // cityName = 'Hue';
    final Dio dio = Dio();
    dio.interceptors.add(loggerInterceptor);
    final locationResponse = await dio.get(
        "https://geocoding-api.open-meteo.com/v1/search?name=$cityName&count=1");

    if (locationResponse.statusCode != 200) {
      throw LocationRequestFailure();
    }

    final locationJson = locationResponse.data as Map;

    if (!locationJson.containsKey('results')) throw LocationNotFoundFailure();

    final results = locationJson['results'] as List;

    if (results.isEmpty) throw LocationNotFoundFailure();

    return Location.fromMap(results.first as Map<String, dynamic>);
  }

  ///
  ///
  static Future<WeatherModel> getWeather({
    required double latitude,
    required double longitude,
    required String timezone,
  }) async {
    String hourly =
        "temperature_2m,relativehumidity_2m,dewpoint_2m,precipitation,rain,showers,uv_index,is_day";
    String daily =
        "weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset,uv_index_max,uv_index_clear_sky_max,precipitation_sum,rain_sum,showers_sum,snowfall_sum";
    final Dio dio = Dio();
    dio.interceptors.add(loggerInterceptor);
    final weatherResponse = await dio.get(
        "https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current_weather=true&hourly=$hourly&daily=$daily&timezone=$timezone");

    if (weatherResponse.statusCode != 200) {
      throw WeatherRequestFailure();
    }

    final bodyJson = weatherResponse.data as Map<String, dynamic>;

    if (!bodyJson.containsKey('current_weather')) {
      throw WeatherNotFoundFailure();
    }

    final weatherJson = bodyJson;

    final WeatherModel obj = WeatherModel.fromMap(weatherJson);

    return obj;
  }
}
