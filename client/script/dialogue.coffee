Game.dialogue =
  detective:
    initial:
      [
        "Wow! Much dialogue. Such text."
        "init dialogue line 2"
      ]
    final1:
      [
        "final dialogue 1 line 1"
        "final dialogue 1 line 2"
      ]
    final2:
      [
        "final dialogue 2 line 1"
        "final dialogue 2 line 2"
      ]

  showdown:
    ending1:
      [
        "ending 1 line 1"
        "ending 1 line 2"
        "ending 1 line 3"
      ]
    ending2:
      [
        "ending 2 line 1"
        "ending 2 line 2"
        "ending 2 line 3"
      ]

  hobo:
    happy:
      [
        "hobo relieved"
        "second line"
      ]
    angry:
      [
        "hobo angry"
        "second line"
      ]
    sad:
      [
        "hobo sad"
        "second line"
      ]

  victim:
    happy:
      [
        "victim relieved"
        "second line"
      ]
    angry:
      [
        "victim angry"
        "second line"
      ]
    sad:
      [
        "victim sad"
        "second line"
      ]

  bystander:
    happy:
      [
        "bystander relieved"
        "second line"
      ]
    angry:
      [
        "bystander angry"
        "second line"
      ]
    sad:
      [
        "bystander sad"
        "second line"
      ]

Game.answers =
  mood:
    question:
      "How were you feeling?"
    answers:
      [
        {value:"happy", displayText:"I feel happy!"}
        {value:"sad", displayText:"I feel sad!"}
        {value:"angry", displayText:"I feel angry!"}
      ]

  action:
    question:
      "What do you do?"
    answers:
      [
        {value:"stab", displayText:"stab a bitch"}
        {value:"giveCash", displayText:"give $$$"}
        {value:"reason", displayText:"can't we all just get along?"}
      ]
