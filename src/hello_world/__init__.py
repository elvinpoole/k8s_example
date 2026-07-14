from .core import HelloWorld
from .test import test

try:
    from ._version import version as __version__  # noqa
except ImportError:
    __version__ = "0.0.0dev"

__author__ = "Jack Elvin-Poole"

# List packages here to explicitly define the public API
__all__ = (
    "HelloWorld",
    "__version__",
    "__author__",
)
