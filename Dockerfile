FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install \
  --no-cache-dir \
  --requirement \
  requirements.txt

COPY service/ ./service/

RUN useradd --uid 1000 theia
RUN chown theia -R /app
USER theia

EXPOSE 8080

CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]

