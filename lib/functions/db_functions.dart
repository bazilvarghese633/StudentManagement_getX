import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_getx_try1/model/model.dart';

late Database db;

Future initDatabase() async {
  try {
    db = await openDatabase('data.db', version: 1,
        onCreate: (Database db, int version) {
      db.execute(
          'CREATE TABLE student(id INTEGER PRIMARY KEY,name TEXT, age TEXT,place TEXT,course TEXT,image BLOB,phone INTEGER)');
    });
    return db;
  } catch (e) {
    if (kDebugMode) {
      print('Error opening database:$e');
    }
    rethrow;
  }
}

Future<void> addStudent(StudentModel value) async {
  await db.rawInsert(
      'INSERT INTO student(name,age,place,course,image,phone)VALUES(?, ?, ? ,? ,? ,?)',
      [
        value.name,
        value.age,
        value.place,
        value.course,
        value.image,
        value.phone,
      ]);

  await getAllStudents();
}

Future<List<StudentModel>> getAllStudents() async {
  final value = await db.rawQuery('SELECT * FROM student');
  if (kDebugMode) {
    print(value);
  }

  List<StudentModel> updateStudentList =
      value.map((map) => StudentModel.fromMap(map)).toList();
  return updateStudentList;
}

updateStudent(StudentModel value) async {
  await db.rawUpdate(
      'UPDATE student SET name=?,age =?,place =?,course=?,image =?,phone =?WHERE id=?',
      [
        value.name,
        value.age,
        value.place,
        value.course,
        value.image,
        value.phone,
        value.id,
      ]);
  getAllStudents();
}

Future<void> deleteStudent(int? studentId) async {
  final db = await initDatabase();
  await db.rawDelete('DELETE FROM student WHERE id = ?', [studentId]);
}

Future<List<StudentModel>> searchStudents(String query) async {
  final value = await db.rawQuery(
    'SELECT * FROM student WHERE name LIKE ? OR course LIKE ?',
    ['%$query%', '%$query%'],
  );

  List<StudentModel> searchResults =
      value.map((map) => StudentModel.fromMap(map)).toList();
  return searchResults;
}
