import 'package:hive/hive.dart';

part 'quotes_model.g.dart';


@HiveType(typeId: 0)
class QuotesModel extends HiveObject {

  @HiveField(0)
  String title;

  @HiveField(1)
  String image;

  @HiveField(2)
  String dateTime;

  QuotesModel(
      {required this.title, required this.image, required this.dateTime});
}



