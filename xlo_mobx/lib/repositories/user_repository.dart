import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/parse_errors.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';

class UserRespository {

  Future<User> signUp(User user) async {
    final parseUser = ParseUser(
      user.email, user.password, user.email
    );

    parseUser.set<String>(keyUserName, user.name);
    parseUser.set<String>(keyUserPhone, user.phone);
    parseUser.set(keyUserType, user.type.index); // index armazena valores de 0 e de 1, para os tipos

    final response = await parseUser.signUp();

    if(response.success){
      return mapParseToUser(response.result);
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<User> loginWithEmail(String email, String password) async {
    final parseUser = ParseUser(email, password, null);

    final response = await parseUser.login();
    
    if(response.success){
      return mapParseToUser(response.result);
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  // Pegar todas as informações relacionadas ao parse e concentrar dentro do repositório
  User mapParseToUser(ParseUser parseUser){
    return User(
      name: parseUser.get(keyUserName),
      email: parseUser.get(keyUserEmail),
      phone: parseUser.get(keyUserPhone),
      createdAt: parseUser.get(keyUserCreatedAt),
      id: parseUser.objectId,
      type: UserType.values[parseUser.get(keyUserType)] // transforma o enumerador numa lista de elementos
    );
  }

}