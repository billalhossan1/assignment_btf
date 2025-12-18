import 'package:flutter/material.dart';
import 'package:assignment_btf/constant/app_colors.dart';
import 'package:assignment_btf/controllers/task_controller.dart';
import 'package:assignment_btf/screens/tasks/task_detail_screen.dart';
import 'package:assignment_btf/widgets/cards/task_card.dart';
import 'package:assignment_btf/widgets/empty_state/empty_state_widget.dart';
import 'package:assignment_btf/widgets/texts/app_text.dart';
import 'package:assignment_btf/utils/app_size.dart';
import 'package:get/get.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskController = Get.put(TaskController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.instance.dark900
          : AppColors.instance.white100,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(AppSize.width(value: 20.0)),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.instance.dark800
                    : AppColors.instance.white50,
                boxShadow: [
                  BoxShadow(
                    color:
                        (isDark
                                ? AppColors.instance.dark900
                                : AppColors.instance.dark500)
                            .withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  AppText(
                    data: 'My Tasks',
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: isDark
                        ? AppColors.instance.white200
                        : AppColors.instance.dark500,
                  ),
                  SizedBox(height: AppSize.height(value: 12.0)),

                  // Stats
                  Obx(
                    () => Row(
                      children: [
                        _buildStatChip(
                          context,
                          icon: Icons.pending_actions,
                          label: 'Pending',
                          count: taskController.pendingTasksCount,
                          color: AppColors.instance.primary,
                        ),
                        SizedBox(width: AppSize.width(value: 12.0)),
                        _buildStatChip(
                          context,
                          icon: Icons.check_circle,
                          label: 'Completed',
                          count: taskController.completedTasksCount,
                          color: AppColors.instance.green500,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Task list
            Expanded(
              child: Obx(() {
                if (taskController.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.instance.primary,
                    ),
                  );
                }

                if (taskController.tasks.isEmpty) {
                  return EmptyStateWidget(
                    icon: Icons.task_alt_outlined,
                    title: 'No Tasks Yet',
                    message:
                        'Start organizing your day by adding your first task!',
                    actionButton: _buildAddTaskButton(context),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.all(AppSize.width(value: 16.0)),
                  itemCount: taskController.tasks.length,
                  itemBuilder: (context, index) {
                    final task = taskController.tasks[index];
                    return TaskCard(
                      task: task,
                      onTap: () {
                        Get.to(
                          () => TaskDetailScreen(task: task),
                          transition: Transition.rightToLeft,
                        );
                      },
                      onToggle: () =>
                          taskController.toggleTaskCompletion(task.id),
                      onDelete: () => taskController.deleteTask(task.id),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(
        () => taskController.tasks.isNotEmpty
            ? FloatingActionButton.extended(
                onPressed: () {
                  Get.to(
                    () => const TaskDetailScreen(),
                    transition: Transition.rightToLeft,
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Task'),
                backgroundColor: AppColors.instance.primary,
                foregroundColor: AppColors.instance.white50,
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildStatChip(
    BuildContext context, {
    required IconData icon,
    required String label,
    required int count,
    required Color color,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.width(value: 12.0),
        vertical: AppSize.height(value: 8.0),
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          SizedBox(width: AppSize.width(value: 6.0)),
          AppText(
            data: '$count $label',
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isDark
                ? AppColors.instance.white200
                : AppColors.instance.dark500,
          ),
        ],
      ),
    );
  }

  Widget _buildAddTaskButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Get.to(
          () => const TaskDetailScreen(),
          transition: Transition.rightToLeft,
        );
      },
      icon: const Icon(Icons.add),
      label: const Text('Add Your First Task'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.instance.primary,
        foregroundColor: AppColors.instance.white50,
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.width(value: 24.0),
          vertical: AppSize.height(value: 14.0),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
