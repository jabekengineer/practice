import timeit
from typing import Callable
import gc

def benchmark(algorithm: Callable, input_gen: Callable, inputs: list[int], expected_complexity: str) -> str:
    times = []
    gc.disable()
    for input in inputs:
        AVE_FACTOR = 10
        duration_ms = (timeit.timeit(lambda: algorithm(input_gen(input)), number=AVE_FACTOR) / AVE_FACTOR) * 1000
        times.append(duration_ms)
    gc.enable()

    violations = 0
    
    for i in range(1, len(inputs)):
        time_ratio = times[i] / times[i-1]
        size_ratio = inputs[i] / inputs[i-1]
        
        if expected_complexity == "O(n)":
            expected_ratio = size_ratio
            tolerance = 0.2
            
            if abs(time_ratio - expected_ratio) > expected_ratio * tolerance:
                violations += 1
    violation_rate = violations / (len(inputs) - 1)
    
    if violation_rate < 0.2:
        print(f"✅ {algorithm.__name__} is within 20% of {expected_complexity}")
        return expected_complexity
    else:
        print(f"❌ {algorithm.__name__} had ({violations}/{len(inputs)-1} violations)")
        return "complexity wrong"
    
