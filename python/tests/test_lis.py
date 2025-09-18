from concepts.dynamic_programming.lis import lis

def test_lis():
    sequence = [5, 7, 4, -3, 9, 1, 10, 4, 5, 8, 9]
    assert lis(sequence) == 6

def test_runtime():
    from tests.runtimer import benchmark
    EXP_RUNTIME="O(n^2)"

    def lis_input_gen(len: int) -> list[int]:
        from random import randint
        # Limit the range to avoid extremely large numbers
        # More consistent input data helps with measuring complexity
        return [randint(-10000, 10000) for _ in range(len)]

    # Use smaller input sizes for quadratic algorithm to avoid long test times
    # But keep the ratio between successive inputs constant for better measurement
    actual_complexity = benchmark(algorithm=lis,
                                 input_gen=lis_input_gen,
                                 inputs=[100, 150, 200, 250, 300, 350, 400, 450, 500],
                                 expected_complexity=EXP_RUNTIME)
    assert actual_complexity == EXP_RUNTIME


def main():
    test_lis()
    test_runtime()

if __name__ == "__main__":
    main()