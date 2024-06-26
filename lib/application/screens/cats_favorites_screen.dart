import 'package:flutter/material.dart';

import '../../domain/bloc/cats_favorites/cats_favorites_bloc.dart';
import '../../domain/bloc/cats_favorites/cats_favorites_states.dart';
import '../../domain/entities/cats.dart';
import '../../domain/utils/routes.dart';
import '../components/containers/empty_results.dart';
import '../components/lists/favorites_list.dart';
import '../components/loading/generic_loading.dart';
import '../components/containers/gradient_background.dart';
import 'generic_error_screen.dart';

class CatsFavoritesScreen extends StatefulWidget {
  final CatsFavoritesBloc bloc = CatsFavoritesBloc();

  CatsFavoritesScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CatsFavoritesScreenState();
}

class _CatsFavoritesScreenState extends State<CatsFavoritesScreen> {
  @override
  void dispose() {
    widget.bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        child: StreamBuilder(
          stream: widget.bloc.stateStream,
          builder: _builder,
        ),
      ),
    );
  }

  Widget _builder(BuildContext context, AsyncSnapshot<CatsFavoritesState> snapshot) {
    if (snapshot.data == null) {
      return const GenericErrorScreen();
    }

    switch (snapshot.data!) {
      case CatsFavoritesInitialState():
        return const SizedBox();
      case CatsFavoritesLoadingState():
        return const GenericLoading();
      case CatsFavoritesLoadedState(data: final data):
        return _buildForSuccessStatus(context, data ?? []);
      case CatsFavoritesFailureState():
        return const GenericErrorScreen();
    }
  }

  Widget _buildForSuccessStatus(BuildContext context, List<Cat> data) {
    if (data.isEmpty) {
      return EmptyResults(onButtonTap: () {
        Navigator.pushNamed(context, Routes.catModify.value).then((_) {
          widget.bloc.loadCatsFavorites();
        });
      });
    }

    return FavoritesList(
      data: data,
      onAddCatButtonPressed: () {
        Navigator.pushNamed(context, Routes.catModify.value).then((_) {
          widget.bloc.loadCatsFavorites();
        });
      },
      onCardTap: (data) {
        Navigator.pushNamed(context, Routes.catDetails.value, arguments: data).then((_) {
          widget.bloc.loadCatsFavorites();
        });
      },
    );
  }
}
