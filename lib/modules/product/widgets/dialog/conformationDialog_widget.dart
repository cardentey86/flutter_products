import 'package:flutter/material.dart';

import 'dialog_type.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final DialogType type;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    required this.type
  });

  static Future<void> show(
      BuildContext context, {
        required String title,
        required String content,
        required VoidCallback onConfirm,
        required DialogType type
      }) {
    return showDialog(
      context: context,
      builder: (_) => ConfirmationDialog(
        title: title,
        content: content,
        onConfirm: onConfirm,
        type: type,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: type == DialogType.Eliminacion ? Text('Delete', style: TextStyle(color: Colors.red),) : Text('OK'),
        ),
      ],
    );
  }
}
