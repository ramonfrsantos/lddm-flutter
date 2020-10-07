import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {

  @observable
  bool passwordVisibility = false;

  @action
  void togglePasswordVisibility() => passwordVisibility = !passwordVisibility;

  @observable
  bool loading = false;

  @observable
  String email = "";

  @action
  void setEmail(String value) => email = value;

  @observable
  String password = "";

  @action
  void setPassword(String value) => password = value;

  @observable
  bool loggedIn = false;

  @computed
  bool get isEmailValid => 
      RegExp(r"^[_a-z0-9-]+(.[a-z0-9-]+)@[a-z0-9-]+(.[a-z0-9-]+)*(.[a-z]{2,4})$")
  .hasMatch(email);

  @computed
  bool get isPasswordValid => password.length > 6;

 /* @computed
  bool get isFormValid => isEmailValid && isPasswordValid;
*/
  @computed
  Function get loginPressed => (isEmailValid && isPasswordValid && !loading) ? login : null;

  @action
  Future<void> login() async {
    loading = true;

    await Future.delayed(Duration(seconds: 3));

    loading = false;
    loggedIn = true;

    email = "";
    password = "";
  }

  @action
  void logout(){
    loggedIn = false;
  }
}
