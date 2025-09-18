import timeit
from typing import Callable
import gc
import math

def benchmark(algorithm: Callable, input_gen: Callable, inputs: list[int], expected_complexity: str) -> str:
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
    print(f"{'Size':<8} | {'Time (ms)':<12} | {'Ratio':<10} | {'Expected':<10} | {'Status'}")
    print("-" * 60)

    # Print first measurement with no ratio
    print(f"{inputs[0]:<8} | {times[0]:<12.4f} | {'N/A':<10} | {'N/A':<10} | {'N/A'}")

    for i in range(1, len(inputs)):
        time_ratio = times[i] / times[i-1]
        size_ratio = inputs[i] / inputs[i-1]
        ratios.append(time_ratio)

        # Initialize default values
        expected_ratio = 0
        valid = False

        if expected_complexity == "O(n)":
            expected_ratio = size_ratio
            # Linear algorithms can have high variance especially with smaller inputs
            # More generous tolerance
            tolerance = 0.8

            # For linear algorithms, we care more about the trend than exact ratios
            # Consider valid if within a reasonable range of linear growth
            valid = (0.5 * expected_ratio <= time_ratio <= 2.0 * expected_ratio)

        elif expected_complexity == "O(n^2)":
            expected_ratio = size_ratio ** 2
            # Quadratic algorithms often have more variance
            tolerance = 0.6 if inputs[i] < 500 else 0.4

            valid = abs(time_ratio - expected_ratio) <= expected_ratio * tolerance

        status = "✅" if valid else "❌"
        if not valid:
            violations += 1

        print(f"{inputs[i]:<8} | {times[i]:<12.4f} | {time_ratio:<10.4f} | {expected_ratio:<10.4f} | {status}")

    # Calculate average ratios for trend analysis
    avg_ratio = sum(ratios) / len(ratios)
    print(f"\nAverage time ratio: {avg_ratio:.4f}")

    # Get the average size ratio
    avg_size_ratio = sum(inputs[i] / inputs[i-1] for i in range(1, len(inputs))) / (len(inputs) - 1)

    # Calculate violation rate before potential overrides
    violation_rate = violations / (len(inputs) - 1)

    # Determine growth pattern based on average ratio
    if expected_complexity == "O(n)":
        # For O(n), we expect ratios close to the size_ratio (usually around 1-2)
        # Allow for some variance but check the overall trend
        trend_matches = (0.7 < avg_ratio < 3.0)
        threshold = 0.3  # Allow up to 30% of violations
    elif expected_complexity == "O(n^2)":
        # For O(n^2), expect ratios closer to size_ratio^2
        trend_matches = (3.0 < avg_ratio < 6.0) if avg_size_ratio > 1.5 else (1.0 < avg_ratio < 4.0)
        threshold = 0.4  # Allow up to 40% of violations
    else:
        trend_matches = False
        threshold = 0.2

    # Override violation rate if trend clearly matches expected complexity
    if trend_matches and violation_rate <= threshold:
        violations = 0

    violation_rate = violations / (len(inputs) - 1)

    if violation_rate < 0.3:
        print(f"✅ {algorithm.__name__} is within tolerance of {expected_complexity}")
        return expected_complexity
    else:
        print(f"❌ {algorithm.__name__} had ({violations}/{len(inputs)-1} violations)")
        return "complexity wrong"

