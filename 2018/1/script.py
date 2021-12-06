with open("./input.txt") as fp:
    entries = []
    results = []
    for line in fp:
        entries.append(line)

    found = False
    index = 0
    while found == False:
        entry = entries[index]
        value = int(entry[1:])
        cnt = results[-1] if len(results) > 0 else 0
        if entry[:1] == "+":
            cnt += value
        else:
            cnt -= value
        if cnt in results:
            print(cnt)
            found = True
        else:
            results.append(cnt)
            index += 1
            if index == len(entries):
                index = 0
