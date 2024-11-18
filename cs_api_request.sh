#!/bin/bash
# Параметры
API_URL="https://global.cityscreen.cloud/api/v1.4/impressions?offset=0&amount=1" # API CityScreen с параметром amount=1 (достаточно 1 показа чтобы узнать состояние)
API_TOKEN=$1   # Получаем {$CS_API_TOKEN}
FRAME_ID=$2    # Получаем {$CS_FRAME_ID}
SHOTS=$3       # Получаем {$CS_SHOTS}

# Вычисление временных меток
END_TIME=$(($(date +%s) * 1000))   # Конечное (текущее) время
START_TIME=$(($END_TIME - 600000)) # Начальное время (10 минут назад)

# Отправка запроса
RESPONSE=$(curl -s -X POST "$API_URL" \
  -H "Content-Type: application/json;charset=UTF-8" \
  -H "x-auth-token: $API_TOKEN" \
  --data-raw "{\"period\":{\"start\":$START_TIME,\"end\":$END_TIME},\"frames\":$FRAME_ID,\"onlyWithShots\":$SHOTS}")

# Вывод результата
echo "$RESPONSE"
