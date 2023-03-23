// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';

class ValidationIcon extends StatefulWidget {
  final bool validated;
  const ValidationIcon({super.key, required this.validated});

  @override
  _ValidationIconState createState() => _ValidationIconState();
}

class _ValidationIconState extends State<ValidationIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    if (widget.validated) _controller.forward();
  }

  @override
  void didUpdateWidget(covariant ValidationIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.validated) _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      builder: (BuildContext context, double value, Widget? child) {
        return Transform.scale(
          scale: widget.validated ? value : 1,
          child: child,
        );
      },
      child: Container(
        width: 150,
        height: 150,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green,
        ),
        child: const Icon(
          Icons.check,
          color: Colors.white,
          size: 120,
        ),
      ),
    );
  }
}
