import 'package:commons/commons.dart';
import 'package:commons_ui/commons_ui.dart';
import 'package:flutter/material.dart';

import 'base_favorite_card.dart';

final class FavoriteCard extends StatelessWidget {
  final Cat data;

  const FavoriteCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, CommonRoutes.catDetailsPackage.value, arguments: data);
      },
      child: BaseFavoriteCard(
        children: [
          _buildImage(data),
          _buildDescription(context, data),
        ],
      ),
    );
  }

  Widget _buildImage(Cat data) {
    return SizedBox(
      width: 80,
      child: CatImage(cat: data),
    );
  }

  Widget _buildDescription(BuildContext context, Cat data) {
    return Column(
      children: [
        EllipsisText(
          text: data.breedName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        EllipsisText(
          text: data.origin,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}