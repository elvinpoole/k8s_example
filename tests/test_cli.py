"""Unit tests for the hello_world command-line interface."""

import pytest

from hello_world.cli import main


def test_cli_hello_world(capsys):
    """The CLI should print 'Hello, world!'."""
    main()

    captured = capsys.readouterr()

    assert captured.out == "Hello, world!\n"


def test_cli_help(capsys):
    """The help flag should print the usage message."""
    with pytest.raises(SystemExit) as excinfo:
        main(["--help"])

    assert excinfo.value.code == 0

    captured = capsys.readouterr()

    assert "usage:" in captured.out
    assert "A minimal Hello World CLI." in captured.out