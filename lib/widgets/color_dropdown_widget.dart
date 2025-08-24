import 'package:flutter/material.dart';
import 'package:osm/services/color_api_service.dart';
import 'package:osm/utils/color_name_cache.dart';

class ColorDropDownWidget extends StatefulWidget {
  final List<MapEntry<String, Color>> availableColorsWithNames;
  final String? selectedColorName;
  final ValueChanged<Color>? onColorChanged;
  const ColorDropDownWidget({
    super.key,
    required this.availableColorsWithNames,
    this.selectedColorName,
    this.onColorChanged,
  });

  @override
  State<ColorDropDownWidget> createState() => _ColorDropDownWidgetState();
}

class _ColorDropDownWidgetState extends State<ColorDropDownWidget> {
  late String _currentSelectedColorName;

  @override
  void initState() {
    super.initState();
    if (widget.selectedColorName != null &&
        widget.availableColorsWithNames.any(
          (entry) => entry.key == widget.selectedColorName,
        )) {
      _currentSelectedColorName = widget.selectedColorName!;
    } else if (widget.availableColorsWithNames.isNotEmpty) {
      _currentSelectedColorName = widget.availableColorsWithNames.first.key;
    } else {
      _currentSelectedColorName = 'N/A';
    }
  }

  @override
  void didUpdateWidget(covariant ColorDropDownWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update selected color if the external selectedColorName changes
    if (widget.selectedColorName != oldWidget.selectedColorName &&
        widget.selectedColorName != null &&
        widget.availableColorsWithNames.any(
          (entry) => entry.key == widget.selectedColorName,
        )) {
      setState(() {
        _currentSelectedColorName = widget.selectedColorName!;
      });
    }
    // Also update if available colors change and the current selection is no longer valid
    if (!widget.availableColorsWithNames.any(
          (entry) => entry.key == _currentSelectedColorName,
        ) &&
        widget.availableColorsWithNames.isNotEmpty) {
      setState(() {
        _currentSelectedColorName = widget.availableColorsWithNames.first.key;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = widget.availableColorsWithNames.isEmpty;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Color', style: TextStyle(fontSize: 15, color: Colors.blueGrey)),
        DropdownButton<String>(
          value: isDisabled ? null : _currentSelectedColorName,
          icon: Icon(Icons.arrow_drop_down),
          borderRadius: BorderRadius.circular(8.0),
          underline: const SizedBox(),
          onChanged: isDisabled
              ? null
              : (String? newValue) {
                  if (newValue == null) return;
                  setState(() => _currentSelectedColorName = newValue);
                  final selectedEntryColor = widget.availableColorsWithNames
                      .firstWhere(
                        (entry) => entry.key == newValue,
                        orElse: () => MapEntry('N/A', Colors.transparent),
                      );
                  widget.onColorChanged?.call(selectedEntryColor.value);
                },
          items: widget.availableColorsWithNames.map<DropdownMenuItem<String>>((
            MapEntry<String, Color> entry,
          ) {
            return DropdownMenuItem<String>(
              value: entry.key,
              child: Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: entry.value,
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(entry.key),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
