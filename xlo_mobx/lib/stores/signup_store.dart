import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';
part 'signup_store.g.dart';

class SignupStore = _SignupStore with _$SignupStore;

abstract class _SignupStore with Store {

  /*_SignupStore(){
    autorun((_){
      print(pass1);
      print(pass2);
    });
  }*/

  @observable
  String name;

  @action
  void setName(String value) => name = value;

  @computed
  bool get nameIsValid => name != null && name.isNotEmpty;
  String get nameError {
    if(name == null || nameIsValid)
      return null;
    else if(name.isEmpty)
      return 'Campo obrigatório!';
    else
      return 'Nome inválido.';
  }

  @observable
  String email;

  @action
  void setEmail(String value) => email = value;

  @computed
  bool get emailIsValid => email != null && email.isEmailValid();
  String get emailError {
    if(email == null || emailIsValid)
      return null;
    else if(email.isEmpty)
      return 'Campo obrigatório!';
    else
      return 'E-mail inválido.';
  }

  @observable
  String phone;

  @action
  void setPhone(String value) => phone = value;

  @computed
  bool get phoneIsValid => phone != null && phone.length >= 14;
  String get phoneError {
    if(phone == null || phoneIsValid)
      return null;
    else if(phone.isEmpty)
      return 'Campo obrigatório!';
    else
      return 'Celular inválido.';
  }

  @observable
  String pass1;

  @action
  void setPass1(String value) => pass1 = value;

  @computed
  bool get pass1IsValid => pass1 != null && pass1.isPasswordValid();
  String get pass1Error {
    if(pass1 == null || pass1IsValid)
      return null;
    else if(pass1.isEmpty)
      return 'Campo obrigatório!';
    else if(pass1.length < 8)
      return 'A senha deve conter pelo menos 8 dígitos.';
    else
      return 'Senha inválida';
  }

  @observable
  String pass2;

  @action
  void setPass2(String value) => pass2 = value;

  @computed
  bool get pass2IsValid => pass2 != null && pass2 == pass1;
  String get pass2Error {
    if(pass2 == null || pass2IsValid)
      return null;
    else
      return 'As senhas não coincidem!';
  }

  @computed
  bool get isFormValid =>
      nameIsValid && emailIsValid &&
          phoneIsValid && pass1IsValid && pass2IsValid;

  @computed
  Function get signUpPressed => (isFormValid && !loading) ? _signUp : null;

  @observable
  bool loading = false;

  @observable
  String error;

  @observable
  bool userChecked = false;

  @action
  Future<void> _signUp () async {
    loading = true;

    final user = User(
      name: name,
      email: email,
      phone: phone,
      password: pass1
    );

    try {
      final resultUser = await UserRespository().signUp(user);
      GetIt.I<UserManagerStore>().setUser(resultUser);
    } catch(e) {
      error = e;
    }

    userChecked = true;
    loading = false;
  }

}