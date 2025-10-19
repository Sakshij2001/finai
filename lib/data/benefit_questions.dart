const String benefitQuestionsJson = '''
{
  "questions": [
    {
      "id": 1,
      "section": "Lifestyle Behavior",
      "question": "Do you smoke?",
      "type": "yes_no",
      "next_question": {
        "yes": 2,
        "no": 3
      }
    },
    {
      "id": 2,
      "section": "Lifestyle Behavior",
      "question": "How often do you smoke?",
      "type": "dropdown",
      "options": ["Daily", "Occasionally", "Trying to quit"],
      "next_question": {
        "default": 3
      }
    },
    {
      "id": 3,
      "section": "Lifestyle Behavior",
      "question": "Do you drink alcohol?",
      "type": "yes_no",
      "next_question": {
        "yes": 4,
        "no": 5
      }
    },
    {
      "id": 4,
      "section": "Lifestyle Behavior",
      "question": "How often do you drink alcohol?",
      "type": "dropdown",
      "options": ["Weekly", "Occasionally", "Rarely"],
      "next_question": {
        "default": 5
      }
    },
    {
      "id": 5,
      "section": "Health Condition",
      "question": "Do you have any pre-existing health conditions?",
      "type": "yes_no",
      "next_question": {
        "yes": 6,
        "no": 7
      }
    },
    {
      "id": 6,
      "section": "Health Condition",
      "question": "Please select your health condition type:",
      "type": "dropdown",
      "options": ["Diabetes", "Hypertension", "Heart Disease", "Asthma", "Other"],
      "next_question": {
        "default": 7
      }
    },
    {
      "id": 7,
      "section": "Work Type",
      "question": "Which best describes your daily work activity?",
      "type": "dropdown",
      "options": [
        "Mostly Sitting (Office Job)",
        "Standing/Walking Frequently",
        "Physically Active (Field/Labor Work)",
        "Combination of Both"
      ],
      "next_question": {
        "default": 8
      }
    },
    {
      "id": 8,
      "section": "Exercise",
      "question": "Do you engage in regular physical exercise (at least 3 times a week)?",
      "type": "yes_no",
      "next_question": {
        "yes": 9,
        "no": 10
      }
    },
    {
      "id": 9,
      "section": "Exercise",
      "question": "Would you like health coverage that rewards your fitness habits?",
      "type": "yes_no",
      "next_question": {
        "default": 11
      }
    },
    {
      "id": 10,
      "section": "Exercise",
      "question": "Would you like to include wellness or gym membership benefits?",
      "type": "yes_no",
      "next_question": {
        "default": 11
      }
    },
    {
      "id": 11,
      "section": "Family Benefit",
      "question": "Would you like to include your family members under the same benefit plan?",
      "type": "yes_no",
      "next_question": {
        "yes": 12,
        "no": 14
      }
    },
    {
      "id": 12,
      "section": "Family Benefit",
      "question": "Who would you like to include?",
      "type": "dropdown",
      "options": ["Spouse", "Children", "Parents", "All Family Members"],
      "next_question": {
        "default": 14
      }
    },
    {
      "id": 14,
      "section": "Accident Protection",
      "question": "Would you like to include accidental coverage in your benefit plan?",
      "type": "yes_no",
      "next_question": {
        "default": 15
      }
    },
    {
      "id": 15,
      "section": "Budget & Coverage",
      "question": "What is your preferred monthly budget range for the benefit plan?",
      "type": "dropdown",
      "options": ["Below \$50", "\$50 - \$100", "\$100 - \$200", "Above \$200"],
      "next_question": {
        "default": 16
      }
    },
    {
      "id": 16,
      "section": "Risk Tolerance",
      "question": "How comfortable are you with taking financial risks for higher coverage or returns?",
      "type": "dropdown",
      "options": [
        "Low (Prefer Stable Coverage)",
        "Medium (Balanced Coverage & Returns)",
        "High (Aggressive Growth & Benefits)"
      ],
      "next_question": {
        "default": 17
      }
    },
    {
      "id": 17,
      "section": "Hobbies",
      "question": "Do you participate in any high-risk hobbies or sports (e.g., skydiving, racing, trekking)?",
      "type": "yes_no",
      "next_question": {
        "yes": 18,
        "no": 19
      }
    },
    {
      "id": 18,
      "section": "Hobbies",
      "question": "Please select your activity type:",
      "type": "dropdown",
      "options": ["Racing", "Skydiving", "Mountain Climbing", "Scuba Diving", "Other"],
      "next_question": {
        "default": 19
      }
    },
    {
      "id": 19,
      "section": "Completion",
      "question": "Would you like to view your personalized benefit plan now?",
      "type": "yes_no",
      "next_question": {
        "yes": "show_recommendation",
        "no": "end"
      }
    }
  ]
}
''';
