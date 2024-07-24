class Response {
  final bool correct; 

  Response.fromJson(Map<String, dynamic> jsonData)
      : correct = jsonData['correct'];
}
