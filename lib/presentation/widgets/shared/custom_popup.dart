// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void ShowPopupGI(
  BuildContext context, {
  required OnDismiss onDismiss,
  required List<PopupItemGI> items,
}) {
  Navigator.of(context).push(PageRouteBuilder(
    opaque: false,
    pageBuilder: (context, animation, secondaryAnimation) => PopupGI(
      items: items,
      onDismiss: onDismiss,
    ),
  ));
}

typedef OnDismiss = void Function(bool byUser);

class PopupItemGI {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const PopupItemGI(
      {required this.icon, required this.label, required this.onTap});
}

class PopupGI extends StatefulWidget {
  bool isShow = true;
  final OnDismiss onDismiss;
  final List<PopupItemGI> items;

  PopupGI({super.key, required this.onDismiss, required this.items});

  @override
  State<PopupGI> createState() => _PopupGIState();
}

class _PopupGIState extends State<PopupGI> {
  bool isShowReady = false;
  bool btnBack = false;

  void dismiss(bool byUser) => setState(() {
        widget.isShow = false;
        widget.onDismiss(byUser);
      });

  @override
  Widget build(BuildContext context) {
    if (widget.isShow && !isShowReady) {
      Future.delayed(const Duration(milliseconds: 1), () {
        setState(() {
          isShowReady = true;
        });
      });
    } else if (!widget.isShow && isShowReady) {
      isShowReady = false;
    }

    if (btnBack) {
      Future.delayed(const Duration(milliseconds: 300), () => context.pop());
    }

    return WillPopScope(
      onWillPop: !btnBack
          ? () {
              Future.delayed(const Duration(milliseconds: 50), () {
                btnBack = true;
                dismiss(false);
              });
              return Future<bool>.delayed(
                  const Duration(milliseconds: 1), () => false);
            }
          : null,
      child: Stack(children: [
        FadeIn(
          animate: isShowReady,
          child: GestureDetector(
            onTapDown: (_) {
              dismiss(false);
              Future.delayed(
                  const Duration(milliseconds: 300), () => context.pop());
            },
            child: Container(color: Colors.black45),
          ),
        ),
        Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
            child: _PopupView(
              isShow: isShowReady,
              items: widget.items,
              dismiss: dismiss,
            )),
      ]),
    );
  }
}

class _PopupView extends StatefulWidget {
  final bool isShow;
  final List<PopupItemGI> items;
  final ValueChanged<bool> dismiss;

  const _PopupView(
      {required this.isShow, required this.items, required this.dismiss});

  @override
  State<_PopupView> createState() => _PopupViewState();
}

class _PopupViewState extends State<_PopupView> {
  bool isReadyChild = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final color = Theme.of(context).colorScheme;

    if (widget.isShow && !isReadyChild) {
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          isReadyChild = true;
        });
      });
    } else if (!widget.isShow && isReadyChild) isReadyChild = false;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: widget.isShow ? size.width - 16 : 0.0,
      height: widget.isShow ? size.height * 0.45 : 0.0,
      decoration: BoxDecoration(
        color: color.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: isReadyChild
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: _PopupItems(color),
            )
          : null,
    );
  }

  _PopupItems(ColorScheme color) {
    return GridView.count(
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      crossAxisCount: 3,
      children: widget.items
          .map(
            (item) => ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Material(
                color: color.surface,
                // color: color.primaryContainer,
                child: InkWell(
                  onTap: () {
                    widget.dismiss(true);
                    Future.delayed(
                        const Duration(milliseconds: 300), () => context.pop());
                    item.onTap();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                              padding: const EdgeInsets.all(12),
                              color: color.primaryContainer,
                              child: Icon(item.icon, size: 32))),
                      const SizedBox(height: 4),
                      Text(
                        item.label,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
