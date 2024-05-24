import 'package:commons/commons.dart';
import 'package:commons_ui/commons_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modular_router/modular_router.dart';

import '../../bloc/cats_favorites/cats_favorites_bloc.dart';
import '../../bloc/cats_favorites/cats_favorites_events.dart';
import '../../bloc/cats_favorites/cats_favorites_states.dart';
import '../../bloc/router/cat_favorites_router_bloc.dart';
import '../components/empty_results.dart';
import '../components/favorites_list.dart';

class CatsFavoritesScreen extends StatelessWidget {
  const CatsFavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<CatsFavoritesBloc>(context),
      child: BlocListener<CatsFavoritesBloc, CatsFavoritesState>(
        listener: _listener,
        child: _buildScreen(),
      ),
    );
  }

  Widget _buildScreen() {
    return Scaffold(
      body: Stack(
        children: [
          const GradientBackground(),
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<CatsFavoritesBloc, CatsFavoritesState>(
          builder: _builder,
          buildWhen: _buildWhen,
        ),
      ),
    );
  }

  void _listener(BuildContext context, CatsFavoritesState state) {
    if (state is! CatsFavoritesNavigationState) {
      return;
    }

    final event = PushRequest(
      route: state.route,
      arguments: state.arguments,
      onGoBack: () => _onNavigationGoBack(context),
    );

    context.read<CatFavoritesRouterBloc>().add(event);
  }

  bool _buildWhen(CatsFavoritesState previousState, CatsFavoritesState nextState) {
    return nextState is! CatsFavoritesNavigationState;
  }

  Widget _builder(BuildContext context, CatsFavoritesState state) {
    switch (state) {
      case CatsFavoritesInitialState():
        return const SizedBox();
      case CatsFavoritesLoadingState():
        return const GenericLoading();
      case CatsFavoritesLoadedState(data: final data) || CatsFavoritesNavigationState(data: final data):
        return _buildForSuccessStatus(context, data ?? []);
      case CatsFavoritesFailureState():
        return const GenericErrorScreen<CatFavoritesRouterBloc>(
          routerActionHandlerType: RouterActionHandlerType.external,
        );
    }
  }

  Widget _buildForSuccessStatus(BuildContext context, List<Cat> data) {
    if (data.isEmpty) {
      return EmptyResults(onNavigationGoBack: () => _onNavigationGoBack(context));
    }

    return FavoritesList(
      data: data,
      onAddCatButtonPressed: () {
        const event = AddFavoriteCat();
        context.read<CatsFavoritesBloc>().add(event);
      },
      onEditCatButtonPressed: (cat) {
        final event = EditFavoriteCat(data: cat);
        context.read<CatsFavoritesBloc>().add(event);
      },
      onDeleteCatButtonPressed: (cat) {
        final event = DeleteFavoriteCat(data: cat);
        context.read<CatsFavoritesBloc>().add(event);
      },
    );
  }

  void _onNavigationGoBack(BuildContext context) {
    const event = LoadCatsFavorites();
    context.read<CatsFavoritesBloc>().add(event);
  }
}
