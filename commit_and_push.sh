#!/bin/bash

SOURCE_PATH=$1
COMMIT_NAME=$2

CURPATH=$(pwd)
REPO_PATHS=$(ls $SOURCE_PATH)
total=$(echo "$REPO_PATHS" | wc -l)

# Задайте количество директорий для обработки перед паузой
DIRECTORIES_BEFORE_PAUSE=10
# Задайте интервал паузы
PAUSE_INTERVAL=5m

# Функция, которая будет выполняться в каждой директории
execute_push() {
    local dir="$1"
    echo "Выполняем пуш в директории: $dir"
    # Здесь можно добавить любую другую логику
    cd $SOURCE_PATH/$i

    git add .
    git commit -m "$COMMIT_NAME"

    git pull --rebase --autostash

    git push
}

# Счетчик обработанных директорий
count=0

# Основной цикл по всем директориям в текущем каталоге
for i in $REPO_PATHS; do
    dir="$SOURCE_PATH/$i"
    # Проверяем, является ли это директорией
    if [ -d "$dir" ]; then
        count=$((count+1))
        echo "============================================================================================"
        echo "Обработка $count/$total"
        echo $i
        execute_push $dir

        # Проверяем, достигли ли мы лимита
        if (( count % DIRECTORIES_BEFORE_PAUSE == 0 )); then
            echo "Обработано $count директорий. Пауза на $PAUSE_INTERVAL..."
            sleep "$PAUSE_INTERVAL"
        fi
    fi
done

echo "Все директории обработаны. Всего обработано: $count из $total."
