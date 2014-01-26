Game.dialogue =
  detective:
    initial:
      [
        {speaking:"Detective", text: "Man what a mess"}
        {speaking:"Detective", text: "Three people, and three different stories" }
        {speaking:"Detective", text: "Each of them brings up inconsistencies with another." }
        {speaking:"Detective", text: "Maybe your story will clear up the confusion." }
        {speaking:"Detective", text: "But before we begin, I would like to ask you a question:" }
        {speaking:"Detective", text: "How do you feel?" }
      ]
    sad:
      [
        {speaking:"Detective", text: "Sad? Why do you feel that way?" }
        {speaking:"You", text: "... *sigh*" }
        {speaking:"Detective", text: "All right then. Let's start at the beginning." }
        {speaking:"Detective", text: "You mentioned to the police that you left your home shortly before the incident to go for a walk?" }
        {speaking:"Detective", text: "Is that correct? Walk me through what happened from there. " }
      ]
    angry:
      [
        {speaking:"Detective", text: "Angry? Why do you feel that way?" }
        {speaking:"You", text: "..." }
        {speaking:"Detective", text: "All right then. Let's start at the beginning." }
        {speaking:"Detective", text: "You mentioned to the police that you left your home shortly before the incident to go for a walk?" }
        {speaking:"Detective", text: "Is that correct? Walk me through what happened from there. " }
      ]
    happy:
      [
        {speaking:"Detective", text: "Relieved? Why do you feel that way?" }
        {speaking:"You",       text: "Well this isn't exactly how I thought my day would go," }
        {speaking:"You",       text: "but I feel so...good about how things turned out." }
        {speaking:"Detective", text: "All right then. Let's start at the beginning." }
        {speaking:"Detective", text: "You mentioned to the police that you left your home shortly before the incident to go for a walk?" }
        {speaking:"Detective", text: "Is that correct? Walk me through what happened from there. " }
      ]

    sadStab:
      [
        {speaking:"Detective", text: "sadStab" }
      ]
    sadBribe:
      [
        {speaking:"Detective", text: "sadBribe" }
      ]
    sadReason:
      [
        {speaking:"Detective", text: "sadReason" }
      ]
    sadWalk:
      [
        {speaking:"Detective", text: "sadWalk" }
      ]
    happyStab:
      [
        {speaking:"Detective", text: "happyStab" }
      ]
    happyBribe:
      [
        {speaking:"Detective", text: "happyBribe" }
      ]
    happyReason:
      [
        {speaking:"Detective", text: "happyReason" }
      ]
    happyWalk:
      [
        {speaking:"Detective", text: "happyWalk" }
      ]
    angryStab:
      [
        {speaking:"Detective", text: "angryStab" }
      ]
    angryBribe:
      [
        {speaking:"Detective", text: "angryBribe" }
      ]
    angryReason:
      [
        {speaking:"Detective", text: "angryReason" }
      ]
    angryWalk:
      [
        {speaking:"Detective", text: "angryWalk" }
      ]

  showdown:
    ending:
      [
        {speaking:"You", text: "I was about to finish my walk and go back inside when"}
        {speaking:"You", text: "I heard a scream coming from the alley."}
        {speaking:"You", text: "I ran through the alley as fast as I could to find the source of the scream."}
        {speaking:"You", text: "As I rounded the corner I saw two girls arguing and fighting with each other."}
        {speaking:"You", text: "I couldn't tell what it was about exactly,"}
        {speaking:"You", text: "but I remember hearing a few words like 'purse' and 'money.'"}
        {speaking:"Detective", text: "I see. So what did you do about it?"}
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
        {value:"sad",   displayText:"... sad."}
        {value:"angry", displayText:"... angry!"}
      ]

  action:
    question:
      "I ..."
    answers:
      [
        {value:"reason", displayText:"tried to reason with them"}
        {value:"walk",   displayText:"walked away"}
        #{value:"stab",   displayText:"stabbed the bitch"}
        #{value:"bribe",  displayText:"give them $$$"}
      ]
