Game.dialogue =
  detective:
    initial:
      [
        {speaking:"Detective", text: "Man what a mess"}
        {speaking:"Detective", text: "3 people, 3 stories" }
        {speaking:"Detective", text: "Each of them brings up" }
        {speaking:"Detective", text: "inconsistencies with another." }
        {speaking:"Detective", text: "Maybe your story will clear up the confusion." }
        {speaking:"Detective", text: "(or at least clear up some the inconsistencies between the other stories)" }
        {speaking:"Detective", text: "But before we begin," }
        {speaking:"Detective", text: "I would like to ask you a question:" }
        {speaking:"Detective", text: "How do you feel?" }
      ]
    sad:
      [
        {speaking:"Detective", text: "Sad?" }
        {speaking:"Detective", text: "Why do you feel that way?" }
        {speaking:"You", text: "... *sigh*" }
        {speaking:"Detective", text: "All right then." }
        {speaking:"Detective", text: "Let's start at the beginning." }
        {speaking:"Detective", text: "You mentioned to the police that you left your home shortly before the incident to go for a walk?" }
        {speaking:"Detective", text: "Is that correct?" }
        {speaking:"Detective", text: "Walk me through what happened from there. " }
      ]
    angry:
      [
        {speaking:"Detective", text: "Angry?" }
        {speaking:"Detective", text: "Why do you feel that way?" }
        {speaking:"You", text: "..." }
        {speaking:"Detective", text: "All right then." }
        {speaking:"Detective", text: "Let's start at the beginning." }
        {speaking:"Detective", text: "You mentioned to the police that you left your home shortly before the incident to go for a walk?" }
        {speaking:"Detective", text: "Is that correct?" }
        {speaking:"Detective", text: "Walk me through what happened from there. " }
      ]
    happy:
      [
        {speaking:"Detective", text: "Relieved?" }
        {speaking:"Detective", text: "Why do you feel that way?" }
        {speaking:"You",       text: "Well this isn't exactly how I thought my day would go," }
        {speaking:"You",       text: "but I feel so...good about how things turned out." }
        {speaking:"Detective", text: "All right then." }
        {speaking:"Detective", text: "Let's start at the beginning." }
        {speaking:"Detective", text: "You mentioned to the police that you left your home shortly before the incident to go for a walk?" }
        {speaking:"Detective", text: "Is that correct?" }
        {speaking:"Detective", text: "Walk me through what happened from there." }
      ]

    final1:
      [
        {speaking:"Detective", text: "final dialogue 1 line 1" }
        {speaking:"Detective", text: "final dialogue 1 line 2" }
      ]
    final2:
      [
        {speaking:"Detective", text: "final dialogue 2 line 1" }
        {speaking:"Detective", text: "final dialogue 2 line 2" }
      ]

  showdown:
    ending1:
      [
        {speaking:"", text: "ending 1 line 1" }
        {speaking:"", text: "ending 1 line 2" }
        {speaking:"", text: "ending 1 line 3" }
      ]
    ending2:
      [
        {speaking:'', text: "ending 2 line 1"}
        {speaking:'', text: "ending 2 line 2"}
        {speaking:'', text: "ending 2 line 3"}
      ]

  hobo:
    happy:
      [
        {speaking:'hobo', text: "hobo relieved"}
        {speaking:'hobo', text: "second line"}
      ]
    angry:
      [
        {speaking:'hobo', text: "hobo angry"}
        {speaking:'hobo', text: "second line"}
      ]
    sad:
      [
        {speaking:'hobo', text: "hobo sad"}
        {speaking:'hobo', text: "second line"}
      ]

  victim:
    happy:
      [
        {speaking:'victim', text: "victim relieved"}
        {speaking:'victim', text: "second line"}
      ]
    angry:
      [
        {speaking:'victim', text: "victim angry"}
        {speaking:'victim', text: "second line"}
      ]
    sad:
      [
        {speaking:'victim', text: "victim sad"}
        {speaking:'victim', text: "second line"}
      ]

  bystander:
    happy:
      [
        {speaking:'bystander', text: "bystander relieved"}
        {speaking:'bystander', text: "second line"}
      ]
    angry:
      [
        {speaking:'bystander', text: "bystander angry"}
        {speaking:'bystander', text: "second line"}
      ]
    sad:
      [
        {speaking:'bystander', text: "bystander sad"}
        {speaking:'bystander', text: "second line"}
      ]

Game.answers =
  mood:
    question:
      "I feel ..."
    answers:
      [
        {value:"happy", displayText:"... relieved."}
        {value:"sad", displayText:"... sad."}
        {value:"angry", displayText:"... angry!"}
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
