import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {

  @observable
  String email;

  @action
  void setEmail(String value) => email = value;

  @computed
  bool get emailIsValid => email != null && email.isEmailValid();
  String get emailError {
    if(email == null || emailIsValid)
      return null;
    else
      return 'E-mail inválido.';
  }

  @observable
  String password;

  @action
  void setPassword(String value) => password = value;

  @computed
  bool get passwordIsValid => password != null && password.length >= 4;
  String get passwordError =>
      password == null || passwordIsValid ? null : 'Senha inválida';

  @computed
  Function get loginPressed => emailIsValid && passwordIsValid && !loading
      ? _login
      : null;

  @observable
  bool loading = false;

  @observable
  String error;

  @observable
  bool userChecked = false;

  @action
  Future<void> _login() async{
    loading = true;

    try {
      final user = await UserRespository().loginWithEmail(email, password);
      GetIt.I<UserManagerStore>().setUser(user);
    } catch(e) {
      error = e;
    }

    userChecked = true;
    loading = false;
  }
}
