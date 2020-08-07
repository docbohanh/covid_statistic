import "dart:async";
import "dart:io";
import "package:path/path.dart";
import "package:path_provider/path_provider.dart";
import "package:sqflite/sqflite.dart";

final covidTABLE = "Covid19";

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    final Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final String path = join(documentsDirectory.path, "Covid19.db");
    final database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }


  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE IF NOT EXISTS $covidTABLE ("
        "id INTEGER PRIMARY KEY, "
        "country TEXT UNIQUE, "
        "totalCases TEXT, "
        "newCases TEXT, "
        "totalDeaths TEXT, "
        "newDeaths TEXT, "
        "totalRecovered TEXT, "
        "activeCases TEXT, "
        "seriousCritical TEXT, "
        "area TEXT"
        ")");
  }

  void dispose() {}
}
