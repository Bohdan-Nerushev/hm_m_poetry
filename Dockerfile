# Використовуємо базовий образ Python 3.12
FROM python:3.12

# Оновлюємо та встановлюємо необхідні пакети
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Встановлюємо Poetry через скрипт установки
RUN curl -sSL https://install.python-poetry.org | python3 -

# Додаємо Poetry до PATH
ENV PATH="/root/.local/bin:$PATH"

# Встановлюємо робочу директорію контейнера
WORKDIR /app

# Копіюємо файли проекту залежностей
COPY pyproject.toml poetry.lock /app/

# Виконуємо установку залежностей через Poetry
RUN poetry install --no-interaction --no-ansi

# Копіюємо інші файли вашого додатку
COPY . .

# Задаємо команду для запуску додатку за замовчуванням
CMD ["python", "app.py"]

