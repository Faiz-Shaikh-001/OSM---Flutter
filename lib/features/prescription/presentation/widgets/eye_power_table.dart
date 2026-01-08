import 'package:flutter/material.dart';
import 'package:osm/features/prescription/domain/value_objects/eye_power.dart';

class EyePowerTable extends StatelessWidget {
  final EyePower right;
  final EyePower left;

  const EyePowerTable({super.key, required this.right, required this.left});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        _HeaderRow(),
        const Divider(),
        _EyeRow(label: 'Right', power: right),
        const Divider(),
        _EyeRow(label: 'Left', power: left),
      ],
    );
  }
}

class _HeaderRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _Cell(''),
        _Cell('SPH', isHeader: true),
        _Cell('CYL', isHeader: true),
        _Cell('AX', isHeader: true),
        _Cell('ADD', isHeader: true),
      ],
    );
  }
}

class _EyeRow extends StatelessWidget {
  final String label;
  final EyePower power;

  const _EyeRow({required this.label, required this.power});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Cell(label, isHeader: true),
        _Cell(_fmt(power.sphere)),
        _Cell(_fmt(power.cylinder)),
        _Cell(_fmt(power.axis)),
        _Cell(_fmt(power.add)),
      ],
    );
  }

  String _fmt(num? value) {
    if (value == null) return '—';
    return value.toStringAsFixed(2);
  }
}

class _Cell extends StatelessWidget {
  final String text;
  final bool isHeader;

  const _Cell(this.text, {this.isHeader = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: isHeader
            ? Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600)
            : Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
