
def fibonacci(n: int) -> int:
    # Handle base cases directly to avoid list operations for small inputs
    if n == 0:
        return 0
    if n == 1:
        return 1

    # For larger values, use dynamic programming with fixed-size array
    # Only keep the last two values instead of the entire sequence
    prev, curr = 0, 1

    for _ in range(2, n+1):
        # Calculate next value and update sliding window
        prev, curr = curr, prev + curr

    return curr

def main():
    import argparse
    parser = argparse.ArgumentParser(description="Calculate nth fibonacci number")
    parser.add_argument('-n', type=int, help='Position in fibonacci sequence')
    args = parser.parse_args()
    print(f"fibonacci({args.n}) = {fibonacci(args.n)}")

if __name__ == "__main__":
    main()