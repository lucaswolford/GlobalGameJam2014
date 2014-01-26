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
        {speaking:'Gretchen', text: "Do you have any spare change, mista?"}
        {speaking:'You', text: "I wish I could help."}
      ]
    angry:
      [
        {speaking:'Gretchen', text: "OY! Can you help a poor woman out?"}
        {speaking:'You', text: "I'm sorry I can't help you."}
      ]
    sad:
      [
        {speaking:'Gretchen', text: "Can you...help me, mista?"}
        {speaking:'You', text: "Back off! I don't have any money."}
      ]

  victim:
    happy:
      [
        {speaking:'Vicky', text: "I'm a a little lost, would you mind giving me directions to Envy Labs?"}
        {speaking:'You', text: "It's just up the street."}
        {speaking:'Vicky', text: "Oh thank you! I would have never found it."}
      ]
    angry:
      [
        {speaking:'Vicky', text: "Ugh, can you help me find my way out of here?"}
        {speaking:'You', text: "Yeah, you look lost. Good luck with that"}
        {speaking:'Vicky', text: "Jerk."}
      ]
    sad:
      [
        {speaking:'Vicky', text: "I don't know where I am...can you...help me?"}
        {speaking:'You', text: "Uhhh...no, I'm sorry I can't help you."}
        {speaking:'Vicky', text: "Ugh, I'm never going to find Envy Labs."}
      ]

  bystander:
    happy:
      [
        {speaking:'Drake', text: "Hey man, how are you doing?"}
      ]
    angry:
      [
        {speaking:'Drake', text: "What're you doing?"}
      ]
    sad:
      [
        {speaking:'Drake', text: "Hey man, what's wrong?"}
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
