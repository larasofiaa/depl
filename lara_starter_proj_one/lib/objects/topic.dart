class Topic {
  final String name;
  final int id;
  final String questionPath;

  Topic(this.name, this.id, this.questionPath); 

  Topic.fromJson(Map<String, dynamic> jsonData)
      : name = jsonData['name'],
        id = jsonData['id'],
        questionPath = jsonData['question_path'];
}
