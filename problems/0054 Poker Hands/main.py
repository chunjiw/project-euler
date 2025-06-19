    # 0 High Card: Highest value card.
    # 1 One Pair: Two cards of the same value.
    # 2 Two Pairs: Two different pairs.
    # 3 Three of a Kind: Three cards of the same value.
    # 4 Straight: All cards are consecutive values.
    # 5 Flush: All cards of the same suit.
    # 6 Full House: Three of a kind and a pair.
    # 7 Four of a Kind: Four cards of the same value.
    # 8 Straight Flush: All cards are consecutive values of same suit.
    #   Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.


from collections import Counter


valuemap = {'T':10, 'J':11, 'Q':12, 'K':13, 'A':14}

def value(card):
    if card.isnumeric():
        return int(card)
    return valuemap[card]
    
def rank(values, suites):
    # values = [card[0] for card in cards]
    # suites = [card[1] for card in cards]
    flush = False
    if all(s == suites[0] for s in suites):
        flush = True
    freq = Counter(values)
    rep = list(freq.values())
    rep.sort()
    values.sort(reverse=True, key=lambda x:x*(20**(freq[x]-1)))
    if rep[-1] == 4:
        return 8
    if rep == [1,1,3]:
        return 3
    if rep == [2,3]:
        return 6
    if rep == [1,2,2]:
        return 2
    if rep[-1] == 2:
        return 1
    if [v - values[-1] for v in values[:-1]] == [4,3,2,1]:
        return 8 if flush else 4
    return 5 if flush else 0


count = 0
with open("poker.txt", "r") as poker:
    for line in poker:
        values = [value(card[0]) for card in line.split()]
        suites = [card[1] for card in line.split()]
        values1 = values[:5]
        values2 = values[5:]
        suites1 = suites[:5]
        suites2 = suites[5:]
        if rank(values1, suites1) > rank(values2, suites2):
            count += 1
        elif rank(values1, suites1) == rank(values2, suites2):
            count += int(values1 > values2)

print(count)

        
