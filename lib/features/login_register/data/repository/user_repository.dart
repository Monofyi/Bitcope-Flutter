import 'dart:async';
import 'package:bitcope/features/login_register/data/datasources/bitecope_api_call_login_register.dart';
import 'package:bitcope/core/model/token.dart';
import 'package:bitcope/features/login_register/data/model/user_login.dart';
import 'package:bitcope/features/login_register/data/model/user_model.dart';
import 'package:bitcope/core/database/user_database_operations.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class UserRepository {
  final userDatabaseOps = UserDatabaseOps();
  Future<User> authenticate({
    @required String username,
    @required String password,
    @required String url,
  }) async {
    UserLogin userLogin = UserLogin(username: username, password: password);
    Token token = await getTokenUsingLogin(userLogin, url);
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
}
