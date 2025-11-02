import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Utils {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    Color backgroundColor = Colors.black87,
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static Future<bool?> showConfirm({
    required BuildContext context,
    String title = 'Confirmación',
    String message = '¿Desea realizar esta acción?',
    String confirmText = 'Aceptar',
    String cancelText = 'Cancelar',
    Color confirmColor = Colors.blue,
    Color cancelColor = Colors.black54,
    bool isDestructive = false,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: Text(
              cancelText,
              style: TextStyle(color: cancelColor),
            ),
          ),
          TextButton(
            onPressed: () => context.pop(true),
            child: Text(
              confirmText,
              style: TextStyle(
                color: isDestructive ? Colors.red : confirmColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
