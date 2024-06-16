import requests
from bs4 import BeautifulSoup
import time
from datetime import datetime, timedelta


# Функция для извлечения новостей
def fetch_news(url):
    try:
        response = requests.get(url)
        soup = BeautifulSoup(response.text, 'html.parser')

        # Найти элементы с новостями (зависит от структуры веб-страницы)
        news_items = soup.find_all('div', class_='card card_all-new')

        for item in news_items:
            title = item.find('a', class_='link link_color').text.strip()
            summary = item.find('div', class_='card__summary card__summary_all-new').text.strip()
            authors = 'RT'  # На данной странице авторы не указаны

            # Проверка на упоминание партий
            if 'Республикан' in item.text or 'Демократ' in item.text:
                print(f'Заголовок: {title}')
                print(f'Аннотация: {summary}')
                print(f'Авторы: {authors}')
                print('---')

    except Exception as e:
        print(f'Ошибка при извлечении новостей: {e}')


# Основная функция для запуска скрипта на определенное время
def run_script(duration_hours):
    end_time = datetime.now() + timedelta(hours=duration_hours)
    print(f'Скрипт запущен на {duration_hours} часов. Время окончания: {end_time}')

    while datetime.now() < end_time:
        # URL новостного агентства
        url = 'https://russian.rt.com/tag/respublikanskaya-partiya'
        fetch_news(url)

        # Пауза перед следующим запросом (например, 10 минут(2))
        time.sleep(600)
        print('Новый запуск поиска')


# Запуск скрипта на 4 часа
run_script(4)
