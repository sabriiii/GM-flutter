import 'package:flutter/material.dart';
import 'package:gm/components/main_compnent/search_bar_component.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  void handleSearchTap() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Page'),
      ),
      body: Center(
        child: SearchBarComponent(onTap: handleSearchTap),
      ),
    );
  }
}
