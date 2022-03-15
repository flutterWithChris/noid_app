import 'package:flutter/material.dart';
import 'package:noid_app/presentation/widgets/chip_filters.dart';

class CategorySelect extends StatelessWidget {
  const CategorySelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          spacing: 10,
          children: [
            ChipFilters(chipName: 'CBD Oil Tinctures'),
            ChipFilters(chipName: 'CBD Gummies'),
            ChipFilters(chipName: 'CBD Topicals'),
            ChipFilters(chipName: 'CBD Flower/Vapes'),
            ChipFilters(chipName: 'CBD For Pets'),
          ],
        ),
      ),
    );
  }
}
