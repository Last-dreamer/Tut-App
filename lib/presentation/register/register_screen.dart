import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';

import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/common/state_renderer/flow_state.dart';
import 'package:tut_app/presentation/register/register_view_model.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/routes_manger.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';
import 'package:tut_app/presentation/resources/styles_manager.dart';
import 'package:tut_app/presentation/resources/value_manager.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _key = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  var picker = instance<ImagePicker>();

  _bind() async {
    _viewModel.start();

    _usernameController.addListener(() {
      _viewModel.setUsername(_usernameController.text);
    });
    _emailController.addListener(() {
      _viewModel.setEmail(_emailController.text);
    });
    _passwordController.addListener(() {
      _viewModel.setPassword(_passwordController.text);
    });
    _confirmPasswordController.addListener(() {
      _viewModel.setConfirmPassword(_confirmPasswordController.text);
    });

    _viewModel.isUserRegistered.stream.listen((event) {
      if(event == true){
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          Navigator.pushReplacementNamed(context, Routes.mainRoute);
        });
      }
    });
  }

  @override
  void initState() {
    _bind();
    //  node = FocusNode().requestFocus(node);
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snap) {
            return snap.data?.getScreenWiget(context, _getContentWidget()!, () {
                  _viewModel.register();
                }) ??
                _getContentWidget();
          }),
    );
  }

  _getContentWidget() {
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
            // username
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p20, right: AppPadding.p20),
              child: StreamBuilder<String?>(
                  stream: _viewModel.outputUsernameError,
                  builder: (context, snap) {
                    log("testing user name input");
                    return TextFormField(
                      controller: _usernameController,
                      keyboardType: TextInputType.text,
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
                          errorText: snap.data ?? ""),
                    );
                  }),
            ),
            const SizedBox(
              height: AppSize.s28,
            ),
            // email
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p20, right: AppPadding.p20),
              child: StreamBuilder<String?>(
                  stream: _viewModel.outputEmailError,
                  builder: (context, snap) {
                    return TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: AppStrings.email,
                          labelText: AppStrings.email,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppSize.s10)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: ColorManager.error),
                              borderRadius: BorderRadius.circular(AppSize.s10)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppSize.s10)),
                          errorText: snap.data),
                    );
                  }),
            ),
            const SizedBox(
              height: AppSize.s28,
            ),
            // password
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p20, right: AppPadding.p20),
              child: StreamBuilder<String?>(
                  stream: _viewModel.outputPasswordError,
                  builder: (context, snap) {
                    return TextFormField(
                      obscureText: true,
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
                          errorText: snap.data),
                    );
                  }),
            ),
            const SizedBox(
              height: AppSize.s28,
            ),
            // confirm password
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p20, right: AppPadding.p20),
              child: StreamBuilder<String?>(
                  stream: _viewModel.outputConfirmPasswordError,
                  builder: (context, snap) {
                    return TextFormField(
                      obscureText: true,
                      controller: _confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          hintText: AppStrings.confirmPassword,
                          labelText: AppStrings.confirmPassword,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppSize.s10)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: ColorManager.error),
                              borderRadius: BorderRadius.circular(AppSize.s10)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppSize.s10)),
                          errorText: snap.data),
                    );
                  }),
            ),
            const SizedBox(
              height: AppSize.s28,
            ),
            // picture
            Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p20,
                  right: AppPadding.p20,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s10),
                      border: Border.all(color: ColorManager.black)),
                  child: GestureDetector(
                    child: _getMediaWidget(),
                    onTap: () {
                      _showPicker(context);
                    },
                  ),
                )),
            const SizedBox(
              height: AppSize.s28,
            ),
            // register or signup button
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder<bool?>(
                  stream: _viewModel.outputIsAllValid,
                  builder: (context, snapshot) {
                    return Padding(
                        padding: const EdgeInsets.only(
                            left: AppPadding.p20, right: AppPadding.p20),
                        child: ElevatedButton(
                          onPressed: (snapshot.data ?? false)
                              ? () {
                                  _viewModel.register();
                                }
                              : null,
                          child: const Text(AppStrings.signup),
                        ));
                  }),
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
                      "",
                      style: getRegularStyle(
                        color: ColorManager.darkPrmary,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.loginroute);
                    },
                    child: Text(
                      AppStrings.loginText,
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

  _getMediaWidget() {
    return Padding(
      padding:
          const EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Flexible(child: Text(AppStrings.picture)),
          Flexible(
            child: StreamBuilder<File?>(
                stream: _viewModel.outputIsPictureValid,
                builder: (context, snap) {
                  return _pickedImage(snap.data ?? File(""));
                }),
          ),
          const Flexible(child: Icon(Icons.camera_alt))
        ],
      ),
    );
  }

  _pickedImage(File file) {
    if (file.path.isNotEmpty) {
      return Image.file(file);
    } else {
      return Container();
    }
  }

  _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
              child: Wrap(
            children: [
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.camera),
                title: const Text(AppStrings.gallery),
                onTap: () {
                  _imageFromGallery();
                },
              ),
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.camera_alt_rounded),
                title: const Text(AppStrings.camera),
                onTap: () {
                  _imageFromCamera();
                  Navigator.pop(context);
                },
              ),
            ],
          ));
        });
  }

  _imageFromGallery() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    _viewModel.setPic(File(image?.path ?? ""));
  }

  _imageFromCamera() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    _viewModel.setPic(File(image?.path ?? ""));
  }
}
