import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class TextPage extends StatefulWidget {
  const TextPage({super.key});

  @override
  State<TextPage> createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  late final GenerativeModel geminiModel;
  var loading = false;
  var answer = '';

  @override
  void initState() {
    super.initState();
    geminiModel = GenerativeModel(
      model: 'gemini-1.0-pro',
      apiKey: 'AIzaSyAJjP_uo6I8EhciPUVl8V2LMyep0x90bas',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Visibility(
          visible: !loading,
          child: Text(answer),
        ),
        Visibility(
          visible: loading,
          child: const CircularProgressIndicator(),
        ),
        TextFormField(
          onFieldSubmitted: (value) async {
            final prompt = [
              Content.text(value),
            ];

            loading = true;
            setState(() {});
            final result = await geminiModel.generateContent(prompt);
            answer = result.text ?? '';
            loading = false;
            setState(() {});
          },
        ),
      ],
    ));
  }
}
