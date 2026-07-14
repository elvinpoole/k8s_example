"""
test.py
=======

**Author:** Jack Elvin-Poole

**Description:**
a smoke test
"""

import numpy as np

from .core import HelloWorld


def test():
    """Quick basic tests to make sure the package was installed correctly"""

    printer = HelloWorld()
    printer.say_hello()
    print("All tests passed!")
