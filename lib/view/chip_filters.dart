import 'package:flutter/material.dart';

class ChipFilters extends StatefulWidget {
  String chipName = '';

  ChipFilters({Key? key, required this.chipName}) : super(key: key);

  @override
  State<ChipFilters> createState() => _ChipFiltersState();
}

class _ChipFiltersState extends State<ChipFilters> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: const TextStyle(color: Colors.white),
      checkmarkColor: Colors.white,
      showCheckmark: true,
      selectedColor: Colors.lightGreen,
      backgroundColor: Colors.lightBlue,
      selected: _isSelected,
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
        });
      },
    );
  }
}
