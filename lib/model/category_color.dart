//category_color.dart

import 'package:drift/drift.dart';

class CategoryColors extends Table {
  //PRIMARY KEY
  IntColumn get id => integer().autoIncrement()();

  //hexCode
  TextColumn get hexCode => text()();
}
