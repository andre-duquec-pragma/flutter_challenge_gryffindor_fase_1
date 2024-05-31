import 'package:commons/commons.dart';
import 'package:commons_ui/commons_ui.dart';
import 'package:flutter/material.dart';

import '../../domain/utils/constants.dart';

class EmptyResults extends StatelessWidget {
  final VoidCallback? onNavigationGoBack;

  const EmptyResults({super.key, this.onNavigationGoBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDescription(),
            const SizedBox(height: 10),
            _buildImage(),
            _buildButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return GenericAssetImage(
      resourceName: CommonResources.empty.value,
    );
  }

  Widget _buildDescription() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: EllipsisText(
        text: Constants.emptyFavoritesMessage,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
        maxLines: 2,
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return CustomButton(
      text: Constants.goToCatModifyMessage,
      onTap: () {
        Navigator.pushNamed(context, CommonRoutes.catModifyPackage.value).then((_) {
          if (onNavigationGoBack == null) {
            return;
          }
          onNavigationGoBack!();
        });
      },
    );
  }
}
