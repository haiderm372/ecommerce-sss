import 'package:ecommerce/configs/global/context.dart';
import 'package:flutter/material.dart';
import '../../configs/themes/colors.dart';

class AppSnackbar {
  static void show(String msg, {bool ok = false}) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            ok
                ? Icons.check_circle_outline_rounded
                : Icons.error_outline_rounded,
            color: AppColors.white,
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(msg)),
        ],
      ),
      showCloseIcon: true,
      closeIconColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 25),
      padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
      backgroundColor: ok ? AppColors.green : AppColors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
    AppContext.messengerState.hideCurrentSnackBar();
    AppContext.messengerState.showSnackBar(snackBar);
  }
}
