import 'package:flutter/material.dart';

import 'chip_filters.dart';

class GoalChips extends StatelessWidget {
  const GoalChips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Goal',
          textAlign: TextAlign.left,
        ),
      ),
      Wrap(
        spacing: 10,
        children: [
          ChipFilters(chipName: 'Stress/Anxiety Relief'),
          ChipFilters(chipName: 'Pain/Inflammation'),
          ChipFilters(chipName: 'Sleep'),
          ChipFilters(chipName: 'General Wellbeing'),
        ],
      ),
    ]);
  }
}
