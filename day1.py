with open("day1.txt", "r") as f:
    data = f.read().splitlines()

elves = {}

num = 0
curr = 0
for c in data:
    if c == "":
        elves[num] = curr
        curr = 0
        num += 1
        continue
    else:
        curr += int(c)

vals = elves.values()
vals = sorted(vals, reverse=True)
print(sum(vals[:3]))
