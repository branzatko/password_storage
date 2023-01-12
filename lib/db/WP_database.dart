import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

import 'WebPage.dart';


class WebPageDB {



  Future<void> insertPage(WebPage page) async {

    final database = openDatabase(
      join(await getDatabasesPath(), 'web_page.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE web_pages(id INTEGER PRIMARY KEY AUTOINCREMENT, url TEXT, username TEXT)',
        );
      },
      version: 1,
    );

    final db = await database;

    await db.insert(
      'web_pages',
      page.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getPages() async {

    final database = openDatabase(
      join(await getDatabasesPath(), 'web_page.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE web_pages(id INTEGER PRIMARY KEY AUTOINCREMENT, url TEXT, username TEXT)',
        );
      },
      version: 1,
    );

    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('web_pages');

    return maps;

    /*return List.generate(maps.length, (i) {
      return WebPage(
          maps[i]['id'],
          maps[i]['url'],
          maps[i]['username'],
          maps[i]['password']
      );
    });*/
  }

  Future<List<Map<String, dynamic>>> getPage(id) async {

    final database = openDatabase(
      join(await getDatabasesPath(), 'web_page.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE web_pages(id INTEGER PRIMARY KEY AUTOINCREMENT, url TEXT, username TEXT)',
        );
      },
      version: 1,
    );

    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('web_pages WHERE id = $id');

    return maps;
  }

  Future<int> getLenght() async {

    final database = openDatabase(
      join(await getDatabasesPath(), 'web_page.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE web_pages(id INTEGER PRIMARY KEY AUTOINCREMENT, url TEXT, username TEXT)',
        );
      },
      version: 1,
    );

    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('web_pages');

    return maps.length;
  }

  Future<void> deletePage(id) async {

    final database = openDatabase(
      join(await getDatabasesPath(), 'web_page.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE web_pages(id INTEGER PRIMARY KEY AUTOINCREMENT, url TEXT, username TEXT)',
        );
      },
      version: 1,
    );

    final db = await database;

    await db.delete(
      'web_pages',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getLastId() async{
    final database = openDatabase(
        join(await getDatabasesPath(), 'web_page.db'),
        onCreate: (db, version) {
    return db.execute(
    'CREATE TABLE web_pages(id INTEGER PRIMARY KEY AUTOINCREMENT, url TEXT, username TEXT)',
    );
    },
    version: 1,
    );

    final db = await database;

    final List<Map<String, dynamic>> id = await db.rawQuery('SELECT last_insert_rowid() as id');

    if(id.isEmpty){

    }

    return id;
  }


}