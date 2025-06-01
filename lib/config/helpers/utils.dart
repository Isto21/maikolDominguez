import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<String> loading(
    {required BuildContext context, required Future action}) async {
  try {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const Center(
        child: SizedBox(
            height: 60,
            width: 60,
            child: CircularProgressIndicator(
              color: Colors.white,
            )),
      ),
    );
    return await action;
  } catch (e) {
    print(
      e.toString(),
    );
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Error $e')));
    rethrow;
  } finally {
    context.pop(context);
  }
}

Future showTransitionDialogue(
  Widget widget,
  BuildContext context, {
  bool? barrierDismissible,
}) async {
  final dialog = await showGeneralDialog(
    barrierDismissible: barrierDismissible ?? true,
    barrierLabel: '',
    barrierColor: Colors.black38,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (ctx, anim1, anim2) => widget,
    transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
      filter:
          ImageFilter.blur(sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
      child: FadeTransition(
        opacity: anim1,
        child: child,
      ),
    ),
    context: context,
  );
  return dialog;
}

class Debounce {
  final int milliseconds;
  Timer? _timer;

  Debounce({required this.milliseconds});

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
