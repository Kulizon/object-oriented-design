[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=Kulizon_object-oriented-design&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=Kulizon_object-oriented-design)

Zadanie 1
✅ 3.0 Procedura do generowania 50 losowych liczb od 0 do 100.
✅ 3.5 Procedura do sortowania liczb.
✅ 4.0 Dodanie parametrów do procedury losującej określającymi zakres losowania: od, do, ile.
✅ 4.5 Dodanie testów jednostkowych testujących procedury.
✅ 5.0 Skrypt w bashu do uruchamiania aplikacji w Pascalu via docker.

Zadanie 2
✅ 3.0 Należy stworzyć jeden model z kontrolerem z produktami, zgodnie z CRUD (JSON)
✅ 3.5 Należy stworzyć skrypty do testów endpointów via curl (JSON)
✅ 4.0 Należy stworzyć dwa dodatkowe kontrolery wraz z modelami  (JSON)
✅ 4.5 Należy stworzyć widoki do wszystkich kontrolerów
✅ 5.0 Stworzenie panelu administracyjnego

Zadanie 3
✅ 3.0 Należy stworzyć jeden kontroler wraz z danymi wyświetlanymi z
listy na endpoint’cie w formacie JSON - Kotlin + Spring Boot
✅ 3.5 Należy stworzyć klasę do autoryzacji (mock) jako Singleton w
formie eager
✅ 4.0 Należy obsłużyć dane autoryzacji przekazywane przez użytkownika
✅ 4.5 Należy wstrzyknąć singleton do głównej klasy via @Autowired lub
kontruktor (constructor injection)
✅ 5.0 Obok wersji Eager do wyboru powinna być wersja Singletona w wersji
lazy

Zadanie 4
✅ 3.0 Należy stworzyć aplikację we frameworku echo w j. Go, która będzie miała kontroler Pogody, która pozwala na pobieranie danych o pogodzie (lub akcjach giełdowych)
✅ 3.5 Należy stworzyć model Pogoda (lub Giełda) wykorzystując gorm, a dane załadować z listy przy uruchomieniu
✅ 4.0 Należy stworzyć klasę proxy, która pobierze dane z serwisu zewnętrznego podczas zapytania do naszego kontrolera
✅ 4.5 Należy zapisać pobrane dane z zewnątrz do bazy danych
✅ 5.0 Należy rozszerzyć endpoint na więcej niż jedną lokalizację (Pogoda), lub akcje (Giełda) zwracając JSONa

Zadanie 5
✅ 3.0 Komponenty Produkty (pobieranie z serwera) oraz Płatności (wysyłanie do serwera)
✅ 3.5 Komponent Koszyk z osobnym widokiem; routing pomiędzy widokami
✅ 4.0 Przekazywanie danych między komponentami przez React hooks (useState, useEffect, useContext)
✅ 4.5 Konfiguracja Docker + docker-compose dla klienta i serwera
✅ 5.0 Axios do komunikacji z serwerem oraz obsługa CORS

Zadanie 6
✅ 3.0 Należy skonfigurować husky + lint-staged uruchamianie lintowania przed commitem
✅ 3.5 Należy wyeliminować wszystkie bugi w kodzie w Sonarze (kod aplikacji klienckiej)
❌ 4.0 Przeskanować oraz naprawić dowolny projekt open source narzędziem CodeQL
✅ 4.5 Należy usunąć problemy typu Code Smell w kodzie w Sonarze (kotlin, go, js). Należy dodać badge z Sonara
✅ 5.0 Skonfigurować Github Actions z linterem oraz CodeQL

Zadanie 7
✅ 3.0 Należy stworzyć kontroler wraz z modele Produktów zgodny z CRUD w
ORM Fluent
✅ 3.5 Należy stworzyć szablony w Leaf
✅ 4.0 Należy stworzyć drugi model oraz kontroler Kategorii wraz z
relacją
✅ 4.5 Należy wykorzystać Redis do przechowywania danych
❌ 5.0 Wrzucić aplikację na heroku

Zadanie 8
✅ 3.0 Test walidacji formularza rejestracji (Selenium) - pola obowiązkowe, nieprawidłowy email
✅ 3.5 Testy bezpieczeństwa XSS w aplikacji React (Selenium)
✅ 4.0 Test koszyka w wielu kartach przeglądarki (spójność stanu)
✅ 4.5 Formularz logowania + testy CSRF (Selenium)
✅ 5.0 Scenariusz End-to-End w Playwright (70 asercji)