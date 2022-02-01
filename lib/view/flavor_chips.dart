import 'package:flutter/material.dart';

import 'chip_filters.dart';

class FlavorChips extends StatelessWidget {
  const FlavorChips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Flavor Preference',
          textAlign: TextAlign.left,
        ),
      ),
      Wrap(
        spacing: 10,
        children: [
          ChipFilters(chipName: 'Flavored'),
          ChipFilters(chipName: 'Unflavored'),
        ],
      ),
    ]);
  }
}
