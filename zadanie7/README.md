# Zadanie 7 - Vapor (Swift)

## Opis

Aplikacja webowa w frameworku **Vapor** (Swift) z:
- **Leaf** - silnik szablonów
- **Fluent** - ORM (SQLite)
- **Redis** - cache

## Modele

1. **Category** - kategorie produktów
2. **Product** - produkty (relacja: belongs to Category)
3. **Order** - zamówienia (relacja: belongs to Product)

## Uruchomienie

```bash
# Wymagania: Swift 5.9+, Redis (opcjonalnie via Docker)
chmod +x run.sh
./run.sh
```

Lub ręcznie:
```bash
docker compose up -d   # Redis
swift run App serve --hostname 0.0.0.0 --port 8080
```

Aplikacja dostępna na: http://localhost:8080

## Endpointy

| Ścieżka | Opis |
|----------|------|
| `/categories` | CRUD kategorii |
| `/products` | CRUD produktów |
| `/orders` | CRUD zamówień |

## Deploy na Heroku

```bash
heroku create --buildpack vapor/vapor
heroku addons:create heroku-redis:mini
git push heroku main
```
