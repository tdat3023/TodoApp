import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hcm23_03/shared/network/app_interceptor.dart';
import 'package:hcm23_03/shared/network/app_logger.dart';

import '../../shared/network/data_state.dart';

Future<DataState<T>> commonApiHelper<T>({
  required CommonApiHelperConfig config,
}) async {
  final Dio dio = Dio();
  dio.interceptors.add(loggerInterceptor);
  try {
    if (config.isShowLoading && AppRepository.shared.isShowLoading$ == false) {
      EasyLoading.show(dismissOnTap: true);
      AppRepository.shared.isShowLoading = true;
      await Future.delayed(const Duration(milliseconds: 300));
    }
    final response = await config.apiFunction;

    if (response != null) {
      config.onSuccess?.call(DataSuccess(data: response, originResponse: null));
      if (config.isShowLoading) {
        EasyLoading.dismiss();
      }
      return DataSuccess(data: response, originResponse: null);
    }
  } catch (err) {
    AppLogger.shared.logException("Common Api Error", err.toString());
  }
  if (config.isShowLoading) {
    EasyLoading.dismiss();
  }
  return DataFailed(dioError: null);
}

class CommonApiHelperConfig<T> {
  final Future<T> apiFunction;
  // final FirebaseApiEnum type;
  final bool isShowLoading;
  final bool isShowErrorDialog;
  final Function(DataSuccess<T>)? onSuccess;
  final Function(String errorCode)? onFailure;
  final String? cacheUuid;

  CommonApiHelperConfig({
    required this.apiFunction,
    // required this.type,
    this.isShowLoading = true,
    this.isShowErrorDialog = true,
    this.onSuccess,
    this.onFailure,
    this.cacheUuid,
  });
}

class AppRepository {
  bool isShowLoading = false;
  bool get isShowLoading$ => isShowLoading; //getter khong the thay doi gia tri

  AppRepository._internal();
  static AppRepository? _instance;
  static AppRepository get shared {
    _instance ??= AppRepository._internal();

    return _instance!;
  }
}
