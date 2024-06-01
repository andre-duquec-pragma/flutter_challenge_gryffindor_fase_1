import 'dart:async';

import '../bloc.dart';
import 'splash_states.dart';
import '../../environment/main_dependencies_builder.dart';

class SplashBloc extends Bloc<SplashState> {
  SplashBloc() : super(initialState: const SplashState(status: SplashStatus.initial)) {
    _start();
  }

  Future _start() async {
    final dependenciesBuilder = MainDependenciesBuilder();
    await dependenciesBuilder.start();

    await Future.delayed(const Duration(seconds: 1));

    emit(const SplashState(
      status: SplashStatus.success,
    ));
  }
}
