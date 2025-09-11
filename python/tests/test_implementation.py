from concepts.implementation import show_implementation, show_version

def test_show_implementation():
    assert show_implementation() == 'cpython'

def test_show_version():
    assert show_version() == "3.13.7"
