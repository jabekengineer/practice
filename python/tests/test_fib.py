from concepts.dynamic_programming.fibonacci import fibonacci

def test_fibonacci():
    fib_sequence = [0, 1, 1, 2, 3, 5, 8, 13, 21, \
                    34, 55, 89, 144, 233, 377, 610, \
                        987, 1597, 2584, 4181]
    for n, fibn in enumerate(fib_sequence):
        assert fibonacci(n) == fibn

def test_runtime():
    from tests.runtimer import benchmark
    EXP_RUNTIME="O(n)"

    def fib_input_gen(n):
        return n

    # Use a wider range of inputs with more consistent steps
    # This helps in getting more consistent time measurements
    actual_complexity = benchmark(algorithm=fibonacci,
                                  input_gen=fib_input_gen,
                                  inputs=[10000, 20000, 30000, 40000, 50000, 60000, 70000, 80000, 90000],
                                  expected_complexity=EXP_RUNTIME)
    assert actual_complexity == EXP_RUNTIME

if __name__=="__main__":
    test_fibonacci()
    test_runtime()