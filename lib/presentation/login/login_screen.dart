import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/presentation/common/state_renderer/flow_state.dart';
import 'package:tut_app/presentation/login/login_view_model.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/routes_manger.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';
import 'package:tut_app/presentation/resources/styles_manager.dart';
import 'package:tut_app/presentation/resources/value_manager.dart';

import '../../app/di.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginScreenViewModel _viewModel = instance<LoginScreenViewModel>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _emailController.addListener(() {
      _viewModel.setUserName(_emailController.text);
    });
    _passwordController.addListener(() {
      _viewModel.setPassword(_passwordController.text);
    });

    _viewModel.isUserLoggedIn.stream.listen((isLogin) {
      if (isLogin == true) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacementNamed(context, Routes.mainRoute);
        });
      }
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWiget(context, _getContentWidget(),
                  () {
                _viewModel.login();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return SingleChildScrollView(
      child: Form(
        key: _key,
        child: Column(
          children: [
            const SizedBox(
              height: AppSize.s100,
            ),
            const Image(
              image: AssetImage(ImageAssets.splashLogo),
            ),
            const SizedBox(
              height: AppSize.s28,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p20, right: AppPadding.p20),
              child: StreamBuilder<bool>(
                stream: _viewModel.outputIsUserNameValid,
                builder: (context, snap) {
                  return TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: AppStrings.userName,
                        labelText: AppStrings.userName,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSize.s10)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.error),
                            borderRadius: BorderRadius.circular(AppSize.s10)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSize.s10)),
                        errorText: (snap.data ?? true)
                            ? null
                            : AppStrings.userNameError),
                  );
                },
              ),
            ),
            const SizedBox(
              height: AppSize.s28,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p20, right: AppPadding.p20),
              child: StreamBuilder<bool>(
                stream: _viewModel.outputIsPasswordValid,
                builder: (context, snap) {
                  return TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        hintText: AppStrings.password,
                        labelText: AppStrings.password,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSize.s10)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.error),
                            borderRadius: BorderRadius.circular(AppSize.s10)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSize.s10)),
                        errorText: (snap.data ?? true)
                            ? null
                            : AppStrings.passwordError),
                  );
                },
              ),
            ),
            const SizedBox(
              height: AppSize.s28,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p20, right: AppPadding.p20),
                  child: StreamBuilder(
                    stream: _viewModel.outputIsAllValid,
                    builder: ((context, snapshot) {
                      log("testing snapshot ${snapshot.data}");
                      return ElevatedButton(
                        onPressed: (snapshot.data ?? false)
                            ? () {
                                log("testing buttons ...");
                                _viewModel.login();
                              }
                            : () {
                                log("nullwd");
                              },
                        child: const Text(AppStrings.login),
                      );
                    }),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: AppPadding.p8,
                  left: AppPadding.p20,
                  right: AppPadding.p20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      AppStrings.forgotPassword,
                      style: getRegularStyle(
                        color: ColorManager.darkPrmary,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.registerRoute);
                    },
                    child: Text(
                      AppStrings.registerText,
                      style: getRegularStyle(
                        color: ColorManager.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
