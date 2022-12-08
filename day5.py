stacks = [
    ["N", "D", "M", "Q", "B", "P", "Z"],
    [
        "C",
        "L",
        "Z",
        "Q",
        "M",
        "D",
        "H",
        "V",
    ],
    [
        "Q",
        "H",
        "R",
        "D",
        "V",
        "F",
        "Z",
        "G",
    ],
    [
        "H",
        "G",
        "D",
        "F",
        "N",
    ],
    [
        "N",
        "F",
        "Q",
    ],
    [
        "D",
        "Q",
        "V",
        "Z",
        "F",
        "B",
        "T",
    ],
    [
        "Q",
        "M",
        "T",
        "Z",
        "D",
        "V",
        "S",
        "H",
    ],
    [
        "M",
        "G",
        "F",
        "P",
        "N",
        "Q",
    ],
    [
        "B",
        "W",
        "R",
        "M",
    ],
]

with open("day-5-moves.txt", "r") as f:
    data = f.read().splitlines()

moves = []

for m in data:
    mv = m.split(" ")[1]
    fr = m.split(" ")[3]
    to = m.split(" ")[5]
    moves.append((int(mv), int(fr), int(to)))

for move in moves:
    # qts vezes
    times = move[0]
    fr = move[1] - 1
    to = move[2] - 1

    moving = stacks[fr][-times:]
    stacks[fr] = stacks[fr][:-times]

    stacks[to].extend(moving)

    # for i in range(times):
    #     moving = stacks[fr - 1].pop()
    #     stacks[to - 1].append(moving)

print(stacks)

letters = ""
for s in stacks:
    letters += s[-1]

print(letters)
