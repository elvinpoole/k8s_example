"""
test.py
=======

**Author:** Jack Elvin-Poole

**Description:**
a smoke test
"""


from .core import HelloWorld


def test() -> None:
    """Quick basic tests to make sure the package was installed correctly"""

    printer = HelloWorld()
    printer.say_hello()
    print("All tests passed!")
