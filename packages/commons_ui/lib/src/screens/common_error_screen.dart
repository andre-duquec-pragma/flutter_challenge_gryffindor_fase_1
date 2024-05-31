import 'package:commons_ui/src/components/custom_button.dart';
import 'package:commons_ui/src/components/generic_asset_image.dart';
import 'package:commons_ui/src/utils/common_resources.dart';
import 'package:flutter/material.dart';

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
                  resourceName: CommonResources.error.value,
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
