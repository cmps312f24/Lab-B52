import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/model/todo.dart';
// import 'package:todo_list/providers/repo_provider.dart';
import 'package:todo_list/providers/todo_provider.dart';

class TodoScreen extends ConsumerWidget {
  final String pid;
  const TodoScreen({super.key, required this.pid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.read(selectedProjectIdProvider.notifier).state = pid;
    final todoList = ref.watch(todoNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      body: todoList.when(
        data: (todos) {
          if (todos.isEmpty) {
            return const Center(child: Text('No Todos Available'));
          }
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: InkWell(
                  onTap: () =>
                      _showTodoDialog(context, ref, todo: todo, projectId: pid),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          todo.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today,
                                size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(todo.date),
                            const SizedBox(width: 16),
                            const Icon(Icons.access_time,
                                size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(todo.time),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: [
                            Chip(
                              label: Text(todo.priority),
                              backgroundColor: _getPriorityColor(todo.priority),
                            ),
                            Chip(
                              label: Text(todo.status),
                              backgroundColor: _getStatusColor(todo.status),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _showTodoDialog(context, ref,
                                  todo: todo, projectId: pid),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                ref
                                    .read(todoNotifierProvider.notifier)
                                    .deleteTodo(todo);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            Center(child: Text('Error: ${error.toString()}')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTodoDialog(context, ref, projectId: pid),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showTodoDialog(
    BuildContext context,
    WidgetRef ref, {
    Todo? todo,
    required String projectId,
  }) {
    final isEditing = todo != null;
    final titleController = TextEditingController(text: todo?.title ?? '');
    DateTime? selectedDate = isEditing ? DateTime.parse(todo.date) : null;
    TimeOfDay? selectedTime = isEditing ? _parseTimeOfDay(todo.time) : null;
    String selectedStatus = todo?.status ?? 'Pending';
    String selectedPriority = todo?.priority ?? 'Low';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: StatefulBuilder(
            builder: (dialogContext, setState) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isEditing ? 'Edit Todo' : 'Add Todo',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: selectedStatus,
                        decoration: const InputDecoration(
                          labelText: 'Status',
                          border: OutlineInputBorder(),
                        ),
                        items: ['Pending', 'Completed'].map((status) {
                          return DropdownMenuItem(
                            value: status,
                            child: Text(status),
                          );
                        }).toList(),
                        onChanged: (value) =>
                            setState(() => selectedStatus = value!),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: selectedPriority,
                        decoration: const InputDecoration(
                          labelText: 'Priority',
                          border: OutlineInputBorder(),
                        ),
                        items: ['Low', 'Medium', 'High'].map((priority) {
                          return DropdownMenuItem(
                            value: priority,
                            child: Text(priority),
                          );
                        }).toList(),
                        onChanged: (value) =>
                            setState(() => selectedPriority = value!),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton.icon(
                              icon: const Icon(Icons.calendar_today),
                              label: Text(
                                selectedDate == null
                                    ? 'Select Date'
                                    : selectedDate!
                                        .toLocal()
                                        .toIso8601String()
                                        .split('T')
                                        .first,
                              ),
                              onPressed: () async {
                                final pickedDate = await showDatePicker(
                                  context: dialogContext,
                                  initialDate: selectedDate ?? DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );
                                if (pickedDate != null) {
                                  setState(() => selectedDate = pickedDate);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextButton.icon(
                              icon: const Icon(Icons.access_time),
                              label: Text(
                                selectedTime == null
                                    ? 'Select Time'
                                    : selectedTime!.format(dialogContext),
                              ),
                              onPressed: () async {
                                final pickedTime = await showTimePicker(
                                  context: dialogContext,
                                  initialTime: selectedTime ?? TimeOfDay.now(),
                                );
                                if (pickedTime != null) {
                                  setState(() => selectedTime = pickedTime);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () => Navigator.of(dialogContext).pop(),
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              final title = titleController.text.trim();
                              if (title.isNotEmpty &&
                                  selectedDate != null &&
                                  selectedTime != null) {
                                final newTodo = Todo(
                                  todo?.id ?? '',
                                  title,
                                  selectedStatus,
                                  selectedPriority,
                                  selectedDate!
                                      .toIso8601String()
                                      .split('T')
                                      .first,
                                  selectedTime!.format(context),
                                  projectId,
                                );
                                if (isEditing) {
                                  ref
                                      .read(todoNotifierProvider.notifier)
                                      .updateTodo(newTodo);
                                } else {
                                  ref
                                      .read(todoNotifierProvider.notifier)
                                      .addTodo(newTodo);
                                }
                              }
                              Navigator.of(dialogContext).pop();
                            },
                            child: Text(isEditing ? 'Update' : 'Save'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  TimeOfDay _parseTimeOfDay(String timeString) {
    final timeParts = timeString.split(' ');
    final hourMinute = timeParts[0].split(':');
    var hour = int.parse(hourMinute[0]);
    final minute = int.parse(hourMinute[1]);
    final period = timeParts.length > 1 ? timeParts[1].toUpperCase() : null;

    if (period == "PM" && hour != 12) {
      hour += 12;
    } else if (period == "AM" && hour == 12) {
      hour = 0;
    }
    return TimeOfDay(hour: hour, minute: minute);
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.redAccent;
      case 'Medium':
        return Colors.orangeAccent;
      case 'Low':
        return Colors.greenAccent;
      default:
        return Colors.grey;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.blueAccent;
      case 'Pending':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
}
