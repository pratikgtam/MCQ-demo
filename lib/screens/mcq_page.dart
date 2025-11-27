import 'package:flutter/material.dart';
import '../models/lesson.dart';
import '../services/lesson_service.dart';
import 'mcq_question.dart';

class MCQPage extends StatefulWidget {
  const MCQPage({super.key});

  @override
  State<MCQPage> createState() => _MCQPageState();
}

class _MCQPageState extends State<MCQPage> {
  Lesson? lesson;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadLesson();
  }

  Future<void> _loadLesson() async {
    try {
      final loadedLesson = await LessonService.loadLesson();
      setState(() {
        lesson = loadedLesson;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Failed to load lesson',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: _loadLesson, child: const Text('Retry')),
          ],
        ),
      );
    }

    if (lesson == null || lesson!.activities.isEmpty) {
      return const Center(child: Text('No activities found in lesson'));
    }

    // Find the first QCM activity
    final qcmActivity = lesson!.activities.firstWhere(
      (activity) => activity.type == 'qcm',
      orElse: () => lesson!.activities.first,
    );

    return MCQQuestion(activity: qcmActivity);
  }

  String _getAppBarTitle() {
    if (errorMessage != null) {
      return 'Error';
    }
    if (lesson == null || lesson!.activities.isEmpty) {
      return 'No Content';
    }
    return 'MCQ Quiz';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle()),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _buildBody(),
    );
  }
}
