// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/font_manager.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';
import 'package:tut_app/presentation/resources/styles_manager.dart';
import 'package:tut_app/presentation/resources/value_manager.dart';

enum StateRendererType {
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,

  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,

  CONTENT_SCREEN_STATE,
  EMPTY_SCREEN_STATE
}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;
  final Failure failure;
  final String message;
  final String title;
  final Function retryAction;

  StateRenderer({
    Key? key,
    required this.stateRendererType,
    Failure? failure,
    String? message,
    String? title,
    required this.retryAction,
  })  : message = message ?? AppStrings.loading,
        title = title ?? "",
        failure = failure ?? DefaultFailure(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.POPUP_LOADING_STATE:
       return _getPopUpDialog(context,[_getAnimatedImage()]);
      case StateRendererType.POPUP_ERROR_STATE:
        return _getPopUpDialog(context,[
              _getAnimatedImage(),
               _getMessage(failure.message), 
               _getRetry(AppStrings.ok, context),]);
      case StateRendererType.FULL_SCREEN_LOADING_STATE:
              return  _getItemInCol([_getAnimatedImage(),_getMessage(message)]);
          
      case StateRendererType.FULL_SCREEN_ERROR_STATE:
           return     _getItemInCol([
             _getAnimatedImage(),
               _getMessage(failure.message), 
               _getRetry(AppStrings.tryAgain, context),
               ]);

         
      case StateRendererType.CONTENT_SCREEN_STATE:
        break;

      case StateRendererType.EMPTY_SCREEN_STATE:
       return  _getItemInCol([_getAnimatedImage(),_getMessage(message)]);
      default:
       return  Container();
    }
  }



Widget _getPopUpDialog(BuildContext context, List<Widget> children){
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSize.s14),

    ),
    elevation: AppSize.s1_5,
    backgroundColor: Colors.transparent,
    child: Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(AppSize.s14),
        boxShadow: const [
          BoxShadow(color: Colors.black12,
           blurRadius: AppSize.s12, 
           offset: Offset(0, AppSize.s12))
        ]
      ),
      child: _getDialogContent(context, children),
    ),
  );
}

Widget _getDialogContent(BuildContext context, List<Widget> children) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: children
  );
}

  Widget _getAnimatedImage(){
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: ,
    );
  }

   Widget _getMessage(String message){
    return  Text(message, style: getMediumStyle(color:  ColorManager.black, fontSize: FontSize.s16),);
  }


  Widget _getRetry(String title, BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p18),
      child: SizedBox(
         width: AppSize.s180,
        child: ElevatedButton(onPressed: (){
          if(stateRendererType == StateRendererType.FULL_SCREEN_ERROR_STATE){
            retryAction.call();
          } else {
            Navigator.of(context).pop();
          }
        }, child: Text(title)),
      ),
    );
  }

  Widget _getItemInCol(List<Widget> children) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children);
  }
}
