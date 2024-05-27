import 'package:cats_modify/src/bloc/router/cat_modify_route_generator.dart';
import 'package:cats_modify/src/ui/screens/cat_modify_screen.dart';
import 'package:commons/commons.dart';
import 'package:commons_ui/commons_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modular_router/modular_router.dart';

import '../../../bloc/router/cat_modify_router_bloc.dart';

class MainCatModifyScreen extends StatelessWidget {
  final Cat? data;

  const MainCatModifyScreen({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CatModifyRouterBloc()),
      ],
      child: GenericMainScreen<CatModifyRouterBloc>(
        initialScreen: CatModifyScreen(cat: data),
        routeNotFoundScreen: const GenericErrorScreen<BaseRouterBloc>(
          routerActionHandlerType: RouterActionHandlerType.self,
        ),
        routeGenerator: CatModifyRouteGenerator.name,
      ),
    );
  }
}
