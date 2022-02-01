import 'package:flutter/material.dart';
import 'package:noid_app/view/chip_filters.dart';

class SpectrumChips extends StatelessWidget {
  const SpectrumChips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'THC Preference',
          textAlign: TextAlign.left,
        ),
      ),
      Wrap(
        spacing: 10,
        children: [
          ChipFilters(chipName: 'Full Spectrum'),
          ChipFilters(chipName: 'THC-Free'),
        ],
      ),
    ]);
  }
}
