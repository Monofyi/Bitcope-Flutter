import 'dart:async';
import 'package:bitcope/features/login_register/data/datasources/bitecope_api_call.dart';
import 'package:bitcope/features/login_register/data/model/token.dart';
import 'package:bitcope/features/login_register/data/model/user_login.dart';
import 'package:bitcope/features/login_register/data/model/user_model.dart';
import 'package:bitcope/core/database/user_database_operations.dart';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class UserRepository {
  final userDatabaseOps = UserDatabaseOps();
  bool showPasswordBool = false;
  Future<User> authenticate({
    @required String username,
    @required String password,
  }) async {
    UserLogin userLogin = UserLogin(username: username, password: password);
    Token token = await getTokenUsingLogin(userLogin);
    User user = User(
      id: 0,
      username: username,
      token: token.token,
    );
    return user;
  }

  Future<void> persistToken({@required User user}) async {
    // write token with the user to the database
    await userDatabaseOps.createUser(user);
  }

  Future<void> deleteToken({@required int id}) async {
    await userDatabaseOps.deleteUser(id);
  }

  Future<bool> hasToken() async {
    bool result = await userDatabaseOps.checkUser(0);
    return result;
  }

  bool showProgressBar() {
    bool showProgress = false;
    return showProgress;
  }

  void flipBool() {
    showPasswordBool = !showPasswordBool;
    print(showPasswordBool);
  }

  IconData getPasswordIcon() {
    print("get:" + showPasswordBool.toString());
    if (showPasswordBool) {
      return Icons.visibility;
    } else {
      return Icons.visibility_off;
    }
  }

  // IconData showIcon({bool visible}) {
  //   print("visible " + visible.toString());
  //   if (visible) {
  //     return Icons.visibility;
  //   } else {
  //     return Icons.visibility_off;
  //   }
  //}
}
