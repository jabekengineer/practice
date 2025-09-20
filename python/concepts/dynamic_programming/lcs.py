def subproblem_in_words():
    """define an identical problem over a subset of the inputs"""
    return "L[i,j] is the length of the LCS ending at xi and yj"

def recurrence():
    return "1 + L[i-1, j-1] if xi == yj else max(L[i-1,j], L[i,j-i])"

def lcs(x: str, y: str):
    """Find the length of the longest common subsequence between two strings."""
    # Initialize DP table with an extra row and column for base cases
    L = [[0 for _ in range(len(y) + 1)] for _ in range(len(x) + 1)]
    for i in range(1, len(x) + 1):
        for j in range(1, len(y) + 1):
            if x[i - 1] == y[j - 1]:
                L[i][j] = 1 + L[i - 1][j - 1]
            else:
                L[i][j] = max(L[i][j - 1], L[i - 1][j])
    
    # The LCS length is in the bottom-right cell of the table
    return L[len(x)][len(y)]

def main():
    import argparse
    parser = argparse.ArgumentParser(description="Find longest common subsequence between two strings")
    parser.add_argument("-str1", required=True, type=str)
    parser.add_argument("-str2", required=True, type=str)
    args = parser.parse_args()
    print(f"lcs of str1: '{args.str1}', str2: '{args.str2} is '{lcs(x=args.str1, y=args.str2)}'")

if __name__=="__main__":
    main()