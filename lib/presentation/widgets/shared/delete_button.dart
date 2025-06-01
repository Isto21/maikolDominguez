// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maikol_tesis/generated/l10n.dart';
import 'package:maikol_tesis/presentation/widgets/shared/custom_alert_dialog.shared.dart';

class DeleteButton extends StatelessWidget {
  final String? warning;
  final VoidCallback? onpressed;
  const DeleteButton({required this.onpressed, super.key, this.warning});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      visualDensity: VisualDensity.compact,
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (context) {
            return CustomAlertDialog(
              haveCancelButton: true,
              title: S.of(context).WARNING,
              funcionCancel: () => context.pop(),
              funcionAccept: onpressed,
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      warning ?? S.of(context).Delete_Confirm,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.primary),
    );
  }
}
