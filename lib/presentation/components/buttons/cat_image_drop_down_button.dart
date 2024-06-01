import 'package:flutter/material.dart';

import '../../../domain/utils/base_resources.dart';
import '../../../domain/utils/constants.dart';
import '../texts/ellipsis_text.dart';

class CatImageDropDownButton extends StatelessWidget {
  final String current;
  final List<BaseResources> items;
  final ValueChanged<BaseResources?> onChanged;

  const CatImageDropDownButton({
    super.key,
    required this.current,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        _buildBody(),
      ],
    );
  }

  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: EllipsisText(
        text: Constants.selectImagePlaceHolder,
        align: TextAlign.start,
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      child: _buildDropDownButton(),
    );
  }

  Widget _buildDropDownButton() {
    return DropdownButton(
      items: items.map((e) {
        return DropdownMenuItem(
          value: e,
          child: _buildImage(e),
        );
      }).toList(),
      underline: Container(),
      dropdownColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      value: BaseResources.init(name: current),
      onChanged: onChanged,
    );
  }

  Widget _buildImage(BaseResources resource) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Image(
        image: AssetImage(resource.value),
      ),
    );
  }
}
