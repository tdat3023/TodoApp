// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'weather_cubit.dart';

abstract class WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  String? city;
  Location? responseLocation;
  DataState<WeatherModel>? responseWeather;
  WeatherLoaded({
    required this.city,
    required this.responseLocation,
    required this.responseWeather,
  });

  WeatherLoaded copyWith({
    String? city,
    Location? responseLocation,
    DataState<WeatherModel>? responseWeather,
  }) {
    return WeatherLoaded(
      city: city ?? this.city,
      responseLocation: responseLocation ?? this.responseLocation,
      responseWeather: responseWeather ?? this.responseWeather,
    );
  }
}
