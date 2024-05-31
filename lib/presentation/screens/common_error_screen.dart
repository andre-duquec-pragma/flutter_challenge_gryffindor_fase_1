import 'package:flutter/material.dart';

import '../../domain/utils/base_resources.dart';
import '../components/custom_button.dart';
import '../components/generic_asset_image.dart';

class CommonErrorScreen extends StatelessWidget {
  final VoidCallback onBackButtonPressed;
  final Widget? child;

  const CommonErrorScreen({
    super.key,
    required this.onBackButtonPressed,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GenericAssetImage(
                  resourceName: BaseResources.error.value,
                ),
                CustomButton(
                  onTap: onBackButtonPressed,
                ),
                child ?? const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
