import 'dart:async';
import 'dart:developer';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tut_app/domain/usecase/login_usecase.dart';
import 'package:tut_app/presentation/base/base_viewmodel.dart';
import 'package:tut_app/presentation/common/freezed_data_classes.dart';
import 'package:tut_app/presentation/common/state_renderer/flow_state.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';

class LoginScreenViewModel extends BaseViewModel
    with LoginScreenViewModelInput, LoginScreenViewModelOutput {
  final StreamController _userControler = StreamController<String>.broadcast();
  final StreamController _passwordControler =
      StreamController<String>.broadcast();

  final StreamController _isLoginValid = StreamController<void>.broadcast();

  final StreamController isUserLoggedIn = StreamController<bool>();

  LoginObject loginObject = LoginObject("", "");

  final LoginUseCase _loginUseCase;

  LoginScreenViewModel(this._loginUseCase);

  @override
  void dispose() {
    _userControler.close();
    _passwordControler.close();
    _isLoginValid.close();
    isUserLoggedIn.close();
  }

  @override
  void start() {
    inputState.add(ContantState());
  }

  @override
  Sink get inputPassword => _passwordControler.sink;

  @override
  Sink get inputUserName => _userControler.sink;

  @override
  void login() async {
    inputState
        .add(LoadingState(renderer: StateRendererType.POPUP_LOADING_STATE));

    (await _loginUseCase.execute(LoginUseCaseInput(
            email: loginObject.userName, password: loginObject.password)))
        .fold((failure) {
      inputState.add(ErrorState(
          renderer: StateRendererType.POPUP_ERROR_STATE,
          message: failure.message));

      isUserLoggedIn.add(false);
      log("testing failure ${failure.message}");
    }, (success) {
      isUserLoggedIn.add(true);
      inputState.add(ContantState());
      log("success.message }");
    });
  }

  @override
  Stream<bool> get outputIsPasswordValid {
    return _passwordControler.stream.map((password) {
      return _isPasswordValid(password);
    });
  }

  @override
  Stream<bool> get outputIsUserNameValid =>
      _userControler.stream.map((userName) => _isUserNamValid(userName));

  @override
  Sink get inputAll => _isLoginValid.sink;

  @override
  Stream<bool> get outputIsAllValid =>
      _isLoginValid.stream.map((_) => _isAllLoginValid());

  @override
  // ignore: avoid_renaming_method_parameters
  void setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    _validate();
  }

  @override
  void setUserName(String username) {
    inputUserName.add(username);
    loginObject = loginObject.copyWith(userName: username);
    _validate();
  }

  bool _isPasswordValid(String pass) {
    return pass.length < 3 ? false : true;
  }

  _isUserNamValid(String userName) {
    return userName.isNotEmpty;
  }

  bool _isAllLoginValid() {
    log("checking user ${_isUserNamValid(loginObject.userName) && _isPasswordValid(loginObject.password)}");
    return _isUserNamValid(loginObject.userName) &&
        _isPasswordValid(loginObject.password);
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
