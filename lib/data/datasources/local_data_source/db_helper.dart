import 'dart:async';
import 'dart:developer';
import 'package:aziz_bookstore/data/models/book_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('favourite_books.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const intType = 'INTEGER NOT NULL';
    const boolType = 'INTEGER NOT NULL';
    const textType = 'TEXT NOT NULL';
    const nullableTextType = 'TEXT';

    await db.execute('''
    CREATE TABLE books (
      id $idType,
      title $textType,
      subjects $nullableTextType,
      authors $nullableTextType,
      translators $nullableTextType,
      bookshelves $nullableTextType,
      languages $nullableTextType,
      copyright $boolType,
      media_type $textType,
      formats $nullableTextType,
      download_count $intType
    )
    ''');
  }

  Future<int> createBook(Book book) async {
    final db = await instance.database;
    return await db.insert('books', book.toMap()).then((value) {
      log('Book inserted with id: $value');
      return value;
    });
  }

  Future<Book?> readBook(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      'books',
      columns: [
        'id',
        'title',
        'subjects',
        'authors',
        'translators',
        'bookshelves',
        'languages',
        'copyright',
        'media_type',
        'formats',
        'download_count'
      ],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Book.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Book>> readAllBooks() async {
    final db = await instance.database;

    final result = await db.query('books');

    return result.map((json) => Book.fromMap(json)).toList();
  }

  Future<int> updateBook(Book book) async {
    final db = await instance.database;

    return db.update(
      'books',
      book.toMap(),
      where: 'id = ?',
      whereArgs: [book.id],
    );
  }

  Future<int> deleteBook(int id) async {
    final db = await instance.database;

    return await db.delete(
      'books',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> isBookLiked(int id) async {
    final db = await instance.database;

    final result = await db.query(
      'books',
      where: 'id = ?',
      whereArgs: [id],
    );

    return result.isNotEmpty;
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}

DatabaseHelper databaseHelper = DatabaseHelper.instance;

Future<List<Book>> getLikedBooks() async {
  return await databaseHelper.readAllBooks();
}

Stream<List<Book>> getLikedBooksStream() async* {
  while (true) {
    yield await databaseHelper.readAllBooks();
    await Future.delayed(const Duration(seconds: 1)); // Menunggu 1 detik sebelum mengirimkan data lagi
  }
}
