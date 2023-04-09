import 'package:flutter/material.dart';
import 'package:grad_gg/register_screen.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const RegisterScreen()));
      },
    );
  }
}
