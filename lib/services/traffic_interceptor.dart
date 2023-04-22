import 'package:dio/dio.dart';

class TrafficInterceptor extends Interceptor {
  final accessToken = '';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'alternatives': true,
      'annotations': 'state_of_charge,duration',
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': false,
      'access_token': accessToken
    });
    super.onRequest(options, handler);
  }
}
