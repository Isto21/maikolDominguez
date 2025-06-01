import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maikol_tesis/generated/l10n.dart';

class CustomAlertDialog extends StatelessWidget {
  final String? title;
  final Widget? content;
  final Color? titleColor;
  final bool centerTitle;
  final bool haveCancelButton;
  final void Function()? funcionAccept;
  final void Function()? funcionCancel;
  const CustomAlertDialog({
    super.key,
    this.titleColor,
    this.centerTitle = false,
    this.title = '',
    this.content,
    this.haveCancelButton = true,
    this.funcionAccept,
    this.funcionCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: (centerTitle)
              ? Center(
                  child: Text(
                    title!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: titleColor,
                    ),
                  ),
                )
              : Text(
                  title!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
                ),
          content: content,
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            _AcceptButtonDialog(funcionAccept),
            (haveCancelButton)
                ? _CancelButtonDialog(funcionCancel)
                : const SizedBox(),
          ],
        );
      },
    );
  }
}

class _AcceptButtonDialog extends StatelessWidget {
  final void Function()? funcionAccept;
  const _AcceptButtonDialog(this.funcionAccept);

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed:
          funcionAccept ??
          () {
            context.pop();
            //  Navigator.pop(context);
          },
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Text(S.of(context).ACCEPT),
      ),
    );
  }
}

class _CancelButtonDialog extends StatelessWidget {
  final void Function()? funcionCancel;
  const _CancelButtonDialog(this.funcionCancel);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed:
          funcionCancel ??
          () {
            context.pop();
            //  Navigator.pop(context);
          },
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Text(S.of(context).CANCEL),
      ),
    );
  }
}
