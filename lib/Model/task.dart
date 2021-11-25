final String tableTask = 'tasks';

class Task {
  final int? taskID;
  final String taskTitle;
  final String taskDescription;
  final String taskCategory;

  const Task(
      {this.taskID,
      required this.taskTitle,
      required this.taskDescription,
      required this.taskCategory});

  Map<String, Object?> toJson() => {
        TaskFields.taskID: taskID,
        TaskFields.taskTitle: taskTitle,
        TaskFields.taskDescription: taskDescription,
        TaskFields.taskCategory: taskCategory,
      };

  Task copy(
          {int? taskID,
          String? taskTitle,
          String? taskDescription,
          String? taskCategory}) =>
      Task(
          taskID: taskID ?? this.taskID,
          taskTitle: taskTitle ?? this.taskTitle,
          taskDescription: taskDescription ?? this.taskDescription,
          taskCategory: taskCategory ?? this.taskCategory);

  static Task fromJson(Map<String, Object?> json) => Task(
      taskID: json[TaskFields.taskID] as int?,
      taskTitle: json[TaskFields.taskTitle] as String,
      taskDescription: json[TaskFields.taskDescription] as String,
      taskCategory: json[TaskFields.taskCategory] as String);
}

class TaskFields {
  static final List<String> values = [
    taskID,
    taskTitle,
    taskDescription,
    taskCategory
  ];

  static final String taskID = '_taskID';
  static final String taskTitle = 'taskTitle';
  static final String taskDescription = 'taskDescription';
  static final String taskCategory = 'taskCategory';
}
