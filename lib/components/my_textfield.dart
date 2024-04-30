import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  const MyTextField({
    Key? key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    this.focusNode
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: 120.0, // Set maximum height to 200.0 pixels
        ),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          focusNode: focusNode,
          // keyboardType: TextInputType.multiline,
          // maxLines: null, // Allows the input field to expand vertically
          // minLines: 1,  // Minimum lines for the TextField
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.tertiary,
                // color: Colors.red
              )
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary
                  // color: Colors.red
                )
            ),
            fillColor: Theme.of(context).colorScheme.secondary,
            // fillColor: Colors.red,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.3))
          ),
        ),
      ),
    );
  }
}
