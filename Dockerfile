FROM python:3.12-slim

WORKDIR /app

COPY pyproject.toml README.md LICENSE ./
COPY src ./src

# hatch-vcs needs a version when .git is not present in the image
ENV SETUPTOOLS_SCM_PRETEND_VERSION=0.0.0

RUN pip install --no-cache-dir .

CMD ["hello-world"]
