from concepts.dynamic_programming.lcs import lcs

def test_lcs():
    str_one = "abecba"  
    str_two = "bcdbcda"
    assert lcs(x=str_one, y=str_two) == 4

def test_runtime():
    from tests.runtimer import benchmark
    EXP_RUNTIME = "O(mn)"

    def lcs_input_gen(sizes: tuple[int, int]) -> tuple[str, str]:
        from random import choice
        import string
        # Generate two random strings of specified lengths
        alphabet = string.ascii_lowercase
        len1, len2 = sizes
        str1 = ''.join(choice(alphabet) for _ in range(len1))
        str2 = ''.join(choice(alphabet) for _ in range(len2))
        return str1, str2

    def lcs_wrapper(strings: tuple[str, str]) -> int:
        return lcs(strings[0], strings[1])

    # Use increasing input sizes for both strings
    actual_complexity = benchmark(
        algorithm=lcs_wrapper,
        input_gen=lcs_input_gen,
        inputs=[(100, 100), (150, 150), (200, 200), (250, 250), (300, 300)],
        expected_complexity=EXP_RUNTIME
    )
    assert actual_complexity == EXP_RUNTIME

def main():
    test_lcs()
    test_runtime()

if __name__ == "__main__":
    main()