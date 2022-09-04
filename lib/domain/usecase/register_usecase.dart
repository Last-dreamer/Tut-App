import 'dart:developer';

import 'package:tut_app/app/functions.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tut_app/data/request/request.dart';
import 'package:tut_app/domain/model/model.dart';
import 'package:tut_app/domain/repository/repository.dart';
import 'package:tut_app/domain/usecase/base_usecase.dart';

class RegisterUseCase
    extends BaseUseCase<RegisterUseCaseInput, AuthenticationModel> {
  final Repository repository;
  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, AuthenticationModel>> execute(
      RegisterUseCaseInput input) async {
    log("testing login ${input.username}");
    DeviceInfo deviceInfo = await getDeviceDetails();
    return  repository.register(RegisterRequest(
        username: input.username,
        email: input.email,
        password: input.password,
        confirmPassword: input.confirmPassword,
        picture: input.picture,
        imei: deviceInfo.id,
        deviceType: deviceInfo.name));
  }
}

class RegisterUseCaseInput {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;
  final String picture;

  RegisterUseCaseInput(
      {required this.username,
      required this.email,
      required this.password,
      required this.confirmPassword,
      required this.picture});
}
