// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';

import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/font_manager.dart';
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
  late final List<SliderObject> _list = _getSliderData();

  final PageController _pageController = PageController(initialPage: 0);

  List<SliderObject> _getSliderData() => [
        SliderObject(
            title: AppStrings.onBoardingTitle1,
            subTitle: AppStrings.onBoardingSubTitle1,
            image: ImageAssets.onBoardingLogo1),
        SliderObject(
            title: AppStrings.onBoardingTitle2,
            subTitle: AppStrings.onBoardingSubTitle2,
            image: ImageAssets.onBoardingLogo2),
        SliderObject(
            title: AppStrings.onBoardingTitle3,
            subTitle: AppStrings.onBoardingSubTitle3,
            image: ImageAssets.onBoardingLogo3),
        SliderObject(
            title: AppStrings.onBoardingTitle4,
            subTitle: AppStrings.onBoardingSubTitle4,
            image: ImageAssets.onBoardingLogo4),
      ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
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
            itemCount: _list.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return OnBoardingPage(sliderObject: _list[index]);
            }),
        bottomNavigationBar: Container(
          color: ColorManager.white,
          height: AppSize.s100,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    AppStrings.skip,
                    style: getBoldStyle(
                        color: ColorManager.primary, fontSize: FontSize.s16),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              _getBottomSheet(),
            ],
          ),
        ));
  }

  Widget _getBottomSheet() {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSize.s14),
            child: GestureDetector(
              onTap: () {
                _pageController.animateToPage(_getPrevIndex(),
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
              for (var i = 0; i < _list.length; i++)
                Padding(
                  padding: const EdgeInsets.all(AppSize.s8),
                  child: _getProperCircle(i),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppSize.s14),
            child: GestureDetector(
              onTap: () {
                _pageController.animateToPage(_getNextIndex(),
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

  Widget _getProperCircle(int index) {
    if (index == currentIndex) {
      return SvgPicture.asset(ImageAssets.hollowCircleIcon);
    } else {
      return SvgPicture.asset(ImageAssets.filledCircleIcon);
    }
  }

  int _getPrevIndex() {
    int _prevIndex = currentIndex--;
    if (_prevIndex == -1) {
      _prevIndex = _list.length - 1;
    }
    return _prevIndex;
  }

  int _getNextIndex() {
    int _nextIndex = currentIndex++;
    if (_nextIndex >= _list.length) {
      currentIndex = 0;
    }
    return _nextIndex;
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

class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject({
    required this.title,
    required this.subTitle,
    required this.image,
  });
}
