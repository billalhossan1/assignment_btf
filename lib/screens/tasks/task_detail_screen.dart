import 'package:flutter/material.dart';
import 'package:assignment_btf/constant/app_colors.dart';
import 'package:assignment_btf/controllers/task_controller.dart';
import 'package:assignment_btf/models/task_model.dart';
import 'package:assignment_btf/widgets/buttons/app_button.dart';
import 'package:assignment_btf/widgets/inputs/app_input_widget.dart';
import 'package:assignment_btf/widgets/texts/app_text.dart';
import 'package:assignment_btf/utils/app_size.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskDetailScreen extends StatefulWidget {
  const TaskDetailScreen({super.key, this.task});

  final TaskModel? task;

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final Rx<DateTime?> _selectedReminderTime = Rx<DateTime?>(null);
  final taskController = Get.find<TaskController>();

  bool get isEditMode => widget.task != null;

  @override
  void initState() {
    super.initState();
    if (isEditMode) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _selectedReminderTime.value = widget.task!.reminderTime;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectReminderTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate:
          _selectedReminderTime.value ??
          DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: AppColors.instance.primary),
          ),
          child: child!,
        );
      },
    );

    if (date != null && mounted) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
          _selectedReminderTime.value ?? DateTime.now(),
        ),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.instance.primary,
              ),
            ),
            child: child!,
          );
        },
      );

      if (time != null) {
        _selectedReminderTime.value = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );
      }
    }
  }

  Future<void> _saveTask() async {
    if (!_formKey.currentState!.validate()) return;

    if (isEditMode) {
      await taskController.updateTask(
        id: widget.task!.id,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        reminderTime: _selectedReminderTime.value,
      );
    } else {
      await taskController.addTask(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        reminderTime: _selectedReminderTime.value,
      );
    }

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.instance.dark900
          : AppColors.instance.white100,
      appBar: AppBar(
        backgroundColor: isDark
            ? AppColors.instance.dark800
            : AppColors.instance.white50,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark
                ? AppColors.instance.white200
                : AppColors.instance.dark500,
          ),
          onPressed: () => Get.back(),
        ),
        title: AppText(
          data: isEditMode ? 'Edit Task' : 'New Task',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: isDark
              ? AppColors.instance.white200
              : AppColors.instance.dark500,
        ),
        actions: [
          if (isEditMode)
            IconButton(
              icon: Icon(Icons.delete_outline, color: AppColors.instance.error),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Task'),
                    content: const Text(
                      'Are you sure you want to delete this task?',
                    ),
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

                if (confirm == true) {
                  await taskController.deleteTask(widget.task!.id);
                  Get.back();
                }
              },
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(AppSize.width(value: 20.0)),
          children: [
            // Title input
            AppText(
              data: 'Title',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppColors.instance.white200
                  : AppColors.instance.dark500,
            ),
            SizedBox(height: AppSize.height(value: 8.0)),
            AppInputWidget(
              controller: _titleController,
              hintText: 'Enter task title',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            SizedBox(height: AppSize.height(value: 20.0)),

            // Description input
            AppText(
              data: 'Description',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppColors.instance.white200
                  : AppColors.instance.dark500,
            ),
            SizedBox(height: AppSize.height(value: 8.0)),
            AppInputWidget(
              controller: _descriptionController,
              hintText: 'Enter task description (optional)',
              maxLines: 5,
            ),
            SizedBox(height: AppSize.height(value: 20.0)),

            // Reminder section
            AppText(
              data: 'Reminder',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppColors.instance.white200
                  : AppColors.instance.dark500,
            ),
            SizedBox(height: AppSize.height(value: 8.0)),

            Obx(
              () => GestureDetector(
                onTap: _selectReminderTime,
                child: Container(
                  padding: EdgeInsets.all(AppSize.width(value: 16.0)),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.instance.dark800
                        : AppColors.instance.white50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark
                          ? AppColors.instance.dark700
                          : AppColors.instance.white300,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.notifications_outlined,
                        color: AppColors.instance.primary,
                        size: 24,
                      ),
                      SizedBox(width: AppSize.width(value: 12.0)),
                      Expanded(
                        child: AppText(
                          data: _selectedReminderTime.value != null
                              ? DateFormat(
                                  'MMM dd, yyyy • hh:mm a',
                                ).format(_selectedReminderTime.value!)
                              : 'Set reminder time',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: _selectedReminderTime.value != null
                              ? (isDark
                                    ? AppColors.instance.white200
                                    : AppColors.instance.dark500)
                              : (isDark
                                    ? AppColors.instance.dark300
                                    : AppColors.instance.dark200),
                        ),
                      ),
                      if (_selectedReminderTime.value != null)
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            color: isDark
                                ? AppColors.instance.dark300
                                : AppColors.instance.dark200,
                            size: 20,
                          ),
                          onPressed: () => _selectedReminderTime.value = null,
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: AppSize.height(value: 32.0)),

            // Save button
            AppButton(
              title: isEditMode ? 'Update Task' : 'Create Task',
              onTap: _saveTask,
              height: 52,
            ),
          ],
        ),
      ),
    );
  }
}
