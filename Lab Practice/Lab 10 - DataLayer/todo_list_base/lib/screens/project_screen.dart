import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list_base/model/project_todo_status_counts.dart';
import 'package:todo_list_base/providers/project_provider.dart';
import 'package:todo_list_base/providers/repo_provider.dart';
import '../model/project.dart';

class ProjectScreen extends ConsumerWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Explain the projectProvider which return the list of projects
    final projectProvider = ref.watch(projectNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
      ),
      body: projectProvider.when(
        data: (projects) {
          if (projects.isEmpty) {
            return const Center(child: Text('No Projects Available'));
          }
          return ListView.builder(
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];

              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: InkWell(
                  onTap: () {
                    ref.read(selectedProjectIdProvider.notifier).state =
                        project.id!;
                    context.go('/projects/${project.id}/todos');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Project Icon
                        const Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Icon(
                            Icons.folder_open,
                            size: 40,
                            color: Colors.blueAccent,
                          ),
                        ),
                        // Project Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                project.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Existing StreamBuilder for counts
                              StreamBuilder<ProjectTodoStatusCounts?>(
                                stream: ref
                                    .read(projectNotifierProvider.notifier)
                                    .getProjectTodosStatusCounts(project.id!),
                                builder: (context, snapshot) {
                                  final counts = snapshot.data;
                                  return Row(
                                    children: [
                                      // Pending Count
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.pending_actions,
                                            color: Colors.orange,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${counts?.pendingCount ?? 0} Pending',
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 16),
                                      // Completed Count
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${counts?.completedCount ?? 0} Completed',
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        // Action Buttons
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _showProjectDialog(
                                context,
                                ref,
                                project: project,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                ref
                                    .read(projectNotifierProvider.notifier)
                                    .deleteProject(project);
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
        onPressed: () => _showProjectDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showProjectDialog(
    BuildContext context,
    WidgetRef ref, {
    Project? project,
  }) {
    final isEditing = project != null;
    final controller = TextEditingController(text: project?.name ?? '');

    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isEditing ? 'Edit Project' : 'Add Project',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    labelText: 'Project Name',
                    border: OutlineInputBorder(),
                  ),
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
                      onPressed: () => context.pop(),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        final projectName = controller.text.trim();
                        if (projectName.isNotEmpty) {
                          if (isEditing) {
                            final updatedProject =
                                Project(project.id, projectName);
                            ref
                                .read(projectNotifierProvider.notifier)
                                .updateProject(updatedProject);
                          } else {
                            final newProject = Project(null, projectName);
                            ref
                                .read(projectNotifierProvider.notifier)
                                .addProject(newProject);
                          }
                        }
                        context.pop();
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
    );
  }
}
