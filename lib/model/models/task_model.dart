class TaskModel {
  final String? title;
  final String? dateTime;
  final String? level;
  final bool isDone;
  final int? id;

  TaskModel({
    this.title,
    this.dateTime,
    this.level,
    this.isDone = false,
    this.id,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
        title: map["title"],
        dateTime: map["dateTime"],
        level: map["level"],
        isDone: map["isDone"] == 0 ? false : true,
        id: map["id"]);
  }
  Map<String, dynamic> toMap() {
    return {
       if (id != null) "id": id,
      if (title != null) "title": title,
      if (level != null) "level": level,
      if (dateTime != null) "dateTime": dateTime,
      "isDone": isDone ? 1 : 0,
    }; //this func convert object to map
  }
}
