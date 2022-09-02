import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:tut_app/data/responses/response.dart';

import '../../app/constants.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/auth/login/")
  Future<AuthenticationResponse> login(
      @Field("email") String email,
      @Field("password") String password,
      @Field("imei") String imei,
      @Field("deviceType") String deviceType);

  @POST("/auth/singup")
  Future<AuthenticationResponse> register(
      @Field('username') String username,
      @Field("email") String email,
      @Field("password") String password,
      @Field('picture') String picture,
      @Field("imei") String imei,
      @Field("deviceType") String deviceType);
}
