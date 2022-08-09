import 'package:flutter/material.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';

abstract class FlowState {
  String? getMessage();
  StateRendererType? getStateRenderer();
}

class LoadingState extends FlowState {
  String message;
  StateRendererType renderer;

  LoadingState({required this.renderer, String? message})
      : message = message ?? AppStrings.loading;

  @override
  String? getMessage() => message;

  @override
  StateRendererType? getStateRenderer() => renderer;
}

class ErrorState extends FlowState {
  String? message;
  StateRendererType renderer;

  ErrorState({required this.renderer, this.message});

  @override
  String? getMessage() => message;

  @override
  StateRendererType? getStateRenderer() => renderer;
}

class ContantState extends FlowState {
  ContantState();

  @override
  String? getMessage() => "";

  @override
  StateRendererType? getStateRenderer() =>
      StateRendererType.CONTENT_SCREEN_STATE;
}

class EmptyState extends FlowState {
  String message;
  EmptyState(this.message);

  @override
  String? getMessage() => message;

  @override
  StateRendererType? getStateRenderer() => StateRendererType.EMPTY_SCREEN_STATE;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWiget(
      BuildContext context, Widget contentScreenWidget, Function retry) {
    switch (runtimeType) {
      case LoadingState:
        dismissDialog(context);
        if (getStateRenderer() == StateRendererType.POPUP_LOADING_STATE) {
          showPopUp(context, getStateRenderer()!, getMessage()!);
          return contentScreenWidget;
        } else {
          return StateRenderer(
              stateRendererType: getStateRenderer()!,
              retryAction: retry,
              message: getMessage()!);
        }

      case ErrorState:
        dismissDialog(context);
        if (getStateRenderer() == StateRendererType.POPUP_ERROR_STATE) {
          showPopUp(context, getStateRenderer()!, getMessage()!);
          return contentScreenWidget;
        } else {
          return StateRenderer(
              stateRendererType: getStateRenderer()!,
              retryAction: retry,
              message: getMessage()!);
        }

      case ContantState:
        dismissDialog(context);
        return contentScreenWidget;
      case EmptyState:
        dismissDialog(context);
        return StateRenderer(
            stateRendererType: getStateRenderer()!,
            message: getMessage(),
            retryAction: retry);
      default:
        dismissDialog(context);
        return contentScreenWidget;
    }
  }

  _isThereDialogShowing(
    BuildContext context,
  ) =>
      ModalRoute.of(context)?.isCurrent != true;

  dismissDialog(BuildContext context) {
    if (_isThereDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  showPopUp(
      BuildContext context, StateRendererType stateRenderer, String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (context) {
          return StateRenderer(
              stateRendererType: stateRenderer,
              retryAction: () {},
              message: message);
        }));
  }
}
