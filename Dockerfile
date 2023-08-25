FROM python:2
COPY . /app
WORKDIR /app
RUN ls -lah
ENTRYPOINT ["python3", "/app/exploit.py"]
