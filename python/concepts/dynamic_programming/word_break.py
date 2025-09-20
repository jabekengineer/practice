from nltk.corpus import words as nltk_words

DICT = {w.lower() for w in nltk_words.words()}

def word_break(s: str) -> tuple[bool, str]:
    s_orig = s
    s_low = s.lower()
    n = len(s_low)
    # include the 0 base case
    dp = [False] * (n + 1)   # dp[i] => first i chars can be segmented
    prev = [-1] * (n + 1)    # prev[i] => split point j that proves dp[i]
    dp[0] = True

    for i in range(1, n + 1):
        # try all last-cut positions j
        for j in range(0, i):
            if dp[j] and (s_low[j:i] in DICT):
                dp[i] = True
                prev[i] = j
                break

    if not dp[n]:
        return (False, "")

    # Reconstruct using original casing
    out = []
    i = n
    while i > 0:
        j = prev[i]
        out.append(s_orig[j:i])
        i = j
    out.reverse()
    return (True, " ".join(out))


def main():
    import argparse
    parser = argparse.ArgumentParser(description="Attempt to split input string into real words")
    parser.add_argument("-s", type=str, required=True)
    args = parser.parse_args()
    print(f"word_break: {word_break(args.s)}")

if __name__=="__main__":
    main()