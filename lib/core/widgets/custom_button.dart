import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color background;
  final Color foreGround;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.background = Colors.blueAccent,
    this.foreGround = Colors.white,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width * .9,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: background,
            foregroundColor: foreGround,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: foreGround == Colors.red
                  ? BorderSide(color: Colors.red, width: .2)
                  : BorderSide.none,
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) Icon(icon),
              if (icon != null) const SizedBox(width: 5),
              Text(label, style: const TextStyle(fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}
