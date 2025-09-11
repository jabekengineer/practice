
def fibonacci(n: int) -> int:
    fib_nums: list[int] = []
    # F[0] = 0 base case
    fib_nums.append(0)

    # F[1] = 1 base case
    fib_nums.append(1)
    
    for i in range(2,n+1):
        fib_nums.append(
            fib_nums[i-1] + \
            fib_nums[i-2]
        )
    
    return fib_nums[n]

def main():
    import argparse
    parser = argparse.ArgumentParser(description="Calculate nth fibonacci number")
    parser.add_argument('n', type=int, help='Position in fibonacci sequence')
    args = parser.parse_args()
    print(f"fibonacci({args.n}) = {fibonacci(args.n)}")

if __name__ == "__main__":
    main()    