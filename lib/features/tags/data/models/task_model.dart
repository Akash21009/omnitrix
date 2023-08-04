import 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: 3)
class TaskModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String? deadline;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String creatDate;

  @HiveField(4)
  bool isCompleted;

 

  TaskModel({
    required this.title,
    required this.description,
    required this.deadline,
    required this.isCompleted,
    required this.creatDate,
  });
}
