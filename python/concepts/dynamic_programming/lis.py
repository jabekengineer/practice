
def subproblem_description():
     return "L[i] = length of the longest increasing subsequence of a1, a2, ..., ai which includes ai."

def recurrence_description():
    """
    [ai;a;L]
    | a0 | a1 | a2 | a3 | a4 | a5 | a6 | a7 | a8 | a9 | a10 | - ai
    |:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:----|
    |5   | 7  | 4  | -3 | 9  | 1  | 10 | 4  | 5  | 8  | 9   |  - A
    | 1  | 2  | 2  | 2  | 3  | 3  | 4  | 4  | 4  | *5*| 6   |  - L that doesn't include ai a10 makes [-3, 1, 4, 5, (8)] solution pull ahead of [5,7,9,10]
    | 1  | 2  | 1  | 1  | 3  | 2  | 4  | 3  | 4  | 5  | 6   |  - L that includes ai [-3, 1, 4, 5, 8, 9]
    """
    # current solution is LIS with minimum ending character
    # maintain all solutions for every possible ending character
    # look for the maximum LIS length among all valid predecessors
    # invalidate predecessors that end at ax > ai
    return "L[i] = 1 + max(L[x] | x < i, ax < ai)"

def lis(input: list[int]) -> int:
    if not input:
        return 0

    # Create a copy to prevent modifying the input list
    arr = input.copy()
    n = len(arr)

    # Initialize LIS values for all indexes
    dp = [1] * n

    # Compute optimized LIS values bottom-up
    for i in range(1, n):
        for j in range(0, i):
            if arr[i] > arr[j] and dp[i] < dp[j] + 1:
                dp[i] = dp[j] + 1

    # Return maximum value in dp array
    return max(dp)

def main():
    import argparse
    parser = argparse.ArgumentParser(description="Find length of longest increasing subsequence")
    parser.add_argument('-s', '--sequence', nargs='+', required=True,
                        help=('Sequence to analyze. Provide either space-separated integers, e.g. `-s 5 7 4 -3 9`'))
    args = parser.parse_args()

    # Normalize the provided tokens into a list of integers.
    def _parse_sequence(tokens):
        # tokens is a list (nargs='+') - join into a single string so we can accept commas or brackets
        if isinstance(tokens, str):
            s = tokens
        else:
            s = " ".join(tokens)
        s = s.strip()
        parts = [p for p in s.split() if p]
        try:
            return [int(p) for p in parts]
        except ValueError:
            parser.error('sequence must contain integers only')

    sequence = _parse_sequence(args.sequence)
    print(f"lis({sequence}) = {lis(sequence)}")

if __name__ == "__main__":
    main()