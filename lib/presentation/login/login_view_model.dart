import 'dart:async';
import 'dart:developer';
import 'package:tut_app/domain/usecase/login_usecase.dart';
import 'package:tut_app/presentation/base/base_viewmodel.dart';
import 'package:tut_app/presentation/common/freezed_data_classes.dart';

class LoginScreenViewModel extends BaseViewModel
    with LoginScreenViewModelInput, LoginScreenViewModelOutput {
  final StreamController _userControler = StreamController<String>.broadcast();
  final StreamController _passwordControler =
      StreamController<String>.broadcast();

  final StreamController _isLoginValid = StreamController<void>.broadcast();

  var loginObject = LoginObject("", "");

  LoginUseCase? loginUseCase;

  LoginScreenViewModel(loginUseCase);

  @override
  void dispose() {
    _userControler.close();
    _passwordControler.close();
  }

  @override
  void start() {}

  @override
  Sink get inputPassword => _passwordControler.sink;

  @override
  Sink get inputUserName => _userControler.sink;

  @override
  void login() async {
    (await loginUseCase!.execute(LoginUseCaseInput(
            email: loginObject.userName, password: loginObject.password)))
        .fold((failure) {
      log(failure.message);
    }, (data) {
      log(data.customerModel!.name.toString());
    });
  }

  @override
  Stream<bool> get outputIsPasswordValid =>
      _passwordControler.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid =>
      _userControler.stream.map((userName) => _isUserNamValid(userName));

  @override
  Sink get inputAll => _isLoginValid.sink;

  @override
  Stream<bool> get outputIsAllValid =>
      _isLoginValid.stream.map((_) => _isAllLoginValid());

  @override
  void setPassword(String password) {
    inputPassword.add(password);
    loginObject.copyWith(password: password);
    _validate();
  }

  @override
  void setUserName(String username) {
    inputUserName.add(username);
    loginObject.copyWith(userName: username);
    _validate();
  }

  bool _isPasswordValid(String pass) {
    return pass.length < 3 ? false : true;
  }

  _isUserNamValid(String userName) {
    return userName.isNotEmpty;
  }

  bool _isAllLoginValid() {
    log("testing all d ${loginObject}");
    return true;
  }

  _validate() {
    _isLoginValid.add(null);
  }
}

abstract class LoginScreenViewModelInput {
  void setUserName(String username);
  void setPassword(String username);
  void login();
  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputAll;
}

abstract class LoginScreenViewModelOutput {
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputIsAllValid;
}
