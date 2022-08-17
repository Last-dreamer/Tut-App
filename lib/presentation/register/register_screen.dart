import 'package:flutter/material.dart';
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
  final _pictureController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getContentWidget(),
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
              child: TextFormField(
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
                  // errorText: (snap.data ?? true)
                  //     ? null
                  //     : AppStrings.userNameError),
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.s28,
            ),
            // email
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p20, right: AppPadding.p20),
              child: TextFormField(
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
                  // errorText: (snap.data ?? true)
                  //     ? null
                  //     : AppStrings.userNameError),
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.s28,
            ),
            // password
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p20, right: AppPadding.p20),
              child: TextFormField(
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
                  // errorText: (snap.data ?? true)
                  //     ? null
                  //     : AppStrings.userNameError),
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.s28,
            ),
            // confirm password
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p20, right: AppPadding.p20),
              child: TextFormField(
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
                  // errorText: (snap.data ?? true)
                  //     ? null
                  //     : AppStrings.userNameError),
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.s28,
            ),
            // picture
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p20, right: AppPadding.p20),
              child: TextFormField(
                controller: _pictureController,
                decoration: InputDecoration(
                  hintText: AppStrings.picture,
                  labelText: AppStrings.picture,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSize.s10)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorManager.error),
                      borderRadius: BorderRadius.circular(AppSize.s10)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSize.s10)),
                  // errorText: (snap.data ?? true)
                  //     ? null
                  //     : AppStrings.userNameError),
                ),
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
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(AppStrings.signup),
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
}
