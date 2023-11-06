# README

### Инструкция по запуску

Собираем основной контейнер с приложением:

```
docker-compose build
```

Создаем БД:

```
docker-compose run --rm app rails db:create
```

Накатываем миграции в БД:

```
docker-compose run --rm app rails db:migrate
```

Запускаем проект:

```
docker-compose up
```

---

[Postman коллекция](otus-highload-homework.postman_collection.json)
