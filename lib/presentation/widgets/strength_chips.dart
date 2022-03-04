import 'package:flutter/material.dart';

import 'chip_filters.dart';

class StrengthChips extends StatelessWidget {
  const StrengthChips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Strength',
          textAlign: TextAlign.left,
        ),
      ),
      Wrap(
        spacing: 10,
        children: [
          ChipFilters(chipName: 'High Strength'),
          ChipFilters(chipName: 'Medium Strength'),
          ChipFilters(chipName: 'Low Strength'),
        ],
      ),
    ]);
  }
}
