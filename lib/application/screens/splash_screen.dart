import 'package:flutter/material.dart';

import '../../domain/bloc/splash/splash_bloc.dart';
import '../../domain/bloc/splash/splash_states.dart';
import '../../domain/utils/resources.dart';
import '../../domain/utils/routes.dart';
import '../components/images/padding_image.dart';

class SplashScreen extends StatefulWidget {
  final SplashBloc bloc = SplashBloc();

  SplashScreen({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _SplashScreenState();

  @override
  void initState() {
    _listenBloc();
    super.initState();
  }

  void _listenBloc() {
    widget.bloc.stateStream.listen(
      (state) {
        if (state.status != SplashStatus.success) {
          return;
        }

        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.favorites.value,
          (route) => route.settings.name == Routes.root,
        );
      },
    );
  }

  @override
  void dispose() {
    widget.bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: PaddingImage(
          assetName: Resources.splash.value,
          padding: const EdgeInsets.all(50),
        ),
      ),
    );
  }
}
