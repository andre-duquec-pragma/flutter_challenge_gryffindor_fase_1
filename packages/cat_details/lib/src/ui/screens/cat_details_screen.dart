import 'package:modular_router/modular_router.dart';

import '../../bloc/cat_details/cat_details_bloc.dart';
import '../../bloc/cat_details/cat_details_event.dart';
import '../../bloc/cat_details/cat_details_state.dart';
import '../../bloc/router/cat_details_router_bloc.dart';
import '../../models/cat_detail.dart';

import 'package:commons/commons.dart';
import 'package:commons_ui/commons_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/constants.dart';

class CatDetailsScreen extends StatelessWidget {
  final Cat cat;

  const CatDetailsScreen({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatDetailsBloc(cat: cat),
      child: GenericScaffold<CatDetailsRouterBloc>(
        routerActionHandlerTypeOnBack: RouterActionHandlerType.external,
        title: Constants.navigationHeaderName,
        body: BlocListener<CatDetailsBloc, CatDetailsState>(
          listener: _listener,
          child: BlocBuilder<CatDetailsBloc, CatDetailsState>(
            buildWhen: _buildWhen,
            builder: _builder,
          ),
        ),
      ),
    );
  }

  void _listener(BuildContext context, CatDetailsState state) {
    if (state is! CatDeletedState) {
      return;
    }

    showDeleteSuccess(context);
  }

  bool _buildWhen(CatDetailsState previous, CatDetailsState next) {
    return next is! CatDeletedState;
  }

  Widget _builder(BuildContext context, CatDetailsState state) {
    switch (state) {
      case CatDetailsStarted(details: final data):
        return _buildDetails(context, data);
      case CatLoadedState(details: final data):
        return _buildDetails(context, data);
      case CatDetailsState():
        return const SizedBox();
    }
  }

  Widget _buildDetails(BuildContext context, CatDetail data) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildImageRow(data.details),
          const SizedBox(height: 20),
          _buildHeader(context, data),
          const SizedBox(height: 20),
          _buildDescription(cat),
          const SizedBox(height: 20),
          _buildRatings(cat),
          const Spacer(),
          _buildActions(context, data),
        ],
      ),
    );
  }

  Widget _buildImageRow(Cat data) {
    return SizedBox(
      height: 180,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CatImage(cat: cat),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, CatDetail data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(cat),
            CatOriginText(origin: cat.origin),
          ],
        ),
        _buildFavoritesButton(context, data),
      ],
    );
  }

  Widget _buildTitle(Cat cat) {
    return Text(
      cat.breedName,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
    );
  }

  Widget _buildFavoritesButton(BuildContext context, CatDetail data) {
    final color = data.isFavorite ? Colors.deepPurple : Colors.grey;
    final icon = data.isFavorite ? Icons.auto_awesome_rounded : Icons.auto_awesome_outlined;

    return IconButton(
      onPressed: () {
        context.read<CatDetailsBloc>().add(ToggleFavoritesEvent(data: data));
      },
      icon: Icon(
        icon,
        color: color,
        size: 35,
      ),
    );
  }

  Widget _buildDescription(Cat cat) {
    return Text(
      cat.description,
      textAlign: TextAlign.start,
      style: const TextStyle(
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _buildRatings(Cat cat) {
    final ratingImage = CatImage(cat: cat);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RatingBar(
          ratingImage: ratingImage,
          rating: cat.intelligence,
          text: "Intelligence",
        ),
        RatingBar(
          ratingImage: ratingImage,
          rating: cat.affectionLevel,
          text: "Affection level",
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context, CatDetail cat) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomButton(
          text: Constants.editButton,
          onTap: () {
            final event = PushRequest(
              route: CommonRoutes.catModifyPackage.value,
              arguments: cat.details,
              onGoBack: () => _onNavigationBack(context),
            );
            context.read<CatDetailsRouterBloc>().add(event);
          },
        ),
        const SizedBox(height: 10),
        CustomButton(
          text: Constants.deleteButton,
          onTap: () {
            final event = DeleteEvent(data: cat);
            context.read<CatDetailsBloc>().add(event);
          },
        ),
      ],
    );
  }

  void showDeleteSuccess(BuildContext context) {
    final bloc = context.read<CatDetailsRouterBloc>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(Constants.catDeleteSuccess),
          actions: [
            TextButton(
              child: const Text(Constants.doneButton),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((_) {
      const event = PopRequest(type: RouterActionHandlerType.external);
      bloc.add(event);
    });
  }

  void _onNavigationBack(BuildContext context) {
    const event = ReloadCatDetailsEvent();
    context.read<CatDetailsBloc>().add(event);
  }
}
