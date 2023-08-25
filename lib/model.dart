import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  final Map<String, dynamic> answers;

  ResultsPage({required this.answers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questionnaire Results'),
      ),
      body: ListView(
        children: answers.entries.map((entry) {
          return ListTile(
            title: Text(entry.key),
            subtitle: Text(entry.value.toString()),
          );
        }).toList(),
      ),
    );
  }
}