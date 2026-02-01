import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,  this.name, this.hint,  this.icon,  this.controller
  });

  final String ? name;
  final String ? hint;
  final IconData ? icon;
  final TextEditingController ? controller;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name ?? "",
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(
              color: Colors.white, // Color of the text user types
              fontSize: 16,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xBB2C2C2E), // background color
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.white.withValues(alpha: 0.4),
                fontSize: 16,
              ),

              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                child: Icon(
                  icon,
                  color: Colors.white.withValues(alpha: 0.4),
                  size: 20,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        )
      ],
    );
  }
}