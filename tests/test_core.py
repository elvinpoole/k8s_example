"""Tests for the main interface of the hello_world package."""

from hello_world.core import HelloWorld


def test_say_hello(capsys):
    """HelloWorld.say_hello() should print 'Hello, world!'."""
    hello = HelloWorld()

    hello.say_hello()

    captured = capsys.readouterr()
    assert captured.out == "Hello, world!\n"