import 'package:flutter/material.dart';

class ChipFilters extends StatefulWidget {
  String chipName = '';

  ChipFilters({Key? key, required this.chipName}) : super(key: key);

  @override
  State<ChipFilters> createState() => _ChipFiltersState();
}

class _ChipFiltersState extends State<ChipFilters> {
  @override
  Widget build(BuildContext context) {
    bool _isSelected = false;

    return FilterChip(
      label: Text(widget.chipName),
      selected: _isSelected,
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
        });
      },
      selectedColor: Color(0xFFFF9000),
    );
  }
}
