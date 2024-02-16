import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neopop/neopop.dart';
import '../exporter.dart';

class LoadingButtonV2 extends StatelessWidget {
  const LoadingButtonV2({
    this.icon,
    super.key,
    required this.buttonLoading,
    required this.text,
    required this.onPressed,
    this.enabled = true,
    this.expanded = true,
    this.textColor = Colors.white,
    this.backgroundColor = primaryColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  });

  final bool buttonLoading;
  final Color textColor;
  final String text;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;
  final bool enabled;
  final Color backgroundColor;
  final bool expanded;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    Widget button = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
      ),
      onPressed: buttonLoading ? null : onPressed,
      child: Builder(builder: (context) {
        if (buttonLoading) return const CircularProgressIndicator();
        final textWidget = Text(text);
        if (icon != null) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [icon!, gap, textWidget],
          );
        }
        return textWidget;
      }),
    );
    if (expanded) {
      return Row(
        children: [Expanded(child: button)],
      );
    } else {
      return button;
    }
  }
}

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    super.key,
    required this.buttonLoading,
    required this.text,
    required this.onPressed,
    this.enabled = true,
    this.expanded = true,
    this.textColor = Colors.white,
    this.backgroundColor = Colors.black,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  });

  final bool buttonLoading;
  final Color textColor;
  final String text;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;
  final bool enabled;
  final Color backgroundColor;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    Widget button = NeoPopButton(
      enabled: enabled,
      color: backgroundColor,
      animationDuration: animationDuration,
      depth: 1,
      onTapUp: buttonLoading || !enabled
          ? null
          : () {
              HapticFeedback.lightImpact();
              onPressed();
            },
      onTapDown: () => HapticFeedback.mediumImpact(),
      child: Padding(
        padding: buttonLoading
            ? const EdgeInsets.symmetric(vertical: 5, horizontal: 20)
            : padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Builder(builder: (context) {
              if (buttonLoading) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Visibility(
                        visible: false,
                        maintainState: true,
                        maintainAnimation: true,
                        maintainSize: true,
                        child: Text(text, style: TextStyle(color: textColor))),
                    const FittedBox(child: CircularProgressIndicator()),
                  ],
                );
              }
              return Text(text, style: TextStyle(color: textColor));
            }),
          ],
        ),
      ),
    );
    if (!expanded) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [button],
      );
    }
    return button;
  }
}
