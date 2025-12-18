import 'package:flutter/material.dart';
import 'package:assignment_btf/constant/app_colors.dart';
import 'package:assignment_btf/models/task_model.dart';
import 'package:assignment_btf/widgets/texts/app_text.dart';
import 'package:assignment_btf/utils/app_size.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
    required this.onToggle,
    required this.onDelete,
  });

  final TaskModel task;
  final VoidCallback onTap;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dismissible(
      key: Key(task.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: AppSize.width(value: 20.0)),
        decoration: BoxDecoration(
          color: AppColors.instance.error,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.delete_outline,
          color: AppColors.instance.white50,
          size: 28,
        ),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Task'),
            content: const Text('Are you sure you want to delete this task?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  'Delete',
                  style: TextStyle(color: AppColors.instance.error),
                ),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) => onDelete(),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(bottom: AppSize.height(value: 12.0)),
          padding: EdgeInsets.all(AppSize.width(value: 16.0)),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.instance.dark800
                : AppColors.instance.white50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: task.isCompleted
                  ? AppColors.instance.green500.withOpacity(0.3)
                  : (isDark
                        ? AppColors.instance.dark700
                        : AppColors.instance.white300),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color:
                    (isDark
                            ? AppColors.instance.dark900
                            : AppColors.instance.dark500)
                        .withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Checkbox
              GestureDetector(
                onTap: onToggle,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: task.isCompleted
                          ? AppColors.instance.green500
                          : (isDark
                                ? AppColors.instance.dark300
                                : AppColors.instance.dark200),
                      width: 2,
                    ),
                    color: task.isCompleted
                        ? AppColors.instance.green500
                        : Colors.transparent,
                  ),
                  child: task.isCompleted
                      ? Icon(
                          Icons.check,
                          size: 16,
                          color: AppColors.instance.white50,
                        )
                      : null,
                ),
              ),
              SizedBox(width: AppSize.width(value: 12.0)),

              // Task content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    AppText(
                      data: task.title,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: task.isCompleted
                          ? (isDark
                                ? AppColors.instance.dark300
                                : AppColors.instance.dark400)
                          : (isDark
                                ? AppColors.instance.white200
                                : AppColors.instance.dark500),
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                      maxLines: 2,
                    ),

                    // Description (if not empty)
                    if (task.description.isNotEmpty) ...[
                      SizedBox(height: AppSize.height(value: 6.0)),
                      AppText(
                        data: task.description,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: isDark
                            ? AppColors.instance.dark200
                            : AppColors.instance.dark300,
                        maxLines: 2,
                      ),
                    ],

                    // Reminder time (if set)
                    if (task.reminderTime != null) ...[
                      SizedBox(height: AppSize.height(value: 8.0)),
                      Row(
                        children: [
                          Icon(
                            Icons.notifications_outlined,
                            size: 16,
                            color: AppColors.instance.primary,
                          ),
                          SizedBox(width: AppSize.width(value: 6.0)),
                          AppText(
                            data: DateFormat(
                              'MMM dd, yyyy • hh:mm a',
                            ).format(task.reminderTime!),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.instance.primary,
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
