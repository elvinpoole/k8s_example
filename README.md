# k8s_example

Example of running Python code with Kubernetes. Based on the candiamazing template.

## Layout

```
k8s_example/
├── src/hello_world/
│   ├── __init__.py
│   ├── cli.py
│   ├── core.py
│   └── test.py
├── tests/
│   ├── test_cli.py
│   ├── test_core.py
│   └── test_test.py
├── docs/
└── pyproject.toml
```

## Usage

```bash
pip install -e ".[dev]"
python src/hello_world/cli.py
pytest
```
