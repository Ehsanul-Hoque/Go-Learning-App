class SampleData {
  // static String avatar =
  //     "https://preview.redd.it/gwqupsh46yn51.png?width=301&format=png&auto=webp&s=60efa3b8c4375c7589c929945a840c60c713c949";

  static List<Map<String, Object>> quizzes = <Map<String, Object>>[
    <String, Object>{
      "id": "1",
      "title": "Quiz 1",
      "time_millis": 20 * 1000,
      "min_percent": 80,
      "positive_mark": 1,
      "negative_mark": 0.25,
      "locked": false,
    },
    <String, Object>{
      "id": "2",
      "title": "Quiz 2",
      "time_millis": 15 * 60 * 1000,
      "min_percent": 80,
      "positive_mark": 1,
      "negative_mark": 0.25,
      "locked": true,
    },
  ];

  static List<Map<String, Object>> questions = <Map<String, Object>>[
    <String, Object>{
      "question": "What is (H<sub>2</sub>O)<sup>3</sup>?",
      "options": <String>[
        "Water",
        "Ice",
        "Nothing",
      ],
      "correct_index": 1,
    },
    <String, Object>{
      "question": "Who are you?",
      "options": <String>[
        "Amoeba",
        "Human",
        "Fish",
        "Chicken",
      ],
      "correct_index": 1,
    },
    <String, Object>{
      "question": "Where are you from?",
      "options": <String>[
        "Earth",
        "Mars",
        "Jupiter",
      ],
      "correct_index": 0,
    },
    <String, Object>{
      "question": "What is the latest version of iPhone?",
      "options": <String>[
        "10",
        "11",
        "12",
        "13",
        "14",
      ],
      "correct_index": 4,
    },
  ];
}
