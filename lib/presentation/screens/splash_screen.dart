import 'package:flutter/material.dart';

import '../../domain/bloc/splash/splash_bloc.dart';
import '../../domain/bloc/splash/splash_states.dart';
import '../../domain/utils/base_resources.dart';
import '../../domain/utils/common_routes.dart';
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
    widget.bloc.stream.stream.listen(
      (state) {
        if (state.status != SplashStatus.success) {
          return;
        }

        Navigator.pushNamedAndRemoveUntil(
          context,
          CommonRoutes.favoriteCatsPackages.value,
          (route) => route.settings.name == CommonRoutes.root,
        );
      },
    );
  }

  @override
  void dispose() {
    widget.bloc.stream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: PaddingImage(
          assetName: BaseResources.splash.value,
          padding: const EdgeInsets.all(50),
        ),
      ),
    );
  }
}
