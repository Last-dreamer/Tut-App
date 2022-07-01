import 'dart:async';

import 'package:tut_app/presentation/base/base_viewmodel.dart';
import 'package:tut_app/presentation/common/freezed_data_classes.dart';

class LoginScreenViewModel extends BaseViewModel
    with LoginScreenViewModelInput, LoginScreenViewModelOutput {
  final StreamController _userControler = StreamController<String>.broadcast();
  final StreamController _passwordControler =
      StreamController<String>.broadcast();

  var loginObject = LoginObject("", "");

  @override
  void dispose() {
    _userControler.close();
    _passwordControler.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  Sink get inputPassword => _passwordControler.sink;

  @override
  Sink get inputUserName => _userControler.sink;

  @override
  void login() {}

  @override
  Stream<bool> get outputIsPasswordValid =>
      _passwordControler.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid =>
      _userControler.stream.map((userName) => _isUserNamValid(userName));

  @override
  // ignore: avoid_renaming_method_parameters
  void setPassword(String password) {
    inputPassword.add(password);
    loginObject.copyWith(password: password);
  }

  @override
  void setUserName(String username) {
    inputUserName.add(username);
    loginObject.copyWith(userName: username);
  }

  _isPasswordValid(String pass) {
    return pass.isNotEmpty;
  }

  _isUserNamValid(String userName) {
    return userName.isNotEmpty;
  }
}

abstract class LoginScreenViewModelInput {
  void setUserName(String username);
  void setPassword(String username);
  void login();
  Sink get inputUserName;
  Sink get inputPassword;
}

abstract class LoginScreenViewModelOutput {
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsPasswordValid;
}
