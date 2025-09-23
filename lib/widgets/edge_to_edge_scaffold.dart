import 'package:flutter/material.dart';

class EdgeToEdgeScaffold extends StatelessWidget {
  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;

  const EdgeToEdgeScaffold({
    super.key,
    this.body,
    this.appBar,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: appBar,
      body: SafeArea(
        child: body ?? Container(),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}