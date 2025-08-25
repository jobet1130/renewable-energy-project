# Use official Python 3.11 slim image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    default-libmysqlclient-dev \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy project metadata and README first (for pip install)
COPY pyproject.toml README.md ./

# Copy source code and tests
COPY src/ ./src
COPY tests/ ./tests

# Upgrade pip and setuptools
RUN python -m pip install --upgrade pip setuptools wheel

# Install project dependencies
RUN pip install .

# Expose Jupyter Notebook port
EXPOSE 8888

# Default command to launch Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
