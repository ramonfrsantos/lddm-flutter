import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';

class UserRespository {

  Future<void> signUp(User user) async {
    final parseUser = ParseUser(
      user.email, user.password, user.email
    );

    parseUser.set<String>(keyUserName, user.name);
    parseUser.set<String>(keyUserPhone, user.phone);
    parseUser.set(keyUserType, user.type.index); // index armazena valores de 0 e de 1, para os tipos

    await parseUser.signUp();
  }

}