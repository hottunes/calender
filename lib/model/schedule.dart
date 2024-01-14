import 'package:drift/drift.dart';

class Schedules extends Table {
  //PRIMARY KEY
  IntColumn get id => integer().autoIncrement()();

  // 내용
  TextColumn get content => text()();

  // Date
  DateTimeColumn get date => dateTime()();

  // 시작 시간
  IntColumn get startTime => integer()();

  // 종료 시간
  IntColumn get endTime => integer()();

  // Category Color Table ID
  IntColumn get colorId => integer()();

  // createdAt
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
}
