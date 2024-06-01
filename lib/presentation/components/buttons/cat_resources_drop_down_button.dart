import 'package:flutter/material.dart';

import '../../../domain/utils/base_resources.dart';
import 'cat_image_drop_down_button.dart';

class CatResourcesDropDownButton extends StatelessWidget {
  final String current;
  final Function(String imageId) onChanged;

  const CatResourcesDropDownButton({
    super.key,
    required this.current,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final resources = [
      BaseResources.cat1,
      BaseResources.cat2,
      BaseResources.cat3,
      BaseResources.cat4,
      BaseResources.cat5,
      BaseResources.cat6,
      BaseResources.cat7,
    ];

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        CatImageDropDownButton(
          current: current,
          items: resources,
          onChanged: (image) {
            if (image == null) {
              return;
            }

            onChanged(image.name);
          },
        ),
      ],
    );
  }
}
