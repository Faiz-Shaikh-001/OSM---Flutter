import 'package:flutter/material.dart';

class SizeDropdownWidget extends StatefulWidget {
  final List<int> availableSizes;
  final int? selectedSize;
  final ValueChanged<int>? onSizeChanged;

  const SizeDropdownWidget({
    super.key,
    required this.availableSizes,
    this.selectedSize,
    this.onSizeChanged,
  });

  @override
  State<SizeDropdownWidget> createState() => _SizeDropdownWidgetState();
}

class _SizeDropdownWidgetState extends State<SizeDropdownWidget> {
  late int _currentSelectedSize;

  @override
  void initState() {
    super.initState();
    if (widget.selectedSize != null &&
        widget.availableSizes.contains(widget.selectedSize)) {
      _currentSelectedSize = widget.selectedSize!;
    } else if (widget.availableSizes.isNotEmpty) {
      _currentSelectedSize = widget.availableSizes.first;
    } else {
      // Fallback if no sizes are available
      _currentSelectedSize = 0;
    }
  }

  @override
  void didUpdateWidget(covariant SizeDropdownWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update selected size if the external selectedSize changes
    if (widget.selectedSize != oldWidget.selectedSize &&
        widget.selectedSize != null &&
        widget.availableSizes.contains(widget.selectedSize)) {
      setState(() {
        _currentSelectedSize = widget.selectedSize!;
      });
    }
    // Also update if available sizes change and the current selection is no longer valid
    if (!widget.availableSizes.contains(_currentSelectedSize) &&
        widget.availableSizes.isNotEmpty) {
      setState(() {
        _currentSelectedSize = widget.availableSizes.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = widget.availableSizes.isEmpty;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Size',
          style: TextStyle(fontSize: 15, color: Colors.blueGrey),
        ),
        DropdownButton<int>(
          value: isDisabled ? null : _currentSelectedSize,
          borderRadius: BorderRadius.circular(8.0),
          underline: const SizedBox(),
          onChanged: isDisabled
              ? null
              : (int? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _currentSelectedSize = newValue;
                    });
                    widget.onSizeChanged?.call(
                      newValue,
                    ); // Notify parent of change
                  }
                },
          items: widget.availableSizes.map<DropdownMenuItem<int>>((int size) {
            return DropdownMenuItem<int>(value: size, child: Text("$size mm"));
          }).toList(),
        ),
      ],
    );
  }
}
