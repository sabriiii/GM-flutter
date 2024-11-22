// import 'package:flutter/material.dart';

// class MyLoginField extends StatelessWidget {
//   final controller;
//   final String hintText;
//   final bool obscureText;
//   const MyLoginField({
//     super.key,
//     required this.controller,
//     required this.hintText,
//     required this.obscureText,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 25.0),
//       child: TextField(
//         controller: controller,
//         obscureText: obscureText,
//         decoration: InputDecoration(
//           enabledBorder: const OutlineInputBorder(
//             borderSide:
//                 BorderSide(color: Colors.white), // Consistent grey border
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide:
//                 BorderSide(color: Colors.grey.shade400), // Same grey border
//           ),
//           fillColor: Colors.white,
//           filled: true,
//           hintText: hintText,
//           hintStyle: TextStyle(color: Colors.grey[500]),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class MyLoginField extends StatelessWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final bool obscureText;
//   final IconData icon;

//   const MyLoginField({
//     super.key,
//     required this.controller,
//     required this.hintText,
//     required this.obscureText,
//     required this.icon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 25.0),
//       child: TextField(
//         controller: controller,
//         obscureText: obscureText,
//         decoration: InputDecoration(
//           prefixIcon: Icon(
//             icon,
//             color: Colors.grey[500], // Optional: Customize icon color
//           ),
//           enabledBorder: const OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.white),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey),
//           ),
//           fillColor: Colors.white,
//           filled: true,
//           hintText: hintText,
//           hintStyle: TextStyle(color: Colors.grey[500]),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class MyLoginField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData icon;

  const MyLoginField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.icon,
  });

  @override
  _MyLoginFieldState createState() => _MyLoginFieldState();
}

class _MyLoginFieldState extends State<MyLoginField> {
  late FocusNode _focusNode;
  bool _showHintAndIcon = true;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    // Listen to focus and text changes
    _focusNode.addListener(_handleFocusChange);
    widget.controller.addListener(_handleTextChange);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    widget.controller.removeListener(_handleTextChange);
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _showHintAndIcon = !_focusNode.hasFocus && widget.controller.text.isEmpty;
    });
  }

  void _handleTextChange() {
    setState(() {
      _showHintAndIcon = !_focusNode.hasFocus && widget.controller.text.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        focusNode: _focusNode,
        controller: widget.controller,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          prefixIcon: _showHintAndIcon
              ? Icon(
                  widget.icon,
                  color: Colors.grey[500],
                )
              : null,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: _showHintAndIcon ? widget.hintText : '',
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}
