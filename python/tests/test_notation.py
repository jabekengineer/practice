"""
Must determine what are and are not valid python names
"""
import pytest
import subprocess
def test_invalid_name():
    error = subprocess.run(
        executable="python",
        args=["-c", "1b='hello'"]
    )
    pytest.raises(SyntaxError)

    assert is_valid_py_bnf_name('1b') is False

from concepts.notation import is_valid_py_bnf_name
def test_valid_name():
    assert is_valid_py_bnf_name('name') is True
