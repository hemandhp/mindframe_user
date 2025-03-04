import 'package:flutter/material.dart';
import 'package:mindframe_user/common_widget/custom_alert_dialog.dart';

void showErrorDialog(BuildContext context, {String? title, String? message}) {
  showDialog(
    context: context,
    builder: (context) => CustomAlertDialog(
      title: title ?? 'Failure',
      description: message ??
          'Something went wrong, please check your connection and try again',
      primaryButton: 'Ok',
    ),
  );
}
