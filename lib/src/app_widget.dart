import 'package:flutter/material.dart';

import 'text_chat_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TextPage(),
    );
  }
}
