import 'package:dio/dio.dart';
import 'package:maps_app/enviroment.dart';

class TrafficInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'alternatives': true,
      'annotations': 'state_of_charge,duration',
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': false,
      'access_token': Enviroment.accessToken
    });
    super.onRequest(options, handler);
  }
}
