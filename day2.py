translate = {
    "A": "ROCK",
    "B": "PAPER",
    "C": "SCISSORS",
    "X": "LOSE",
    "Y": "DRAW",
    "Z": "WIN",
}

bonus = {
    "ROCK": 1,
    "PAPER": 2,
    "SCISSORS": 3,
}


def points_won(enemy, mine):
    en = translate[enemy]
    my = ""

    outcome = translate[mine]

    score = 0

    if outcome == "DRAW":
        score += 3
        my = en
    elif outcome == "WIN":
        score += 6
        if en == "SCISSORS":
            my = "ROCK"
        elif en == "PAPER":
            my = "SCISSORS"
        elif en == "ROCK":
            my = "PAPER"
        else:
            raise ValueError()
    elif outcome == "LOSE":
        score += 0
        if en == "PAPER":
            my = "ROCK"
        elif en == "ROCK":
            my = "SCISSORS"
        elif en == "SCISSORS":
            my = "PAPER"
        else:
            raise ValueError()

    # ADiciona o bonus da minha jogada
    score += bonus[my]

    return score


with open("day2.txt", "r") as f:
    data = f.read().splitlines()

score = 0

for play in data:
    en = play.split(" ")[0]
    my = play.split(" ")[1]

    score += points_won(en, my)

print(score)
