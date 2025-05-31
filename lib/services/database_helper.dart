import 'package:cours_dar_2025/models/fav_contacts.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  late Database db;

  DatabaseHelper();

  Future open(String path) async {
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
create table $tableContact ( 
  $columnId integer primary key autoincrement, 
  $columnName text not null,
  $columnPhone text not null)
''');
      },
    );
  }

  Future<FavContact> insert(FavContact contact) async {
    contact.id = await db.insert(tableContact, contact.toMap());
    return contact;
  }

  Future<FavContact?> getFavContactById(int id) async {
    List<Map> maps = await db.query(
      tableContact,
      columns: [columnId, columnName, columnPhone],
      where: '$columnId = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return FavContact.fromMap(maps.first);
    }
    return null;
  }

  Future<List<FavContact>> getFavContacts() async {
    List<FavContact> fav = [];
    db.query(tableContact, columns: [columnId, columnName, columnPhone]).then((
      value,
    ) {
      for (var c in value) {
        fav.add(FavContact.fromMap(c));
      }
    });
    return fav;
  }

  Future<int> delete(int id) async {
    return await db.delete(
      tableContact,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(FavContact contact) async {
    return await db.update(
      tableContact,
      contact.toMap(),
      where: '$columnId = ?',
      whereArgs: [contact.id],
    );
  }

  Future close() async => db.close();
}
