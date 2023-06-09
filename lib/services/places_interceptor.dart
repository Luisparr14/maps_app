import 'package:dio/dio.dart';
import 'package:maps_app/enviroment.dart';

class PlacesInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'language': 'es',
      'access_token': Enviroment.accessToken
    });
    super.onRequest(options, handler);
  }
}
