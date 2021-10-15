class Todo {
  final int id;
  String title;
  String? details;
  bool completed;

  Todo(
      {required this.id,
      required this.title,
      this.details,
      this.completed = false});

  @override
  String toString() {
    return title;
  }

  static List<Todo> getStaticTodos() {
    List<Map<String, String>> todoMapList = [
      {
        "title": "Call Joy",
        "details": "Call Joy by 12:00 am",
        "completed": "false"
      },
      {
        "title": "Buy Eggs",
        "details": "Buy Eggs for Party",
        "completed": "true"
      }
    ];

    int idCounter = 0;
    return List.from(todoMapList.map((e) {
      return Todo(
          id: ++idCounter,
          title: e["title"]!,
          details: e["details"] ?? "",
          completed: (e["completed"]! == "true"));
    }));
  }
}
