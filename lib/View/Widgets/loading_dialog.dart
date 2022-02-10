import 'package:flutter/material.dart';
import 'package:salt_n_pepper_seller/View/Widgets/progressbar.dart';

class LoadingDialogWidget extends StatelessWidget {
  final String? message;
  const LoadingDialogWidget({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          circularProgress(),
          const SizedBox(
            height: 20,
          ),
          Text("${message!}Please wait...")
        ],
      ),
    );
  }
}
