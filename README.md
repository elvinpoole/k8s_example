# K8s_example: An example of how to run python code with kubernetes

using teh candiamazing template

```text
k8s_example/
├── src/helloworld/      #  The Actual Source Code
│   ├── __init__.py        #   - Exposes the API
│   ├── cli.py             #   - Command Line Interface entry point
│   ├── core.py            #   - Classes & State (The "OO" layer)
│   └── utils.py           #   - Math & Physics (The functional layer)
│
├── tests/                 #  Unit Tests
│   ├── test_cli.py
│   └── test_core.py
|
├── docs/                  #  Documentation website
│
├── pyproject.toml         #  Build Configuration & Metadata
└── README.md              #  Brief Documentation

```
