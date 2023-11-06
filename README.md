# README

### Инструкция по запуску

Собираем основной контейнер с приложением:

```
docker-compose build
```

Запускаем проект:

```
docker-compose up
```

Накатываем миграции в БД:

```
docker-compose run --rm app rails db:migrate
```

---

[Postman коллекция](otus-highload-homework.postman_collection.json)
