// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/domain/model/model.dart';
import 'package:tut_app/presentation/onBoarding/onboarding_viewModel.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';

import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/font_manager.dart';
import 'package:tut_app/presentation/resources/routes_manger.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';
import 'package:tut_app/presentation/resources/styles_manager.dart';
import 'package:tut_app/presentation/resources/value_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void initState() {
    _appPreferences.setOnBoardingScreenViewde();
    _viewModel.start();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject?>(
        stream: _viewModel.outputSliderViewObject,
        builder: (context, snapshot) {
          return _getContentWidget(snapshot.data);
        });
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
      return Scaffold(
          backgroundColor: ColorManager.white,
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManager.white,
              statusBarBrightness: Brightness.dark,
            ),
          ),
          body: PageView.builder(
              controller: _pageController,
              itemCount: sliderViewObject.numOfSlides,
              onPageChanged: (index) {
                _viewModel.onPageChanged(index);
              },
              itemBuilder: (context, index) {
                return OnBoardingPage(
                    sliderObject: sliderViewObject.sliderObject);
              }),
          bottomNavigationBar: Container(
            color: ColorManager.white,
            height: AppSize.s100,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.loginroute);
                    },
                    child: Text(
                      AppStrings.skip,
                      style: getBoldStyle(
                          color: ColorManager.primary, fontSize: FontSize.s16),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
                _getBottomSheet(sliderViewObject),
              ],
            ),
          ));
    }
  }

  Widget _getBottomSheet(SliderViewObject sliderViewObject) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSize.s14),
            child: GestureDetector(
              onTap: () {
                _pageController.animateToPage(_viewModel.goPrevious(),
                    duration:
                        const Duration(microseconds: DurationContants.d300),
                    curve: Curves.easeInOut);
              },
              child: SizedBox(
                  width: AppSize.s20,
                  height: AppSize.s20,
                  child: SvgPicture.asset(ImageAssets.leftArrowIcon)),
            ),
          ),
          Row(
            children: [
              for (var i = 0; i < sliderViewObject.numOfSlides; i++)
                Padding(
                  padding: const EdgeInsets.all(AppSize.s8),
                  child: _getProperCircle(i, sliderViewObject.currentIndex),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppSize.s14),
            child: GestureDetector(
              onTap: () {
                _pageController.animateToPage(_viewModel.goNext(),
                    duration:
                        const Duration(microseconds: DurationContants.d300),
                    curve: Curves.easeInOut);
              },
              child: SizedBox(
                  width: AppSize.s20,
                  height: AppSize.s20,
                  child: SvgPicture.asset(ImageAssets.rightArrowIcon)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getProperCircle(int index, int currentIndex) {
    if (index != currentIndex) {
      return SvgPicture.asset(ImageAssets.hollowCircleIcon);
    } else {
      return SvgPicture.asset(ImageAssets.filledCircleIcon);
    }
  }
}

class OnBoardingPage extends StatelessWidget {
  SliderObject sliderObject;
  OnBoardingPage({Key? key, required this.sliderObject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppSize.s8),
          child: Text(sliderObject.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSize.s8),
          child: Text(sliderObject.subTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1),
        ),
        const SizedBox(
          height: AppSize.s60,
        ),
        SvgPicture.asset(sliderObject.image),
      ],
    );
  }
}
