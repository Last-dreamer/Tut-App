import 'package:dartz/dartz.dart';
import 'package:tut_app/data/request/request.dart';
import '../../data/network/failure.dart';
import '../model/model.dart';

abstract class Repository {
  Future<Either<Failure, AuthenticationModel>> login(LoginRequest loginRequest);
}
