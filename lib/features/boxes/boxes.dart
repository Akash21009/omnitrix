import 'package:hive/hive.dart';
import 'package:omnitrix/features/tags/data/models/tags_model.dart';

import '../quotes/data/models/quotes_model.dart';

class Boxes {
  static Box<QuotesModel> getQuotes() => Hive.box('quotes');
  static Box<TagModel> getTags() => Hive.box('tags');
  
}
