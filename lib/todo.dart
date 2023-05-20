import 'package:flutter/foundation.dart' show immutable;
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

// Model pour la class ToDo
@immutable
class Todo {
  const Todo({
    required this.description,
    required this.id,
    this.completed = false,
  });

  final String id;
  final String description;
  final bool completed;
}

const _uuid = Uuid();

class TodoList extends StateNotifier<List<Todo>> {
  TodoList([List<Todo>? initialTodos]) : super(initialTodos ?? []);

  //Ajoute des items a la la todo list
  void add(String description) {
    state = [
      ...state,
      Todo(
        id: _uuid.v4(),
        description: description,
      ),
    ];
  }

  // Alterne entre coché ou non
  void toggle(String id) {
    final newState = [...state];
    final todoToReplaceIndex = state.indexWhere((todo) => todo.id == id);

    if (todoToReplaceIndex != -1) {
      newState[todoToReplaceIndex] = Todo(
        id: newState[todoToReplaceIndex].id,
        completed: !newState[todoToReplaceIndex].completed,
        description: newState[todoToReplaceIndex].description,
      );
    }

    state = newState;
  }

  //Modifie un todo
  void edit({required String id, required String description}) {
    final newState = [...state];
    final todoToReplaceIndex = state.indexWhere((todo) => todo.id == id);

    if (todoToReplaceIndex != -1) {
      newState[todoToReplaceIndex] = Todo(
        id: newState[todoToReplaceIndex].id,
        completed: !newState[todoToReplaceIndex].completed,
        description: description,
      );
    }

    state = newState;
  }
}
