import 'package:flutter/material.dart';

import '../../../domain/entities/cats.dart';
import 'base_favorite_card.dart';
import '../images/cat_image.dart';
import '../texts/ellipsis_text.dart';

final class FavoriteCard extends StatelessWidget {
  final Cat data;
  final Function(Cat data) onTap;

  const FavoriteCard({
    super.key,
    required this.data,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(data),
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
