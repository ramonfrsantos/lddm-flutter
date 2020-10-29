import 'package:mobx/mobx.dart';

part 'signup_store.g.dart';

class SignupStore = _SignupStore with _$SignupStore;

abstract class _SignupStore with Store {

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
      return 'Nome inválido';
  }

}