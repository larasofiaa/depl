# Device-Agnostic Design Course Project I - 47843937-af83-4079-9944-b49e7cab1870

Lara's Quizz App

Lara's Quizz App is a web application that provides you with the option to test your knowledge regarding the topics and questions provided by " https://dad-quiz-api.deno.dev/topics."

On the landing screen, you can either start training yourself by clicking on one of the provided topics, or you can access the statistics to see your previous achievements in the top right corner of the screen. 

Once you start training and click on a topic, you are redirected to a screen that will confront you with a question and various answer options for that question. Once that you select an answer option, you will find out whether the answer was answered correctly or wrongly. 
If you managed to answer correctly, you will see a button to be questioned another question on the same topic. If you chose the wrong answer options, you will be told and you can try your luck again with the remaining options. 

Before quitting the game for the day, make sure to check out your results on the statistic screen that you can always access by clicking on the button on the top right. 


*3 key challenges faced during the project*
Understanding the State Provider fully was challenging for me. It was confusing at first that the Scope is defined in the main function, because it would have felt more intuitive to define a scope for an object where the actual object is defined. 

Another key learning for me was that it seems to make sense to avoid having dependencies between different provider. It seems to be better to have different provider that are each independent and that are then observed from a third party that might create a logic that relies on the states of both providers in combination. 

A third challenge for me was indeed to realize that the questions were not structured in the same way as the topics. First, I somehow had assumed that the pattern would repeat and given that there are several questions for at least some topics, I thought that these would be provided as a list by the API. Only after failing to read in the API response body several times, I realized that there was always only one question and therewith not a list, but an individual object provided by the API for a question. 


*3 key learning moments from working on the project*
A key learning moment was when I realized how helpful it can be to draw down dependencies and structured. I realized this when I was struggling to understand the relationship between topics, questions and answer options. It took me some time to properly understand that though there were several questions for one topic, the logic in which they are used is different compared to the topics and options. Sketching down the structure really seemed to be a meaningful way of identifying repetitive patterns and for deciding what kind of elements could be reused. 

A second key learning during the project for me was when I tried passing the GoRouter object as a router config to the app. Since I had used the wrong version of the go_router package first, the type could either not be converted or was just not accepted (I do not remember 100% anymore). But that made me realize that I should really pay close attention to the dependencies and the versions that I use when working on my project. 

A third key learning was that it can be helpful to use the developer options in my browser. I struggled for a really long time with mocking the SharedRefs object. After getting a hint from a classmate that I need to put "flutter." in front of the key and that the rest is stringified, I knew that I had to rethink how to mock my object, but only by exploring the shared object in the developer tools in my browser, I finally realized how to write the mock. 

*list of dependencies (dan dev dependencies) and their versions*


#SET THE NAME in pubspec.yaml as
name: flutter_application_1

dependencies:
  flutter:
    sdk: flutter
  riverpod: ^2.4.0
  flutter_riverpod: ^2.5.1
  http: ^1.2.1 
  provider: ^6.1.2
  go_router: ^10.1.2
  shared_preferences: ^2.2.1
  convert: ^3.1.1
  flutter_lints: ^3.0.2
  test: any
  cupertino_icons: ^1.0.6

dev_dependencies:
  flutter_test:
    sdk: flutter
  nock: ^1.2.3
  flutter_lints: ^3.0.0

# and if necessary

environment:
  sdk: '^3.4.0'
