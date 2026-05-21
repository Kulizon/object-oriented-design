# Zadanie 8 - Testy Selenium & Playwright


## Wymagania

```bash
pip install selenium playwright pytest
playwright install chromium
```

## Uruchomienie

```bash
cd ../zadanie5 && docker compose up -d

cd ../zadanie8
chmod +x run.sh
./run.sh
```

## Struktura testów

| Plik | Ocena | Opis |
|------|-------|------|
| `test_registration.py` | 3.0 | Walidacja formularza rejestracji |
| `test_xss.py` | 3.5 | Testy XSS w aplikacji React |
| `test_cart_tabs.py` | 4.0 | Spójność koszyka w wielu kartach |
| `test_csrf.py` | 4.5 | Testy CSRF na formularzu logowania |
| `test_e2e_playwright.py` | 5.0 | Scenariusz E2E (50+ asercji) |
