"""5.0 - Scenariusz End-to-End w Playwright (50+ asercji)"""
import os
import re
import pytest
from playwright.sync_api import sync_playwright, expect

APP_URL = os.environ.get("APP_URL", "http://localhost:3000")


@pytest.fixture(scope="module")
def browser():
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        yield browser
        browser.close()


@pytest.fixture
def page(browser):
    context = browser.new_context()
    page = context.new_page()
    yield page
    context.close()


class TestE2EFullScenario:
    """Pełny scenariusz E2E z 50+ asercjami."""

    def test_homepage_loads(self, page):
        """1-5: Strona główna się ładuje poprawnie."""
        page.goto(APP_URL)
        # 1
        assert page.title() != ""
        # 2
        expect(page.locator("nav")).to_be_visible()
        # 3
        expect(page.locator("a[href='/']")).to_be_visible()
        # 4
        expect(page.locator("a[href='/cart']")).to_be_visible()
        # 5
        expect(page.locator("a[href='/payment']")).to_be_visible()

    def test_products_page_displays_items(self, page):
        """6-15: Strona produktów wyświetla produkty."""
        page.goto(APP_URL)
        page.wait_for_selector("button:has-text('Dodaj')")
        # 6
        expect(page.locator("h2")).to_have_text("Produkty")
        # 7
        buttons = page.locator("button:has-text('Dodaj do koszyka')")
        assert buttons.count() >= 3
        # 8
        assert buttons.count() == 6
        # 9
        expect(page.locator("text=Laptop")).to_be_visible()
        # 10
        expect(page.locator("text=Smartphone")).to_be_visible()
        # 11
        expect(page.locator("text=Headphones")).to_be_visible()
        # 12
        expect(page.locator("text=Keyboard")).to_be_visible()
        # 13
        expect(page.locator("text=Monitor")).to_be_visible()
        # 14
        expect(page.locator("text=Mouse")).to_be_visible()
        # 15
        expect(page.locator("text=PLN").first).to_be_visible()

    def test_add_to_cart(self, page):
        """16-22: Dodawanie produktów do koszyka."""
        page.goto(APP_URL)
        page.wait_for_selector("button:has-text('Dodaj')")
        # 16
        cart_link = page.locator("a[href='/cart']")
        expect(cart_link).to_contain_text("(0)")
        # 17 - dodaj pierwszy produkt
        page.locator("button:has-text('Dodaj do koszyka')").first.click()
        # 18
        expect(cart_link).to_contain_text("(1)")
        # 19 - dodaj drugi produkt
        page.locator("button:has-text('Dodaj do koszyka')").nth(1).click()
        # 20
        expect(cart_link).to_contain_text("(2)")
        # 21 - dodaj ten sam produkt ponownie
        page.locator("button:has-text('Dodaj do koszyka')").first.click()
        # 22
        expect(cart_link).to_contain_text("(3)")

    def test_cart_page(self, page):
        """23-30: Strona koszyka."""
        page.goto(APP_URL)
        page.wait_for_selector("button:has-text('Dodaj')")
        page.locator("button:has-text('Dodaj do koszyka')").first.click()
        page.locator("button:has-text('Dodaj do koszyka')").nth(1).click()
        page.wait_for_timeout(500)
        # Navigate via link instead of page.goto to preserve React state
        page.locator("a[href='/cart']").click()
        page.wait_for_timeout(1000)
        # 23
        expect(page.locator("h2")).to_have_text("Koszyk")
        # 24
        expect(page.locator("table")).to_be_visible()
        # 25
        rows = page.locator("tbody tr")
        assert rows.count() >= 1
        # 26
        expect(page.locator("text=Razem")).to_be_visible()
        # 27
        expect(page.locator("button:has-text('Usuń')").first).to_be_visible()
        # 28
        expect(page.locator("button:has-text('Przejdź do płatności')")).to_be_visible()
        # 29 - usuń produkt
        initial_count = rows.count()
        page.locator("button:has-text('Usuń')").first.click()
        page.wait_for_timeout(500)
        # 30
        assert page.locator("tbody tr").count() < initial_count or page.locator("text=pusty").count() > 0

    def test_empty_cart(self, page):
        """31-33: Pusty koszyk."""
        page.goto(f"{APP_URL}/cart")
        # 31
        expect(page.locator("h2")).to_have_text("Koszyk")
        # 32
        expect(page.locator("text=pusty")).to_be_visible()
        # 33
        assert page.locator("table").count() == 0

    def test_payment_page_empty_cart(self, page):
        """34-35: Strona płatności z pustym koszykiem."""
        page.goto(f"{APP_URL}/payment")
        # 34
        expect(page.locator("h2")).to_have_text("Płatności")
        # 35
        expect(page.locator("text=pusty")).to_be_visible()

    def test_payment_flow(self, page):
        """36-42: Przepływ płatności."""
        page.goto(APP_URL)
        page.wait_for_selector("button:has-text('Dodaj')")
        page.locator("button:has-text('Dodaj do koszyka')").first.click()
        page.wait_for_timeout(500)
        # Navigate via link to preserve React state
        page.locator("a[href='/payment']").click()
        page.wait_for_timeout(1000)
        # 36
        expect(page.locator("h2")).to_have_text("Płatności")
        # 37
        expect(page.locator("text=Do zapłaty")).to_be_visible()
        # 38
        expect(page.locator("input[name='cardNumber']")).to_be_visible()
        # 39
        expect(page.locator("input[name='expiry']")).to_be_visible()
        # 40
        expect(page.locator("input[name='cvv']")).to_be_visible()
        # 41
        page.fill("input[name='cardNumber']", "4111111111111111")
        page.fill("input[name='expiry']", "12/25")
        page.fill("input[name='cvv']", "123")
        page.locator("button[type='submit']").click()
        # 42
        expect(page.locator("text=zakończona")).to_be_visible(timeout=5000)

    def test_registration_page(self, page):
        """43-48: Formularz rejestracji."""
        page.goto(f"{APP_URL}/register")
        page.wait_for_selector("[data-testid='register-submit']")
        # 43
        expect(page.locator("h2")).to_have_text("Rejestracja")
        # 44
        expect(page.locator("[data-testid='register-name']")).to_be_visible()
        # 45
        expect(page.locator("[data-testid='register-email']")).to_be_visible()
        # 46
        expect(page.locator("[data-testid='register-password']")).to_be_visible()
        # 47
        expect(page.locator("[data-testid='register-confirm']")).to_be_visible()
        # 48
        expect(page.locator("[data-testid='register-submit']")).to_be_visible()

    def test_registration_validation_and_success(self, page):
        """49-55: Walidacja i sukces rejestracji."""
        page.goto(f"{APP_URL}/register")
        page.wait_for_selector("[data-testid='register-submit']")
        # 49 - submit empty
        page.locator("[data-testid='register-submit']").click()
        expect(page.locator("[data-testid='error-name']")).to_be_visible()
        # 50
        expect(page.locator("[data-testid='error-email']")).to_be_visible()
        # 51
        expect(page.locator("[data-testid='error-password']")).to_be_visible()
        # 52 - fill valid data
        page.fill("[data-testid='register-name']", "Jan Kowalski")
        page.fill("[data-testid='register-email']", "jan@test.pl")
        page.fill("[data-testid='register-password']", "haslo123")
        page.fill("[data-testid='register-confirm']", "haslo123")
        page.locator("[data-testid='register-submit']").click()
        # 53
        expect(page.locator("[data-testid='register-success']")).to_be_visible()
        # 54
        expect(page.locator("[data-testid='register-success']")).to_contain_text("pomyślnie")
        # 55
        assert page.locator("[data-testid='error-name']").count() == 0

    def test_login_page(self, page):
        """56-60: Formularz logowania."""
        page.goto(f"{APP_URL}/login")
        page.wait_for_selector("[data-testid='login-submit']")
        # 56
        expect(page.locator("h2")).to_have_text("Logowanie")
        # 57
        expect(page.locator("[data-testid='login-email']")).to_be_visible()
        # 58
        expect(page.locator("[data-testid='login-password']")).to_be_visible()
        # 59
        expect(page.locator("[data-testid='login-submit']")).to_be_visible()
        # 60 - submit empty shows error
        page.locator("[data-testid='login-submit']").click()
        expect(page.locator("[data-testid='login-error']")).to_be_visible()

    def test_login_success(self, page):
        """61-64: Logowanie z sukcesem."""
        page.goto(f"{APP_URL}/login")
        page.wait_for_selector("[data-testid='login-submit']")
        page.fill("[data-testid='login-email']", "user@test.com")
        page.fill("[data-testid='login-password']", "password123")
        page.locator("[data-testid='login-submit']").click()
        # 61
        expect(page.locator("[data-testid='login-success']")).to_be_visible()
        # 62
        expect(page.locator("[data-testid='login-success']")).to_contain_text("user@test.com")
        # 63
        expect(page.locator("[data-testid='session-token']")).to_be_visible()
        # 64
        token = page.locator("[data-testid='session-token']").text_content()
        assert len(token) > 0

    def test_navigation(self, page):
        """65-70: Nawigacja między stronami."""
        page.goto(APP_URL)
        page.wait_for_selector("nav")
        # 65
        page.locator("a[href='/cart']").click()
        page.wait_for_timeout(500)
        assert "/cart" in page.url
        # 66
        page.locator("a[href='/']").click()
        page.wait_for_timeout(500)
        expect(page.locator("h2")).to_have_text("Produkty")
        # 67
        page.locator("a[href='/register']").click()
        page.wait_for_timeout(500)
        assert "/register" in page.url
        # 68
        page.locator("a[href='/login']").click()
        page.wait_for_timeout(500)
        assert "/login" in page.url
        # 69
        page.locator("a[href='/payment']").click()
        page.wait_for_timeout(500)
        assert "/payment" in page.url
        # 70
        page.go_back()
        page.wait_for_timeout(500)
        assert "/login" in page.url
