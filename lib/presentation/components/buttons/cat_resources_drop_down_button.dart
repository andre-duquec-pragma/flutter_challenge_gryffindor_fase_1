import 'package:flutter/material.dart';

import '../../../domain/utils/resources.dart';
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
      Resources.cat1,
      Resources.cat2,
      Resources.cat3,
      Resources.cat4,
      Resources.cat5,
      Resources.cat6,
      Resources.cat7,
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
