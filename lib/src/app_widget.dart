import 'package:flutter/material.dart';

import 'pages/text.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: TextPage(),
    );
  }
}
