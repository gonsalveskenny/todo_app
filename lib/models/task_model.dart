class TaskModel {
  String? sId;
  String? taskName;
  String? taskDescription;

  TaskModel({this.sId, this.taskName, this.taskDescription});

  TaskModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    taskName = json['taskName'];
    taskDescription = json['taskDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['taskName'] = taskName;
    data['taskDescription'] = taskDescription;
    return data;
  }
}
