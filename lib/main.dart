//main.dart

import 'package:calender/database/drift_database.dart';
import 'package:calender/screen/home_screen.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

const DEFAULT_COLORS = [
  //RED
  'FF0000',
  //ORANGE
  'FFa500',
  //YELLOW
  'FFFF00',
  //GREEN
  '008000',
  //BLUE
  '0000ff',
  //INDIGO
  '4b0082',
  //PURPLE
  'ee82ee',
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  final database = LocalDatabase();
  GetIt.I.registerSingleton<LocalDatabase>(database);
  final List<CategoryColor> colors = await database.getCategoryColors();
  if (colors.isEmpty) {
    for (String hexCode in DEFAULT_COLORS) {
      await database.createCategoryColor(CategoryColorsCompanion(
        hexCode: Value(hexCode),
      ));
    }
  }
  runApp(MaterialApp(
      theme: ThemeData(fontFamily: 'NotoSans'), home: HomeScreen()));
}
