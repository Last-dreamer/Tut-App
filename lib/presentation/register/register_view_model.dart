import 'dart:async';
import 'dart:io';

import 'package:tut_app/presentation/base/base_viewmodel.dart';

class RegisterViewModel extends BaseViewModel {
  final StreamController<String> _usernameController =
      StreamController<String>.broadcast();

  final StreamController<String> _emailController =
      StreamController<String>.broadcast();

  final StreamController<String> _passowrdController =
      StreamController<String>.broadcast();

  final StreamController<String> _confirmPasswordController =
      StreamController<String>.broadcast();

  final StreamController<File> _pictureController =
      StreamController<File>.broadcast();

  @override
  void start() {}

  @override
  void dispose() {
    _usernameController.close();
    _emailController.close();
    _passowrdController.close();
    _confirmPasswordController.close();
    _pictureController.close();
  }
}

abstract class RegisterViewModelInput {
  register();
  Sink get inputUserName;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputConfirmPassword;
  Sink get inputPicture;
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outputIsUsernameValid;
  Stream<String> get outputUsernameError;

  Stream<bool> get outputIsEmailValid;
  Stream<String> get outputEmailError;

  Stream<bool> get outputIsPasswordValid;
  Stream<String> get outputPasswordError;

  Stream<bool> get outputIsConfirmPasswordValid;
  Stream<String> get outputConfirmPasswordError;

  Stream<File> get outputIsPictureValid;
}
