FROM python:3.11-slim-bookworm AS builder

WORKDIR /tmp

RUN pip install poetry && pip install poetry-plugin-export && poetry config virtualenvs.create false

COPY pyproject.toml poetry.lock ./

RUN poetry export -f requirements.txt --output requirements.txt 

FROM python:3.11-slim-bookworm AS final

ENV PYTHONPATH=/src \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONIOENCODING=utf-8

WORKDIR /src

COPY --from=builder /tmp/requirements.txt ./requirements.txt
RUN pip install --no-cache-dir --upgrade -r ./requirements.txt

COPY . .

CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
