import 'package:flutter/material.dart';

import '../texts/ellipsis_text.dart';

class GenericSlider extends StatelessWidget {
  final String title;
  final double value;
  final ValueChanged<double> onChanged;

  final double spacing = 10;

  const GenericSlider({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spacing),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          _buildSlider(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: spacing),
      child: EllipsisText(
        text: title,
        align: TextAlign.start,
      ),
    );
  }

  Widget _buildSlider() {
    return Slider(
      value: value,
      max: 5,
      divisions: 5,
      label: value.round().toString(),
      onChanged: onChanged,
    );
  }
}
