import 'package:hive_flutter/adapters.dart';
import 'package:omnitrix/features/tags/data/models/task_model.dart';
part 'tags_model.g.dart';

@HiveType(typeId: 2)
class TagModel extends HiveObject {
  @HiveField(0)
  List<TaskModel> tasks;

  @HiveField(1)
  String glowImage;

  @HiveField(2)
  String borderImage;

  @HiveField(3)
  String creatDate;

  @HiveField(4)
  String title;

  @HiveField(5)
  int leftTask;

  TagModel({
    required this.tasks,
    required this.glowImage,
    required this.borderImage,
    required this.creatDate,
    required this.title,
    required this.leftTask,
  });
}
