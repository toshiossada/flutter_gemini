import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import 'chat.dart';

class TextPage extends StatefulWidget {
  const TextPage({super.key});

  @override
  State<TextPage> createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  late final GenerativeModel gemini;
  var question = '';
  var answer = '';
  var isLoading = false;
  final txtController = TextEditingController();

  @override
  void initState() {
    super.initState();
    gemini = GenerativeModel(
      model: 'gemini-pro',
      apiKey: const String.fromEnvironment('API_KEY'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GEMINI PRO'),
          actions: [
            IconButton(
              icon: const Icon(Icons.image),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ChatPage(),
                  ),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            const Text('TEXT AI'),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(question),
                    Visibility(
                      visible: isLoading,
                      child: const CircularProgressIndicator(),
                    ),
                    Visibility(
                      visible: !isLoading,
                      child: Align(
                          alignment: Alignment.topLeft, child: Text(answer)),
                    ),
                    Visibility(
                      visible: question.isEmpty && !isLoading,
                      child: const Center(
                        child: Text('Faça uma pergunta ao GEMINI!'),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: txtController,
                onFieldSubmitted: (text) async {
                  setState(() {
                    question = text;
                    isLoading = true;
                  });
                  txtController.clear();

                  final content = [Content.text(question)];
                  final response = await gemini.generateContent(content);

                  setState(() {
                    answer = response.text ?? '';
                    isLoading = false;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
