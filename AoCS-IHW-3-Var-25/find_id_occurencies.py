texts = ["Normal test: ", "Long test: ", "Enormous test: "]
inputs = ["test_input\\input.txt", "test_input\\long_input.txt", "test_input\\enormous_input.txt"]
outputs = ["test_output\\output.txt", "test_output\\long_output.txt", "test_output\\enormous_output.txt"]

for i in range(3):
    print(texts[i], end="")
    with open(inputs[i], "r", encoding="utf-8") as f:
        contents = f.read()
        n = 0
        l = 0
        for char in contents:
            if char.isdigit() or char.islower() or char.isupper():
                l += 1
            else:
                l = 0
                n += 1
        if l > 0:
            n += 1
        print(n)