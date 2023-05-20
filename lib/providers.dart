import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/todo.dart';

//Fournis une liste de tache avec une tache définis par défaut
final todoListProvider = StateNotifierProvider<TodoList, List<Todo>>((ref) {
  return TodoList(const [
    Todo(id: '0', description: 'Faire les courses'),
  ]);
});

/// Enum avec les différents filtre possible
enum TodoListFilter {
  all,
  active,
  completed,
}

// Définis todoListFilter avec comme état de base all
final todoListFilter = StateProvider((_) => TodoListFilter.all);

//Change le filtre et met a jour le TodoListFilter au click
final filteredTodos = Provider<List<Todo>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todos = ref.watch(todoListProvider);

  switch (filter) {
    case TodoListFilter.completed:
      return todos.where((todo) => todo.completed).toList();
    case TodoListFilter.active:
      return todos.where((todo) => !todo.completed).toList();
    case TodoListFilter.all:
      return todos;
  }
});

//Montre le nombre de ToDo restant
final uncompletedTodosCount = Provider<int>((ref) {
  return ref.watch(todoListProvider).where((todo) => !todo.completed).length;
});
