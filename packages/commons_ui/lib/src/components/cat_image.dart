import 'package:commons/commons.dart';
import 'package:commons_ui/src/utils/common_resources.dart';
import 'package:flutter/material.dart';

class CatImage extends StatelessWidget {
  final Cat cat;

  const CatImage({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: _getAsset(),
    );
  }

  AssetImage _getAsset() {
    final resource = CommonResources.init(name: cat.imageId);

    return AssetImage(resource.value);
  }
}
