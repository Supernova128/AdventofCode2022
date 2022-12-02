with open("input", "rt") as f:
    data = f.readlines()
    calories = []
    calorie = 0
    for line in data:
        if line in ['\n', '\r\n']:
            calories.append(calorie)
            calorie = 0
        else:
            calorie += int(line)
    print(max(calories))

with open("input", "rt") as f:
    data = f.readlines()
    calories = []
    calorie = 0
    for line in data:
        if line in ['\n', '\r\n']:
            calories.append(calorie)
            calorie = 0
        else:
            calorie += int(line)
    calories.sort()
    print(sum(calories[-3:]))
