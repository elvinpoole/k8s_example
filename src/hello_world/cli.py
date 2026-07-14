"""
Command-line interface for the hello_world package.

Run with:

    python ./src/hello_world/cli.py

or, after installing the package:

    hello-world
"""

import argparse

from hello_world import core


def build_parser() -> argparse.ArgumentParser:
    """Build the command-line argument parser."""
    return argparse.ArgumentParser(
        description="A minimal Hello World CLI."
    )


def main(argv: list[str] | None = None) -> int:
    """Run the CLI entry point."""
    parser = build_parser()
    parser.parse_args(argv)  # Parse arguments (there aren't any yet)

    core.HelloWorld().say_hello()

    return 0


if __name__ == "__main__":
    raise SystemExit(main())