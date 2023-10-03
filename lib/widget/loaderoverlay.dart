import 'package:flutter/material.dart';

class LoadingOverlay extends StatefulWidget {
  final Widget child;
  const LoadingOverlay({Key? key, required this.child}) : super(key: key);
  static _LoadingOverlayState of(context) {
    return context?.findAncestorStateOfType<_LoadingOverlayState>();
  }

  @override
  _LoadingOverlayState createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay> {
  bool _isLoading = false;

  void show() {
    setState(() {
      _isLoading = true;
    });
  }

  void hide() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_isLoading)
          const Opacity(
            opacity: 0.5,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if (_isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
