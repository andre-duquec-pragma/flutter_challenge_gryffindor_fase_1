import 'package:flutter/material.dart';

import '../../../domain/utils/constants.dart';
import 'ellipsis_text.dart';

class CatOriginText extends StatelessWidget {
  final String origin;

  const CatOriginText({super.key, required this.origin});

  @override
  Widget build(BuildContext context) {
    return EllipsisText(
      text: "${Constants.originPlaceHolder}: $origin",
      style: TextStyle(color: Theme.of(context).primaryColor),
      maxLines: 2,
    );
  }
}
