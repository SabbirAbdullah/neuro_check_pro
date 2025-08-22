import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';

class ToggleEmailPhone extends StatelessWidget {
  final String selected;
  final Function(String) onChanged;

  const ToggleEmailPhone({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;

    return Container(

      padding: const EdgeInsets.symmetric(vertical: 8),
      child: AnimatedToggleSwitch<String>.size(
        current: selected,
        values: const ['Email', 'Phone'],
        indicatorSize: Size(width, 40), // Half screen for each toggle
        borderWidth: 5,
        selectedIconScale: 1,

        onChanged: onChanged,
        iconBuilder: (value) {
          // Show full text if active, short if inactive
          final isSelected = selected == value;
          return Center(
            child: Text(
              isSelected
                  ? (value == 'Email' ? 'Sign in with Email' : 'Sign in with Phone')
                  : value, // short text
              style: TextStyle(
                fontSize: isSelected ? 12 : 12,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.black : Colors.grey[700],
              ),
            ),
          );
        },
        style: ToggleStyle(
          backgroundColor: const Color(0xffEAECF2),
          indicatorColor: Colors.white,
          borderRadius: BorderRadius.circular(30),
          indicatorBorderRadius: BorderRadius.circular(30),
          borderColor: Colors.transparent,
        ),
      ),
    );
  }
}
