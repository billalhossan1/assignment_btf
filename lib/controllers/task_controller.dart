import 'dart:convert';
import 'package:assignment_btf/models/task_model.dart';
import 'package:assignment_btf/services/notification/local_notification_service.dart';
import 'package:assignment_btf/services/storage_services/get_storage_services.dart';
import 'package:assignment_btf/utils/error_log.dart';
import 'package:assignment_btf/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  final _storageService = GetStorageServices.instance;
  final _notificationService = LocalNotificationService.instance;

  // Reactive task list
  final RxList<TaskModel> tasks = <TaskModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  // Load tasks from storage
  void loadTasks() {
    try {
      isLoading.value = true;
      final storedTasks = _storageService.getTasks();
      tasks.value = storedTasks
          .map((json) => TaskModel.fromJson(json))
          .toList();
      // Sort by creation date (newest first)
      tasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } catch (e) {
      errorLog("TaskController loadTasks", e);
      AppSnackBar.error("Failed to load tasks");
    } finally {
      isLoading.value = false;
    }
  }

  // Save tasks to storage
  Future<void> _saveTasks() async {
    try {
      final tasksJson = tasks.map((task) => task.toJson()).toList();
      await _storageService.saveTasks(tasksJson);
    } catch (e) {
      errorLog("TaskController saveTasks", e);
    }
  }

  // Add new task
  Future<void> addTask({
    required String title,
    required String description,
    DateTime? reminderTime,
  }) async {
    try {
      if (title.trim().isEmpty) {
        AppSnackBar.error("Task title cannot be empty");
        return;
      }

      final newTask = TaskModel(
        id: TaskModel.generateId(),
        title: title,
        description: description,
        createdAt: DateTime.now(),
        reminderTime: reminderTime,
      );

      tasks.insert(0, newTask);
      await _saveTasks();

      // Schedule notification if reminder time is set
      if (reminderTime != null && reminderTime.isAfter(DateTime.now())) {
        await _scheduleNotification(newTask);
      }

      AppSnackBar.success("Task added successfully");
    } catch (e) {
      errorLog("TaskController addTask", e);
      AppSnackBar.error("Failed to add task");
    }
  }

  // Update existing task
  Future<void> updateTask({
    required String id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? reminderTime,
  }) async {
    try {
      final index = tasks.indexWhere((task) => task.id == id);
      if (index == -1) {
        AppSnackBar.error("Task not found");
        return;
      }

      final updatedTask = tasks[index].copyWith(
        title: title,
        description: description,
        isCompleted: isCompleted,
        reminderTime: reminderTime,
      );

      tasks[index] = updatedTask;
      await _saveTasks();

      // Update notification
      await _notificationService.cancelNotification(id.hashCode);
      if (reminderTime != null &&
          reminderTime.isAfter(DateTime.now()) &&
          !updatedTask.isCompleted) {
        await _scheduleNotification(updatedTask);
      }

      AppSnackBar.success("Task updated successfully");
    } catch (e) {
      errorLog("TaskController updateTask", e);
      AppSnackBar.error("Failed to update task");
    }
  }

  // Toggle task completion
  Future<void> toggleTaskCompletion(String id) async {
    try {
      final index = tasks.indexWhere((task) => task.id == id);
      if (index == -1) return;

      final task = tasks[index];
      final updatedTask = task.copyWith(isCompleted: !task.isCompleted);

      tasks[index] = updatedTask;
      await _saveTasks();

      // Cancel notification if task is completed
      if (updatedTask.isCompleted) {
        await _notificationService.cancelNotification(id.hashCode);
      } else if (updatedTask.reminderTime != null &&
          updatedTask.reminderTime!.isAfter(DateTime.now())) {
        await _scheduleNotification(updatedTask);
      }
    } catch (e) {
      errorLog("TaskController toggleTaskCompletion", e);
      AppSnackBar.error("Failed to update task");
    }
  }

  // Delete task
  Future<void> deleteTask(String id) async {
    try {
      tasks.removeWhere((task) => task.id == id);
      await _saveTasks();
      await _notificationService.cancelNotification(id.hashCode);
      AppSnackBar.success("Task deleted successfully");
    } catch (e) {
      errorLog("TaskController deleteTask", e);
      AppSnackBar.error("Failed to delete task");
    }
  }

  // Schedule notification for task
  Future<void> _scheduleNotification(TaskModel task) async {
    if (task.reminderTime == null ||
        task.reminderTime!.isBefore(DateTime.now())) {
      return;
    }

    try {
      await _notificationService.scheduleTaskReminder(
        id: task.id.hashCode,
        title: "Task Reminder",
        body: task.title,
        scheduledTime: task.reminderTime!,
      );
    } catch (e) {
      errorLog("TaskController scheduleNotification", e);
    }
  }

  // Get completed tasks count
  int get completedTasksCount => tasks.where((task) => task.isCompleted).length;

  // Get pending tasks count
  int get pendingTasksCount => tasks.where((task) => !task.isCompleted).length;

  // Get tasks with reminders
  List<TaskModel> get tasksWithReminders =>
      tasks.where((task) => task.reminderTime != null).toList();
}
