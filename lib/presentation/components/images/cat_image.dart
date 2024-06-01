import 'package:flutter/material.dart';

import '../../../domain/models/cats.dart';
import '../../../domain/utils/base_resources.dart';

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
    final resource = BaseResources.init(name: cat.imageId);

    return AssetImage(resource.value);
  }
}
