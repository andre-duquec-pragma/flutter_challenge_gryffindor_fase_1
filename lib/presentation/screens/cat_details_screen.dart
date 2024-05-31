import '../../domain/bloc/cat_details/cat_details_bloc.dart';
import '../../domain/bloc/cat_details/cat_details_state.dart';
import '../../domain/models/cat_detail.dart';

import 'package:flutter/material.dart';

import '../../domain/models/cats.dart';
import '../../domain/utils/common_routes.dart';
import '../../domain/utils/constants.dart';
import '../components/cat_image.dart';
import '../components/cat_origin_text.dart';
import '../components/custom_button.dart';
import '../components/generic_scaffold.dart';
import '../components/rating_bar.dart';
import 'generic_error_screen.dart';

class CatDetailsScreen extends StatelessWidget {
  final CatDetailsBloc bloc;

  CatDetailsScreen({super.key, required Cat cat}) : bloc = CatDetailsBloc(cat: cat);

  @override
  Widget build(BuildContext context) {
    return GenericScaffold(
      title: Constants.navigationHeaderName,
      body: StreamBuilder(
        stream: bloc.stream.stream,
        builder: _builder,
      ),
    );
  }

  Widget _builder(BuildContext context, AsyncSnapshot<CatDetailsState> snapshot) {
    if (snapshot.data == null) {
      return const GenericErrorScreen();
    }

    switch (snapshot.data!) {
      case CatDetailsStarted(details: final data):
        return _buildDetails(context, data);
      case CatLoadedState(details: final data):
        return _buildDetails(context, data);
      case CatDetailErrorState():
        return const GenericErrorScreen();
      case CatDeletedState(details: final data):
        showDeleteSuccess(context);
        return _buildDetails(context, data);
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
          _buildDescription(data.details),
          const SizedBox(height: 20),
          _buildRatings(data.details),
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
          CatImage(cat: data),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, CatDetail data) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildTitle(data.details),
          CatOriginText(origin: data.details.origin),
        ],
      ),
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

  Widget _buildDescription(Cat cat) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        cat.description,
        textAlign: TextAlign.start,
        style: const TextStyle(
          fontWeight: FontWeight.w300,
        ),
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
            Navigator.pushNamed(context, CommonRoutes.catModifyPackage.value, arguments: cat.details).then((_) {
              bloc.reload();
            });
          },
        ),
        const SizedBox(height: 10),
        CustomButton(
          text: Constants.deleteButton,
          onTap: () {
            bloc.delete(cat);
          },
        ),
      ],
    );
  }

  void showDeleteSuccess(BuildContext context) {
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
      Navigator.pop(context);
    });
  }
}