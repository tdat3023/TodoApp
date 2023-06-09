// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:hcm23_03/features/weather/data/api/open_meteo_api.dart';
import 'package:hcm23_03/features/weather/data/models/location.dart';
import 'package:hcm23_03/shared/network/common_api_helper.dart';
import 'package:hcm23_03/shared/network/data_state.dart';

import '../models/weather.dart';

class WeatherRepo {
  WeatherRepo();
  static Future<DataState<WeatherModel>> getWeatherByCity(String city) async {
    final DataState<Location> response = await commonApiHelper<Location>(
      config: CommonApiHelperConfig<Location>(
        apiFunction: OpenMeteoApi.locationSearch(city),
      ),
    );
    if (response is DataSuccess<Location>) {
      final DataState<WeatherModel> weatherRes =
          await commonApiHelper<WeatherModel>(
        config: CommonApiHelperConfig<WeatherModel>(
          apiFunction: OpenMeteoApi.getWeather(
            latitude: response.data?.latitude ?? 0,
            longitude: response.data?.longtitude ?? 0,
            timezone: response.data?.timezone ?? "",
          ),
        ),
      );
      if (weatherRes is DataSuccess<WeatherModel>) {
        return weatherRes;
      }
    }

    return DataFailed(
      dioError: response.error,
      originResponse: null,
    );
  }
}

// extension on int {
//   WeatherCondition get toCondition {
//     switch (this) {
//       case 0:
//         return WeatherCondition.clear;
//       case 1:
//       case 2:
//       case 3:
//       case 45:
//       case 48:
//         return WeatherCondition.cloudy;
//       case 51:
//       case 53:
//       case 55:
//       case 56:
//       case 57:
//       case 61:
//       case 63:
//       case 65:
//       case 66:
//       case 67:
//       case 80:
//       case 81:
//       case 82:
//       case 95:
//       case 96:
//       case 99:
//         return WeatherCondition.rainy;
//       case 71:
//       case 73:
//       case 75:
//       case 77:
//       case 85:
//       case 86:
//         return WeatherCondition.snowy;
//       default:
//         return WeatherCondition.unknown;
//     }
//   }
// }