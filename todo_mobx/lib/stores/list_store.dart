import 'package:mobx/mobx.dart';
import 'package:todomobx/stores/todo_store.dart';

part 'list_store.g.dart';

class ListStore = _ListStore with _$ListStore;

abstract class _ListStore with Store {

  @observable
  String newToDoTitle = " ";

  @action
  void setNewToDoTitle(String value) => newToDoTitle = value;

  @computed
  bool get isFormValid => newToDoTitle.isNotEmpty;

  ObservableList<ToDoStore> toDoList = ObservableList<ToDoStore>(); //lista internamente observavel

  @action
  void addToDo(){
    toDoList.insert(0, ToDoStore(newToDoTitle));
    newToDoTitle = "";
  }

  /*@observable //não é a melhor maneira de usar lista em observable
  List<String> toDoList = [];

  @action
  void addToDo(){
    toDoList = List.from(toDoList..add(newToDoTitle)); // cria uma nova lista através do novo elemento
  }*/
}