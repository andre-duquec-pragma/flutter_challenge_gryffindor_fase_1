import '../../domain/bloc/cat_details/cat_details_bloc.dart';
import '../../domain/bloc/cat_details/cat_details_state.dart';

import 'package:flutter/material.dart';

import '../../domain/entities/cats.dart';
import '../../domain/utils/routes.dart';
import '../../domain/utils/constants.dart';
import '../components/images/cat_image.dart';
import '../components/texts/cat_origin_text.dart';
import '../components/buttons/custom_button.dart';
import '../components/containers/generic_scaffold.dart';
import '../components/bars/rating_bar.dart';
import 'generic_error_screen.dart';

class CatDetailsScreen extends StatefulWidget {
  final CatDetailsBloc bloc;

  CatDetailsScreen({super.key, required Cat cat}) : bloc = CatDetailsBloc(cat: cat);

  @override
  State<StatefulWidget> createState() => _CatDetailsScreenState();
}

class _CatDetailsScreenState extends State<CatDetailsScreen> {
  @override
  void dispose() {
    widget.bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GenericScaffold(
      title: Constants.navigationHeaderName,
      body: StreamBuilder(
        stream: widget.bloc.stateStream,
        builder: _builder,
      ),
    );
  }

  Widget _builder(BuildContext context, AsyncSnapshot<CatDetailsState> snapshot) {
    if (snapshot.data == null) {
      return const GenericErrorScreen();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (snapshot.data is! CatDeletedState) {
        return;
      }

      showDeleteSuccess(context);
    });

    switch (snapshot.data!) {
      case CatDetailsStarted(data: final data):
        return _buildDetails(context, data);
      case CatLoadedState(data: final data):
        return _buildDetails(context, data);
      case CatDetailErrorState():
        return const GenericErrorScreen();
      case CatDeletedState(data: final data):
        return _buildDetails(context, data);
    }
  }

  Widget _buildDetails(BuildContext context, Cat data) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildImageRow(data),
          _buildSpacer(),
          _buildHeader(context, data),
          _buildSpacer(),
          _buildDescription(data),
          _buildSpacer(),
          _buildRatings(data),
          const Spacer(),
          _buildActions(context, data),
        ],
      ),
    );
  }

  Widget _buildSpacer() {
    return const SizedBox(height: 20);
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

  Widget _buildHeader(BuildContext context, Cat data) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildTitle(data),
          CatOriginText(origin: data.origin),
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
          text: Constants.intelligentPlaceHolder,
        ),
        RatingBar(
          ratingImage: ratingImage,
          rating: cat.affectionLevel,
          text: Constants.affectionPlaceHolder,
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context, Cat cat) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomButton(
          text: Constants.editButton,
          onTap: () {
            Navigator.pushNamed(context, Routes.catModify.value, arguments: cat).then((_) {
              widget.bloc.reload();
            });
          },
        ),
        const SizedBox(height: 10),
        CustomButton(
          text: Constants.deleteButton,
          onTap: () {
            widget.bloc.delete(cat);
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
