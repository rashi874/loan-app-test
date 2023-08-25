import 'package:bankloan/model.dart';
import 'package:flutter/material.dart';

class QuestionnairePage extends StatefulWidget {
  const QuestionnairePage({super.key});

  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  int _currentStep = 0;
  Map<String, dynamic> _answers = {};

  final List<Map<String, dynamic>> _questions = [
    {
      "type": "SingleChoiceSelector",
      "schema": {
        "name": "typeOFLoan",
        "label": "Type of loan",
        "options": [
          {"key": "new-purchase", "value": "New purchase"},
          {
            "key": "balance-transfer-top-up",
            "value": "Balance transfer & Top-up"
          }
        ]
      }
    },
    {
      "type": "SingleChoiceSelector",
      "schema": {
        "name": "your-work-profile",
        "label": "Your work profile",
        "options": [
          {"key": "salaried", "value": "Salaried"},
          {"key": "id1", "value": "Self-employed non-professional"},
          {"key": "id2", "value": "Self-employed professional"},
          {"key": "id3", "value": "Proprietorship concern"},
          {"key": "id4", "value": "Partnership concern"},
          {"key": "id5", "value": "Limited liability partnership"}
        ]
      }
    },
    {
      "type": "Section",
      "schema": {
        "name": "Section1",
        "label": "Family income",
        "fields": [
          {
            "type": "Numeric",
            "schema": {
              "name": "total-family-income",
              "label": "Total family income"
            }
          },
          {
            "type": "Label",
            "schema": {
              "name": "Only blood relatives",
              "label": "Only blood relatives"
            }
          }
        ]
      }
    },
    {
      "type": "SingleSelect",
      "schema": {
        "name": "Existing bank where loan exists",
        "label": "Existing bank where loan exists",
        "options": [
          {"key": "id1", "value": "HDFC"},
          {"key": "id2", "value": "ICICI"},
          {"key": "id3", "value": "SBI"}
        ]
      }
    },
    {
      "type": "Section",
      "schema": {
        "name": "Section2",
        "label": "What are your current income sources",
        "fields": [
          {
            "type": "SingleSelect",
            "schema": {
              "name": "Property located state",
              "label": "Property located state",
              "options": [
                {"key": "id1", "value": "Haryana"},
                {"key": "id2", "value": "Delhi"},
                {"key": "id3", "value": "UP"}
              ]
            },
          },
          {
            "type": "SingleSelect",
            "schema": {
              "name": "Property located city",
              "label": "Property located city",
              "options": [
                {"key": "id1", "value": "Bhiwani"},
                {"key": "id2", "value": "Faridabad"},
                {"key": "id3", "value": "Gurgaon"}
              ]
            },
          },
        ],
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About loan'),
      ),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepTapped: (step) {
          setState(() {
            _currentStep = step;
          });
        },
        onStepContinue: () {
          if (_currentStep < _questions.length - 1) {
            setState(() {
              _currentStep++;
            });
          } else {
            // All questions answered, show results
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultsPage(answers: _answers),
              ),
            );
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep--;
            });
          }
        },
        steps: _questions.map((question) {
          final schema = question['schema'];
          final name = schema['name'];
          final label = schema['label'];
          final options = schema['options'] as List<dynamic>?;
          return Step(
            title: const Text(''),
            isActive: _currentStep == _questions.indexOf(question),
            state: _answers.containsKey(name)
                ? StepState.complete
                : StepState.indexed,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 20),
                ),
                if (options != null)
                  Column(
                    children: options.map<Widget>((option) {
                      final key = option['key'];
                      final value = option['value'];
                      return RadioListTile<String>(
                        title: Text(value),
                        value: key,
                        groupValue: _answers[name],
                        onChanged: (value) {
                          setState(() {
                            _answers[name] = value;
                          });
                        },
                      );
                    }).toList(),
                  ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
