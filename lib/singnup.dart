import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:text_validation_advanced/congrats.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final lockKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormState>();
  final TextEditingController _secretController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SignUp")),
      body: Column(
        children: [
          SizedBox(
            width: 300,
            child: Form(
              key: emailKey,
              autovalidateMode: AutovalidateMode.always,
              child: TextFormField(
                decoration: const InputDecoration(label: Text("Email")),
                validator: (value) {
                  if (value != null && !EmailValidator.validate(value)) {
                    return "Enter a correct email";
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ),
          SizedBox(
            width: 300,
            child: Form(
              key: lockKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                controller: _secretController,
                obscureText: true,
                decoration:
                    const InputDecoration(label: Text("Enter Secret Code")),
                validator: (value) {
                  if (value != null && value.length < 5) {
                    return "Secret Code is of lenght more than 6";
                  } else if (value == "secret") {
                    return "Secret Found";
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ),
          OutlinedButton(
              onPressed: () {
                final checkKey = lockKey.currentState!.validate();
                final emailCheck = emailKey.currentState!.validate();
                if (emailCheck && checkKey) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Congratulations()));
                }
              },
              child: const Text("Lets go"))
        ],
      ),
    );
  }
}
