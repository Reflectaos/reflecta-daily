import 'package:equatable/equatable.dart';
class DailyReflection extends Equatable {
  final String id;
  final String userId;
  final String userInput;
  final String reflection;
  final String verse;
  final String verseReference;
  final String spiritualInsight;
  final String actionPlan;
  final DateTime createdAt;
  const DailyReflection({
    required this.id, required this.userId, required this.userInput,
    required this.reflection, required this.verse, required this.verseReference,
    required this.spiritualInsight, required this.actionPlan, required this.createdAt,
  });
  @override
  List<Object?> get props => [id, userId, userInput, reflection, verse, verseReference, spiritualInsight, actionPlan, createdAt];
}
