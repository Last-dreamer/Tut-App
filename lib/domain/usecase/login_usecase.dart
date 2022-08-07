import 'package:tut_app/app/functions.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tut_app/data/request/request.dart';
import 'package:tut_app/domain/model/model.dart';
import 'package:tut_app/domain/repository/repository.dart';
import 'package:tut_app/domain/usecase/base_usecase.dart';

class LoginUseCase
    implements BaseUseCase<LoginUseCaseInput, AuthenticationModel> {
  final Repository _repository;
  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, AuthenticationModel>> execute(
      LoginUseCaseInput input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    return _repository.login(LoginRequest(
        email: input.email,
        password: input.password,
        imei: deviceInfo.id,
        deviceType: deviceInfo.name));
  }
}

class LoginUseCaseInput {
  final String email;
  final String password;
  LoginUseCaseInput({
    required this.email,
    required this.password,
  });
}
