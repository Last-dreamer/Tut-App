import 'dart:async';

import 'package:tut_app/presentation/common/state_renderer/flow_state.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  final StreamController _inputStateController =
      StreamController<FlowState>.broadcast();

  @override
  Sink get inputState => _inputStateController.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputStateController.stream.map((state) => state);

  @override
  void dispose() {
    _inputStateController.close();
  }
}

abstract class BaseViewModelInputs {
  void start();

  void dispose();

  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
