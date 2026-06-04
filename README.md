[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=Kulizon_object-oriented-design&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=Kulizon_object-oriented-design)

## Zadanie 1

✅ 3.0 Procedura do generowania 50 losowych liczb od 0 do 100.
[`GenerateRandomNumbers`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie1/main.pas#L8-L14)

✅ 3.5 Procedura do sortowania liczb.
[`BubbleSort`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie1/main.pas#L16-L28)

✅ 4.0 Dodanie parametrów do procedury losującej określającymi zakres losowania: od, do, ile.
[`GenerateRandomNumbers(min, max, count)`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie1/main.pas#L8-L14)

✅ 4.5 Dodanie testów jednostkowych testujących procedury.
[Testy](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie1/main.pas#L30-L93)

✅ 5.0 Skrypt w bashu do uruchamiania aplikacji w Pascalu via docker.
[`run.sh`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie1/run.sh#L1-L3)

Kod: [`zadanie1/`](https://github.com/Kulizon/object-oriented-design/tree/main/zadanie1)

https://github.com/Kulizon/object-oriented-design/raw/main/presentations/zadanie1.mov
https://github.com/user-attachments/assets/d8e39a3e-b865-4fc6-853f-d836ee243c76

---

## Zadanie 2

✅ 3.0 Należy stworzyć jeden model z kontrolerem z produktami, zgodnie z CRUD (JSON)
[`ProductApiController`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie2/src/Controller/ProductApiController.php#L1-L88)

✅ 3.5 Należy stworzyć skrypty do testów endpointów via curl (JSON)
[`test_product.sh`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie2/tests/test_product.sh#L1-L46)

✅ 4.0 Należy stworzyć dwa dodatkowe kontrolery wraz z modelami (JSON)
[`CategoryApiController`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie2/src/Controller/CategoryApiController.php#L1-L74) · [`OrderApiController`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie2/src/Controller/OrderApiController.php#L1-L101)

✅ 4.5 Należy stworzyć widoki do wszystkich kontrolerów
[`ProductController` (widoki)](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie2/src/Controller/ProductController.php#L1-L95) · [`templates/product/`](https://github.com/Kulizon/object-oriented-design/tree/main/zadanie2/templates/product)

✅ 5.0 Stworzenie panelu administracyjnego
[`AdminController`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie2/src/Controller/AdminController.php#L1-L155) · [`templates/admin/`](https://github.com/Kulizon/object-oriented-design/tree/main/zadanie2/templates/admin)

Kod: [`zadanie2/`](https://github.com/Kulizon/object-oriented-design/tree/main/zadanie2)

https://github.com/Kulizon/object-oriented-design/raw/main/presentations/zadanie2.mov




---

## Zadanie 3

✅ 3.0 Należy stworzyć jeden kontroler wraz z danymi wyświetlanymi z listy na endpoint'cie w formacie JSON - Kotlin + Spring Boot
[`MainController /api/users`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie3/src/main/kotlin/pl/edu/kkula/zadanie3/controller/MainController.kt#L17-L30)

✅ 3.5 Należy stworzyć klasę do autoryzacji (mock) jako Singleton w formie eager
[`EagerAuthService`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie3/src/main/kotlin/pl/edu/kkula/zadanie3/service/EagerAuthService.kt#L1-L46)

✅ 4.0 Należy obsłużyć dane autoryzacji przekazywane przez użytkownika
[`MainController /api/login`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie3/src/main/kotlin/pl/edu/kkula/zadanie3/controller/MainController.kt#L32-L37)

✅ 4.5 Należy wstrzyknąć singleton do głównej klasy via @Autowired lub kontruktor (constructor injection)
[`MainController(authService)`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie3/src/main/kotlin/pl/edu/kkula/zadanie3/controller/MainController.kt#L13-L16)

✅ 5.0 Obok wersji Eager do wyboru powinna być wersja Singletona w wersji lazy
[`LazyAuthService`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie3/src/main/kotlin/pl/edu/kkula/zadanie3/service/LazyAuthService.kt#L1-L43) · [`AuthServiceConfig`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie3/src/main/kotlin/pl/edu/kkula/zadanie3/config/AuthServiceConfig.kt#L1-L35)

Kod: [`zadanie3/`](https://github.com/Kulizon/object-oriented-design/tree/main/zadanie3)

https://github.com/Kulizon/object-oriented-design/raw/main/presentations/zadanie3.mov

---

## Zadanie 4

✅ 3.0 Należy stworzyć aplikację we frameworku echo w j. Go, która będzie miała kontroler Pogody, która pozwala na pobieranie danych o pogodzie (lub akcjach giełdowych)
[`WeatherController`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie4/controllers/weather_controller.go#L1-L40)

✅ 3.5 Należy stworzyć model Pogoda (lub Giełda) wykorzystując gorm, a dane załadować z listy przy uruchomieniu
[`Weather` model](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie4/models/weather.go#L1-L12)

✅ 4.0 Należy stworzyć klasę proxy, która pobierze dane z serwisu zewnętrznego podczas zapytania do naszego kontrolera
[`ExternalWeatherService`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie4/services/weather_service.go#L28-L76)

✅ 4.5 Należy zapisać pobrane dane z zewnątrz do bazy danych
[`WeatherProxy` (cache DB)](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie4/services/weather_service.go#L79-L101)

✅ 5.0 Należy rozszerzyć endpoint na więcej niż jedną lokalizację (Pogoda), lub akcje (Giełda) zwracając JSONa
[`GetWeather` (multi-location)](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie4/controllers/weather_controller.go#L17-L40)

Kod: [`zadanie4/`](https://github.com/Kulizon/object-oriented-design/tree/main/zadanie4)

https://github.com/Kulizon/object-oriented-design/raw/main/presentations/zadanie4.mov

---

## Zadanie 5

✅ 3.0 Komponenty Produkty (pobieranie z serwera) oraz Płatności (wysyłanie do serwera)
[`Products.js`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie5/client/src/components/Products.js#L1-L30) · [`Payment.js`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie5/client/src/components/Payment.js#L1-L59)

✅ 3.5 Komponent Koszyk z osobnym widokiem; routing pomiędzy widokami
[`Cart.js`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie5/client/src/components/Cart.js#L1-L51) · [`App.js` (routing)](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie5/client/src/App.js#L1-L28)

✅ 4.0 Przekazywanie danych między komponentami przez React hooks (useState, useEffect, useContext)
[`CartContext.js`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie5/client/src/context/CartContext.js#L1-L43)

✅ 4.5 Konfiguracja Docker + docker-compose dla klienta i serwera
[`docker-compose.yaml`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie5/docker-compose.yaml#L1-L12) · [`client/Dockerfile`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie5/client/Dockerfile#L1-L10) · [`server/Dockerfile`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie5/server/Dockerfile#L1-L7)

✅ 5.0 Axios do komunikacji z serwerem oraz obsługa CORS
[`api.js`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie5/client/src/api.js#L1-L8) · [`server/index.js` (CORS)](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie5/server/index.js#L1-L36)

Kod: [`zadanie5/`](https://github.com/Kulizon/object-oriented-design/tree/main/zadanie5)

https://github.com/Kulizon/object-oriented-design/raw/main/presentations/zadanie5.mov

---

## Zadanie 6

✅ 3.0 Należy skonfigurować husky + lint-staged uruchamianie lintowania przed commitem
[`package.json` (lint-staged)](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/package.json)

✅ 3.5 Należy wyeliminować wszystkie bugi w kodzie w Sonarze (kod aplikacji klienckiej)
[`Login.js` (sanitize)](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie5/client/src/components/Login.js) · [`Register.js`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie5/client/src/components/Register.js)

❌ 4.0 Przeskanować oraz naprawić dowolny projekt open source narzędziem CodeQL

✅ 4.5 Należy usunąć problemy typu Code Smell w kodzie w Sonarze (kotlin, go, js). Należy dodać badge z Sonara
[Badge (góra README)](#) · [`RoutePaths` enum (Swift)](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie7/Sources/App/routes.swift#L1-L17)

✅ 5.0 Skonfigurować Github Actions z linterem oraz CodeQL
[`ci.yml`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/.github/workflows/ci.yml#L1-L68)

Kod: [`.github/workflows/ci.yml`](https://github.com/Kulizon/object-oriented-design/blob/main/.github/workflows/ci.yml) · [`package.json`](https://github.com/Kulizon/object-oriented-design/blob/main/package.json)

https://github.com/Kulizon/object-oriented-design/raw/main/presentations/zadanie6.mov

---

## Zadanie 7

✅ 3.0 Należy stworzyć kontroler wraz z modele Produktów zgodny z CRUD w ORM Fluent
[`ProductController`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie7/Sources/App/Controllers/ProductController.swift#L1-L91) · [`Product` model](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie7/Sources/App/Models/Product.swift#L1-L42)

✅ 3.5 Należy stworzyć szablony w Leaf
[`configure.swift`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie7/Sources/App/configure.swift#L1-L30)

✅ 4.0 Należy stworzyć drugi model oraz kontroler Kategorii wraz z relacją
[`CategoryController`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie7/Sources/App/Controllers/CategoryController.swift#L1-L96) · [`Category` model](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie7/Sources/App/Models/Category.swift#L1-L35)

✅ 4.5 Należy wykorzystać Redis do przechowywania danych
[`ProductController` (Redis cache)](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie7/Sources/App/Controllers/ProductController.swift#L1-L91)

❌ 5.0 Wrzucić aplikację na heroku

Kod: [`zadanie7/`](https://github.com/Kulizon/object-oriented-design/tree/main/zadanie7)

https://github.com/Kulizon/object-oriented-design/raw/main/presentations/zadanie7.mov

---

## Zadanie 8

✅ 3.0 Test walidacji formularza rejestracji (Selenium) - pola obowiązkowe, nieprawidłowy email
[`test_registration.py`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie8/test_registration.py#L1-L118)

✅ 3.5 Testy bezpieczeństwa XSS w aplikacji React (Selenium)
[`test_xss.py`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie8/test_xss.py#L1-L104)

✅ 4.0 Test koszyka w wielu kartach przeglądarki (spójność stanu)
[`test_cart_tabs.py`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie8/test_cart_tabs.py#L1-L169)

✅ 4.5 Formularz logowania + testy CSRF (Selenium)
[`test_csrf.py`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie8/test_csrf.py#L1-L143)

✅ 5.0 Scenariusz End-to-End w Playwright (70 asercji)
[`test_e2e_playwright.py`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie8/test_e2e_playwright.py#L1-L265)

Kod: [`zadanie8/`](https://github.com/Kulizon/object-oriented-design/tree/main/zadanie8)

https://github.com/Kulizon/object-oriented-design/raw/main/presentations/zadanie8.mov

---

## Zadanie 9

✅ 3.0 Należy stworzyć odpowiednie instancje po stronie chmury na dockerze
[`zadanie7/Dockerfile`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie7/Dockerfile)

✅ 3.5 Stworzyć odpowiedni pipeline w Github Actions do budowania aplikacji
[`zadanie9-azure.yml` (build job)](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/.github/workflows/zadanie9-azure.yml#L17-L44)

✅ 4.0 Dodać notyfikację mailową o zbudowaniu aplikacji
[`zadanie9-azure.yml` (notify job)](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/.github/workflows/zadanie9-azure.yml#L75-L97)

✅ 4.5 Dodać krok z deploymentem aplikacji serwerowej oraz klienckiej na chmurę (https://oob.azurewebsites.net/products)
[`zadanie9-azure.yml` (deploy job)](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/.github/workflows/zadanie9-azure.yml#L46-L53)

✅ 5.0 Dodać uruchomienie regresyjnych testów automatycznych (funkcjonalnych) jako krok w Actions
[`regression_tests.sh`](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/zadanie9/regression_tests.sh#L1-L63) · [`zadanie9-azure.yml` (regression-tests job)](https://github.com/Kulizon/object-oriented-design/blob/74c12497972f18573910d8983ed2d7b728baaccc/.github/workflows/zadanie9-azure.yml#L55-L73)

Kod: [`zadanie9/`](https://github.com/Kulizon/object-oriented-design/tree/main/zadanie9) · [`.github/workflows/zadanie9-azure.yml`](https://github.com/Kulizon/object-oriented-design/blob/main/.github/workflows/zadanie9-azure.yml)

https://github.com/Kulizon/object-oriented-design/raw/main/presentations/zadanie9.mov
