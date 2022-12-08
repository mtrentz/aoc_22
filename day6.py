with open("day6.txt", "r") as f:
    data = f.read().splitlines()[0]


def all_unique(list):
    seen = set()
    return not any(i in seen or seen.add(i) for i in list)


buffer = []

for index, val in enumerate(data):
    # Check if all equal
    if len(buffer) == 14 and all_unique(buffer):
        print(f"index: {index}, val: {val}, buffer: {buffer}")
        break

    # Add to buffer
    buffer.append(val)

    # Pop first if len > 14
    if len(buffer) > 14:
        buffer.pop(0)
