
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
    # base case
    if len(input) == 1:
        return 1

    solutions: dict[int, list[list[int]]] = {}
    solutions[0] = [[input.pop(0)]]
    lis_length: list[int] = [1]
    # map ending index to list of valid solutions
    for idx, ending_character in enumerate(input):
        for solution in solutions[idx]:
            solutions[idx+1] = []  # initialize next solution list
            if ending_character > solution[-1]:
                # if ending character increases length of solution increasing sequence, add it to ending_character_idx solutionlist
                new_is: list[int] = solution
                new_is.append(ending_character)
                solutions[idx+1].append(new_is)
                lis_length.append(len(new_is))
            else:
                solutions[idx+1].append([ending_character])
                lis_length.append(1)
    return lis_length[-1]

def main():
    print("lis")
    return True

if __name__ == "__main__":
    main()