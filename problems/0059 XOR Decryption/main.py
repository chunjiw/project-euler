with open("0059_cipher.txt", 'r') as cipher:
    content = cipher.read()
    arr = [int(num) for num in content.split(',')]

cnt = 0
for i in range(26**3):
    baseline = ord('a')
    ii = i
    key = []
    for _ in range(3):
        key.append(ii % 26 + baseline)
        ii //= 26
    dec = [arr[k]^key[k%3] for k in range(len(arr))]

    # rule out control characters
    if not all(0x20 <= char < 0x7F for char in dec):
        continue

    # has to have word " the "
    for j in range(len(arr) - 4):
        abc = ''.join(chr(dec[j+k]) for k in range(5)).lower()
        if abc == " the ":
            print(cnt, key, ''.join(chr(asc) for asc in dec))
            print(sum(dec))
            cnt += 1
            break

print(cnt)