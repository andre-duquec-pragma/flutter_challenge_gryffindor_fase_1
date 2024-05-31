import 'package:commons/commons.dart';
import 'package:flutter/material.dart';

import '../../domain/utils/constants.dart';
import 'favorite_card.dart';
import 'main_title.dart';

class FavoritesList extends StatelessWidget {
  final List<Cat> data;

  final VoidCallback onAddCatButtonPressed;

  const FavoritesList({
    super.key,
    required this.data,
    required this.onAddCatButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          const MainTitle(title: Constants.headerName),
          Expanded(child: _buildList()),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildList() {
    const double spacing = 10;

    return GridView.count(
      padding: const EdgeInsets.all(spacing),
      crossAxisCount: 2,
      crossAxisSpacing: spacing,
      mainAxisSpacing: spacing,
      children: data.map((cat) {
        return FavoriteCard(data: cat);
      }).toList(),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: onAddCatButtonPressed,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}