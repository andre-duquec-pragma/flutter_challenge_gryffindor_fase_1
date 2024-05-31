import 'dart:async';

import 'splash_states.dart';
import '../../../base/main_dependencies_builder.dart';

class SplashBloc {
  final StreamController<SplashState> stream = StreamController();

  SplashBloc() : super() {
    stream.sink.add(const SplashState(status: SplashStatus.initial));

    _start();
  }

  Future _start() async {
    final dependenciesBuilder = MainDependenciesBuilder();
    await dependenciesBuilder.start();

    await Future.delayed(const Duration(seconds: 1));

    stream.add(const SplashState(
      status: SplashStatus.success,
    ));
  }
}
