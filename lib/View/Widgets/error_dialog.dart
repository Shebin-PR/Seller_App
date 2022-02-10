import 'package:flutter/material.dart';

class ErrorDialogWidget extends StatelessWidget {
  final String? message;
  const ErrorDialogWidget({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        message!,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(primary: Colors.blue),
          child: const Center(
            child: Text("Ok"),
          ),
        )
      ],
    );
  }
}
