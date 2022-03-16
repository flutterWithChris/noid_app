import 'package:flat_icons_flutter/flat_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noid_app/presentation/widgets/chip_filters.dart';

class CategorySelect extends StatelessWidget {
  const CategorySelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
          child: Icon(Icons.arrow_circle_left_outlined),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 7,
              children: [
                ChipFilters(
                  chipName: 'CBD Oil Tinctures',
                ),
                ChipFilters(
                  chipName: 'CBD Gummies',
                ),
                ChipFilters(chipName: 'CBD Topicals'),
                ChipFilters(chipName: 'CBD Flower/Vapes'),
                ChipFilters(chipName: 'CBD For Pets'),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
          child: Icon(Icons.arrow_circle_right_outlined),
        ),
      ],
    );
  }
}
