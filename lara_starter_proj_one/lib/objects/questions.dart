
class Question {
  final String question;
  final int id;
  final List<dynamic> options; 
  final String questionPath;
  final String? imageUrl; 

  Question.empty( ): question ="Test", id= 1, options=[], questionPath="", imageUrl=null ; 

  Question.fromJson(Map<String, dynamic> jsonData)
      : question = jsonData['question'],
        id = jsonData['id'],
        options  = jsonData['options'],
        questionPath = jsonData['answer_post_path'],
        imageUrl= jsonData['image_url'];
}
