import 'package:flutter/material.dart';
import '../models/lesson.dart';

class MCQScreen extends StatefulWidget {
  final Activity activity;

  const MCQScreen({super.key, required this.activity});

  @override
  State<MCQScreen> createState() => _MCQScreenState();
}

class _MCQScreenState extends State<MCQScreen> {
  String? selectedAnswer;
  bool showAnswer = false;

  void _selectAnswer(String option) {
    if (!showAnswer) {
      setState(() {
        selectedAnswer = option;
        showAnswer = true;
      });
    }
  }

  void _resetQuiz() {
    setState(() {
      selectedAnswer = null;
      showAnswer = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.activity.question,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView.builder(
              itemCount: widget.activity.options.length,
              itemBuilder: (context, index) {
                final option = widget.activity.options[index];
                final isCorrect = option == widget.activity.answer;
                final isSelected = option == selectedAnswer;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: InkWell(
                    onTap: () => _selectAnswer(option),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: showAnswer && isCorrect
                              ? Colors.green
                              : showAnswer && isSelected && !isCorrect
                              ? Colors.red
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              option,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: showAnswer && isCorrect
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                          if (showAnswer && isCorrect)
                            const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 24,
                            )
                          else if (showAnswer && isSelected && !isCorrect)
                            const Icon(
                              Icons.cancel,
                              color: Colors.red,
                              size: 24,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (showAnswer)
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  margin: const EdgeInsets.only(top: 16.0),
                  decoration: BoxDecoration(
                    color: selectedAnswer == widget.activity.answer
                        ? Colors.green.shade50
                        : Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selectedAnswer == widget.activity.answer
                          ? Colors.green
                          : Colors.red,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        selectedAnswer == widget.activity.answer
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: selectedAnswer == widget.activity.answer
                            ? Colors.green
                            : Colors.red,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          selectedAnswer == widget.activity.answer
                              ? 'Correct! Well done.'
                              : 'Incorrect. The correct answer is: ${widget.activity.answer}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: selectedAnswer == widget.activity.answer
                                ? Colors.green.shade900
                                : Colors.red.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _resetQuiz,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset Quiz'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
