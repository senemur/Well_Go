import 'package:flutter/material.dart';
import 'package:well_go/pages/travel_home_screen.dart';
import 'package:well_go/const.dart';

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final List<Map<String, dynamic>> questions = [
    {
      "question": "What type of trip are you interested in?",
      "options": ["Adventure", "Relaxation", "Cultural"],
      "icons": [
        Icons.explore,
        Icons.spa,
        Icons.museum,
      ],
    },
    {
      "question": "How do you prefer to travel?",
      "options": ["Solo", "With friends", "With family"],
      "icons": [
        Icons.person,
        Icons.group,
        Icons.family_restroom,
      ],
    },
    {
      "question": "What is your budget range?",
      "options": ["Low", "Medium", "High"],
      "icons": [Icons.money_off, Icons.attach_money, Icons.money],
    },
    {
      "question": "What climate do you prefer?",
      "options": ["Tropical", "Temperate", "Cold"],
      "icons": [Icons.wb_sunny, Icons.wb_cloudy, Icons.ac_unit],
    },
    {
      "question": "What type of accommodation do you prefer?",
      "options": ["Hotel & Hostel", "Airbnb", "Camping"],
      "icons": [Icons.hotel, Icons.home, Icons.terrain],
    },
  ];

  List<String> answers = List.filled(5, "");

  void selectOption(int questionIndex, String option) {
    setState(() {
      answers[questionIndex] = option;
    });
  }

  void navigateToResults() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TravelHomeScreen(
          userData: {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Answer the Questions',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kButtonColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final question = questions[index];
                  return Card(
                    color: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            question['question'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Column(
                            children: question['options']
                                .asMap()
                                .entries
                                .map<Widget>((entry) {
                              int optionIndex = entry.key;
                              String option = entry.value;
                              IconData icon = question['icons'][optionIndex];
                              bool isSelected = answers[index] == option;
                              return GestureDetector(
                                onTap: () {
                                  selectOption(index, option);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? kBackgroundColor.withOpacity(0.4)
                                        : Colors.grey[100],
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: isSelected
                                          ? blueTextColor
                                          : Colors.transparent,
                                      width: 1.5,
                                    ),
                                  ),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 10),
                                  child: Row(
                                    children: [
                                      Icon(icon,
                                          color: isSelected
                                              ? blueTextColor
                                              : Colors.black54),
                                      const SizedBox(width: 10),
                                      Text(
                                        option,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: isSelected
                                              ? blueTextColor
                                              : Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: answers.contains("") ? null : navigateToResults,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  backgroundColor:
                      answers.contains("") ? Colors.grey : kButtonColor,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text(
                  'See Recommendations',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
