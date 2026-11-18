FROM python:3.12-slim

WORKDIR /app

# Update Debian OS packages
RUN apt-get update && apt-get upgrade -y \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

# Upgrade pip and setuptools
RUN pip install --no-cache-dir --upgrade pip setuptools

# Install application dependencies
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

# Create non-root user
RUN useradd --create-home appuser

USER appuser

EXPOSE 5000

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]