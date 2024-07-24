class Stats {
   int total;
   int correct;
   int topicId;


  Stats({required this.total, required this.correct, required this.topicId}); 
  Stats.empty():  total=0, correct= 0, topicId = 0 ; 

  Stats.fromJson(Map<String, dynamic> jsonData)
      : total = jsonData['total'],
        correct = jsonData['correct'],
        topicId = jsonData['topicId'];
      

 Map<String, dynamic> toJson() => {
        'total': total,
        'correct': correct,
        'topicId':topicId, 
      };
}