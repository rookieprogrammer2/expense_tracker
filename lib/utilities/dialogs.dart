import 'package:flutter/material.dart';

class MyDialogs {

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              SizedBox(width: MediaQuery.of(context).size.width * 0.09),
              const Text("Loading..."),
            ],
          ),
        );
      },
    );
  }

  static void dismissDialog (BuildContext context) {
    Navigator.pop(context);
  }

  static void showCustomDialog(BuildContext context, {
        required String dialogMessage,
        required bool isDismissible,
        String? positiveActionName,
        String? negativeActionName,
        VoidCallback? positiveAction,
        VoidCallback? negativeAction,
        Widget? title
      }) {
    List<Widget> actions = [];
    if(positiveActionName != null) {
      actions.add(
          TextButton(
              onPressed: (){
                Navigator.pop(context);
                positiveAction?.call();
              },
              child: Text(positiveActionName),
          ),
      );
    }
    if(negativeActionName != null) {
      actions.add(
          TextButton(
              onPressed: (){
                Navigator.pop(context);
                negativeAction?.call();
              },
              child: Text(negativeActionName),
          ),
      );
    }

    showDialog(
      barrierDismissible: isDismissible,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: title,
          actions: actions,
          content: Text(dialogMessage),
        );
      },
    );
  }
}
