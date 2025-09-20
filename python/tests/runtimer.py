import timeit
from typing import Callable, Union
import gc
import math

def benchmark(algorithm: Callable, input_gen: Callable, inputs: Union[list[int], list[tuple[int, int]]], expected_complexity: str) -> str:
    times = []
    gc.disable()
    for input in inputs:
        AVE_FACTOR = 10
        duration_ms = (timeit.timeit(lambda: algorithm(input_gen(input)), number=AVE_FACTOR) / AVE_FACTOR) * 1000
        times.append(duration_ms)
    gc.enable()

    violations = 0
    ratios = []

    print(f"\nRuntime Analysis for {algorithm.__name__}:")
    print(f"{'Size':<15} | {'Time (ms)':<12} | {'Ratio':<10} | {'Expected':<10} | {'Status'}")
    print("-" * 70)

    # Print first measurement with no ratio
    size_str = str(inputs[0])
    print(f"{size_str:<15} | {times[0]:<12.4f} | {'N/A':<10} | {'N/A':<10} | {'N/A'}")

    for i in range(1, len(inputs)):
        time_ratio = times[i] / times[i-1]

        # Calculate size ratio based on input type
        current_input = inputs[i]
        previous_input = inputs[i-1]
        
        if isinstance(current_input, tuple) and isinstance(previous_input, tuple):
            # For O(mn) complexity with tuple inputs (m, n)
            size_ratio = (current_input[0] * current_input[1]) / (previous_input[0] * previous_input[1])
        elif isinstance(current_input, int) and isinstance(previous_input, int):
            # For O(n) or O(n^2) complexity with int inputs
            size_ratio = current_input / previous_input
        else:
            # Mixed types shouldn't happen, but handle gracefully
            size_ratio = 1.0

        ratios.append(time_ratio)

        # Initialize default values
        expected_ratio = 0.0
        valid = False

        if expected_complexity == "O(n)":
            expected_ratio = size_ratio
            tolerance = 0.8
            valid = (0.5 * expected_ratio <= time_ratio <= 2.0 * expected_ratio)

        elif expected_complexity == "O(n^2)":
            expected_ratio = size_ratio ** 2
            # Check input size for tolerance (handle both int and tuple)
            if isinstance(current_input, tuple):
                input_size = current_input[0] * current_input[1]
            else:
                input_size = current_input
            tolerance = 0.6 if input_size < 500 else 0.4
            valid = abs(time_ratio - expected_ratio) <= expected_ratio * tolerance

        elif expected_complexity == "O(mn)":
            expected_ratio = size_ratio
            tolerance = 0.4
            valid = abs(time_ratio - expected_ratio) <= expected_ratio * tolerance

        status = "✅" if valid else "❌"
        if not valid:
            violations += 1

        size_str = str(current_input)
        print(f"{size_str:<15} | {times[i]:<12.4f} | {time_ratio:<10.4f} | {expected_ratio:<10.4f} | {status}")

    # Calculate average ratios for trend analysis
    avg_ratio = sum(ratios) / len(ratios)
    print(f"\nAverage time ratio: {avg_ratio:.4f}")

    # Get the average size ratio
    size_ratios = []
    for i in range(1, len(inputs)):
        current_input = inputs[i]
        previous_input = inputs[i-1]
        
        if isinstance(current_input, tuple) and isinstance(previous_input, tuple):
            ratio = (current_input[0] * current_input[1]) / (previous_input[0] * previous_input[1])
        elif isinstance(current_input, int) and isinstance(previous_input, int):
            ratio = current_input / previous_input
        else:
            ratio = 1.0
        size_ratios.append(ratio)
    
    avg_size_ratio = sum(size_ratios) / len(size_ratios)

    # Calculate violation rate before potential overrides
    violation_rate = violations / (len(inputs) - 1)

    # Determine growth pattern based on average ratio
    if expected_complexity == "O(n)":
        trend_matches = (0.7 < avg_ratio < 3.0)
        threshold = 0.3
    elif expected_complexity == "O(n^2)":
        trend_matches = (3.0 < avg_ratio < 6.0) if avg_size_ratio > 1.5 else (1.0 < avg_ratio < 4.0)
        threshold = 0.4
    elif expected_complexity == "O(mn)":
        trend_matches = (0.7 < avg_ratio < 1.5)
        threshold = 0.3
    else:
        trend_matches = False
        threshold = 0.2

    if trend_matches and violation_rate <= threshold:
        violations = 0

    violation_rate = violations / (len(inputs) - 1)

    if violation_rate < 0.3:
        print(f"✅ {algorithm.__name__} is within tolerance of {expected_complexity}")
        return expected_complexity
    else:
        print(f"❌ {algorithm.__name__} had ({violations}/{len(inputs)-1} violations)")
        return "complexity wrong"

