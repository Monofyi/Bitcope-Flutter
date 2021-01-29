import 'package:bitcope/features/login_register/data/model/user_model.dart';
import 'package:bitcope/core/database/user_database_provider.dart';

class UserDatabaseOps {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createUser(User user) async {
    final db = await dbProvider.database;

    var result = db.insert(userTable, user.toDatabaseJson());
    return result;
  }

  Future<int> deleteUser(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(userTable, where: "id = ?", whereArgs: [id]);
    return result;
  }

  Future<bool> checkUser(int id) async {
    final db = await dbProvider.database;
    try {
      List<Map> users =
          await db.query(userTable, where: 'id = ?', whereArgs: [id]);
      if (users.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<String> getUserToken(int id) async {
    final db = await dbProvider.database;
    String token = '';
    try {
      List<Map> tokenList = await db.query(userTable,
          columns: ['token'], distinct: true, where: 'id = ?', whereArgs: [id]);
      if (tokenList.length > 0) {
        token = tokenList.toList().first["token"];
        print(token);
      } else {
        token = "check your damn code surya";
      }
    } catch (error) {
      return error.toString();
    }
    return token;
  }

  Future<String> getUserName(int id) async {
    final db = await dbProvider.database;
    String token = '';
    try {
      List<Map> userName = await db.query(userTable,
          columns: ['username'],
          distinct: true,
          where: 'id = ?',
          whereArgs: [id]);
      if (userName.length > 0) {
        token = userName.toList().first["username"];
        print(userName);
      } else {
        token = "check your damn code surya";
      }
    } catch (error) {
      return error.toString();
    }
    return token;
  }
}
