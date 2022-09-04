import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:tut_app/domain/usecase/register_usecase.dart';
import 'package:tut_app/presentation/base/base_viewmodel.dart';
import 'package:tut_app/presentation/common/freezed_data_classes.dart';
import 'package:tut_app/presentation/common/state_renderer/flow_state.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
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

  final StreamController _isAllValidController = StreamController.broadcast();
  final StreamController isUserRegistered = StreamController<bool>();


  var registerObject = RegisterObject("", "", "", "", "");
  final RegisterUseCase? registerUseCase;

  RegisterViewModel(this.registerUseCase);

  @override
  void start() {
    _validate();
    inputState.add(ContantState());
  }

  @override
  register() async {

    inputState
        .add(LoadingState(renderer: StateRendererType.POPUP_LOADING_STATE));

    log("tesitng register usecase ${registerObject.userName}");
    (await registerUseCase?.execute(RegisterUseCaseInput(
            username: registerObject.userName,
            email: registerObject.email,
            password: registerObject.password,
            confirmPassword: registerObject.confirmPassword,
            picture: registerObject.profilePicture)))?.fold((l) {
      inputState.add(ErrorState(
          renderer: StateRendererType.POPUP_ERROR_STATE, message: l.message));
      log("Something is wrong");
      isUserRegistered.add(false);
    }, (r) {
      inputState.add(ContantState());
      isUserRegistered.add(true);
    });
  }

  @override
  void dispose() {
    _usernameController.close();
    _emailController.close();
    _passowrdController.close();
    _confirmPasswordController.close();
    _pictureController.close();
    isUserRegistered.close();
  }

  @override
  Sink get inputConfirmPassword => _confirmPasswordController.sink;

  @override
  Sink get inputEmail => _emailController.sink;

  @override
  Sink get inputPassword => _passowrdController.sink;

  @override
  Sink get inputPicture => _pictureController.sink;

  @override
  Sink get inputUserName => _usernameController.sink;

  @override
  Stream<bool> get outputIsUsernameValid =>
      _usernameController.stream.map((e) => _isUserNameValid(e));

  @override
  Stream<String?> get outputUsernameError => outputIsUsernameValid
      .map((event) => event ? null : "UserName should not be empty");

  @override
  Stream<String?> get outputEmailError =>
      outputIsEmailValid.map((e) => e ? null : "Email should not be empty");

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailController.stream.map((e) => _isEmailValid(e));

  @override
  Stream<String?> get outputPasswordError => outputIsPasswordValid
      .map((event) => event ? null : "Password should not be empty");

  @override
  Stream<bool> get outputIsPasswordValid =>
      _passowrdController.stream.map((e) => _isPasswordValid(e));

  @override
  Stream<String?> get outputConfirmPasswordError => outputIsConfirmPasswordValid
      .map((e) => e ? null : "Password does not match");

  @override
  Stream<bool> get outputIsConfirmPasswordValid =>
      _confirmPasswordController.stream
          .map((event) => _confirmPasswordValid(event));

  @override
  Stream<File> get outputIsPictureValid =>
      _pictureController.stream.map((file) => file);

  _isUserNameValid(String username) {
    return username.isNotEmpty;
  }

  _isEmailValid(String email) {
    return email.isNotEmpty;
  }

  _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  _confirmPasswordValid(String confirmPassword) {

    return confirmPassword.isNotEmpty;
  }

  @override
  setConfirmPassword(String confirmPassword) {
    inputConfirmPassword.add(confirmPassword);
    if (_confirmPasswordValid(confirmPassword)) {
      registerObject =
          registerObject.copyWith(confirmPassword: confirmPassword);
    } else {
      registerObject = registerObject.copyWith(confirmPassword: "");
    }
    _validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (_isEmailValid(email)) {
      registerObject = registerObject.copyWith(email: email);
    } else {
      registerObject = registerObject.copyWith(email: "");
    }
    _validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (_isPasswordValid(password)) {
      registerObject = registerObject.copyWith(password: password);
    } else {
      registerObject = registerObject.copyWith(password: "");
    }
    _validate();
  }

  @override
  setPic(File picture) {
    inputPicture.add(picture);
    if (picture.path.isNotEmpty) {
      registerObject = registerObject.copyWith(profilePicture: picture.path);
    } else {
      registerObject = registerObject.copyWith(profilePicture: "");
    }
    _validate();
  }

  @override
  setUsername(String username) {
    inputUserName.add(username);
    if (_isUserNameValid(username)) {
      registerObject = registerObject.copyWith(userName: username);
    } else {
      registerObject = registerObject.copyWith(userName: '');
    }
    _validate();
  }

  bool _isAllValid() {

    return registerObject.userName.isNotEmpty &&
        registerObject.email.isNotEmpty &&
        registerObject.password.isNotEmpty &&
        registerObject.confirmPassword.isNotEmpty &&
        registerObject.profilePicture.isNotEmpty;
  }

  _validate() {
    _isAllValidController.add(null);
  }

  @override
  Sink get inputAllValid => _isAllValidController.sink;

  @override
  Stream<bool?> get outputIsAllValid =>
      _isAllValidController.stream.map((_) => _isAllValid());
}

abstract class RegisterViewModelInput {
  register();
  setUsername(String username);
  setEmail(String email);

  setPassword(String password);
  setConfirmPassword(String confirmPassword);
  setPic(File picture);

  Sink get inputUserName;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputConfirmPassword;
  Sink get inputPicture;
  Sink get inputAllValid;
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outputIsUsernameValid;
  Stream<String?> get outputUsernameError;

  Stream<bool?> get outputIsEmailValid;
  Stream<String?> get outputEmailError;

  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputPasswordError;

  Stream<bool> get outputIsConfirmPasswordValid;
  Stream<String?> get outputConfirmPasswordError;

  Stream<File> get outputIsPictureValid;
  Stream<bool?> get outputIsAllValid;
}
