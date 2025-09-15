import 'package:flower_app/core/Widgets/messages/message_type.dart';
import 'package:flutter/material.dart';

class CustomMessageWidget extends StatefulWidget {
  final String message;
  final MessageType type;
  final OverlayEntry entry;
  final Duration duration;

  const CustomMessageWidget({
    super.key,
    required this.message,
    required this.type,
    required this.entry,
    this.duration = const Duration(seconds: 3),
  });

  @override
  State<CustomMessageWidget> createState() => _CustomMessageWidgetState();
}

class _CustomMessageWidgetState extends State<CustomMessageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();

    Future.delayed(widget.duration, () {
      _controller.reverse().then((_) {
        widget.entry.remove();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFECFDF3);

    final messageColor = widget.type == MessageType.success
        ? const Color(0xFF008A2E)
        : const Color(0xFFe50000);

    final icon = widget.type == MessageType.success
        ? Icons.check_circle_outline_rounded
        : Icons.error_rounded;

    return FadeTransition(
      opacity: _opacityAnimation,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(12),
            color: backgroundColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: messageColor),
                  const SizedBox(width: 10),
                  Text(widget.message,
                      style: TextStyle(
                        color: messageColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
