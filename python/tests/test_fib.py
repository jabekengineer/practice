from concepts.dynamic_programming.fibonacci import fibonacci

def test_fibonacci():
    fib_sequence = [0, 1, 1, 2, 3, 5, 8, 13, 21, \
                    34, 55, 89, 144, 233, 377, 610, \
                        987, 1597, 2584, 4181]
    for n, fibn in enumerate(fib_sequence):
        assert fibonacci(n) == fibn    

def test_runtime():
    from runtimer import benchmark
    EXP_RUNTIME="O(n)"
    
    def fib_input_gen(n):
        return n
    actual_complexity = benchmark(algorithm=fibonacci,
                                  input_gen=fib_input_gen,
                                  inputs=list(range(int(1e3), int(1e4), int(1e3))), 
                                  expected_complexity=EXP_RUNTIME)
    assert actual_complexity == EXP_RUNTIME
    
if __name__=="__main__":
    test_fibonacci()
    test_runtime()