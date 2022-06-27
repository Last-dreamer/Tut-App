import 'package:tut_app/data/network/app_api.dart';
import 'package:tut_app/data/request/request.dart';
import 'package:tut_app/data/responses/response.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImplementor extends RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImplementor(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) {
    return _appServiceClient.login(loginRequest.email, loginRequest.password,
        loginRequest.imei, loginRequest.deviceType);
  }
}
