import 'package:cats_favorites/src/ui/components/favorite_card.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import 'main_title.dart';

class FavoritesList extends StatelessWidget {
  final List<Cat> data;

  final VoidCallback onAddCatButtonPressed;

  final Function(Cat) onEditCatButtonPressed;
  final Function(Cat) onDeleteCatButtonPressed;

  const FavoritesList({
    super.key,
    required this.data,
    required this.onAddCatButtonPressed,
    required this.onEditCatButtonPressed,
    required this.onDeleteCatButtonPressed,
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
        return FavoriteCard(
          data: cat,
          onEditCatButtonPressed: onEditCatButtonPressed,
          onDeleteCatButtonPressed: onDeleteCatButtonPressed,
        );
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
