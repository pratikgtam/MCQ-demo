import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/lesson.dart';

class LessonService {
  static Future<Lesson> loadLesson() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/lesson.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      return Lesson.fromJson(jsonData);
    } catch (e) {
      throw Exception('Failed to load lesson: $e');
    }
  }
}


