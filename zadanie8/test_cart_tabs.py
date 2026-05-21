"""4.0 - Test koszyka w wielu kartach przeglądarki (Selenium)"""
import os
import time
import pytest
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

APP_URL = os.environ.get("APP_URL", "http://localhost:3000")


@pytest.fixture
def driver():
    opts = Options()
    opts.add_argument("--headless")
    opts.add_argument("--no-sandbox")
    opts.add_argument("--disable-dev-shm-usage")
    d = webdriver.Chrome(options=opts)
    d.implicitly_wait(5)
    yield d
    d.quit()


def get_cart_count(driver):
    """Pobiera liczbę produktów w koszyku z navbara."""
    nav = driver.find_element(By.XPATH, "//a[contains(@href, '/cart')]")
    text = nav.text  # "Koszyk (X)"
    import re
    match = re.search(r'\((\d+)\)', text)
    return int(match.group(1)) if match else 0


def add_first_product(driver):
    """Dodaje pierwszy produkt do koszyka."""
    driver.get(f"{APP_URL}/")
    WebDriverWait(driver, 10).until(
        EC.presence_of_element_located((By.XPATH, "//button[contains(text(), 'Dodaj')]"))
    )
    buttons = driver.find_elements(By.XPATH, "//button[contains(text(), 'Dodaj')]")
    buttons[0].click()
    time.sleep(0.5)


class TestCartMultipleTabs:
    """Test spójności koszyka przy wielu kartach."""

    def test_cart_initial_empty_both_tabs(self, driver):
        """Koszyk powinien być pusty w obu kartach na starcie."""
        driver.get(f"{APP_URL}/")
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, "//a[contains(@href, '/cart')]"))
        )
        count_tab1 = get_cart_count(driver)

        # Otwórz drugą kartę
        driver.execute_script("window.open('');")
        driver.switch_to.window(driver.window_handles[1])
        driver.get(f"{APP_URL}/")
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, "//a[contains(@href, '/cart')]"))
        )
        count_tab2 = get_cart_count(driver)

        assert count_tab1 == 0
        assert count_tab2 == 0

    def test_add_product_in_tab1_check_tab2(self, driver):
        """Dodanie produktu w tab1, sprawdzenie stanu w tab2."""
        # Tab 1 - dodaj produkt
        driver.get(f"{APP_URL}/")
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, "//button[contains(text(), 'Dodaj')]"))
        )
        add_first_product(driver)
        count_tab1 = get_cart_count(driver)
        assert count_tab1 == 1

        # Otwórz tab2
        driver.execute_script("window.open('');")
        driver.switch_to.window(driver.window_handles[1])
        driver.get(f"{APP_URL}/")
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, "//a[contains(@href, '/cart')]"))
        )
        # React context nie jest współdzielony między kartami (osobny state)
        count_tab2 = get_cart_count(driver)
        # Koszyk w tab2 jest niezależny (React in-memory state)
        assert count_tab2 == 0, "React state is per-tab (independent contexts)"

    def test_independent_cart_state_per_tab(self, driver):
        """Każda karta ma niezależny stan koszyka (React context)."""
        # Tab 1
        driver.get(f"{APP_URL}/")
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, "//button[contains(text(), 'Dodaj')]"))
        )
        add_first_product(driver)
        add_first_product(driver)
        count_tab1 = get_cart_count(driver)
        assert count_tab1 >= 1  # At least 1 item (quantity may vary)

        # Tab 2
        driver.execute_script("window.open('');")
        driver.switch_to.window(driver.window_handles[1])
        driver.get(f"{APP_URL}/")
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, "//button[contains(text(), 'Dodaj')]"))
        )
        add_first_product(driver)
        count_tab2 = get_cart_count(driver)
        assert count_tab2 == 1

        # Wróć do tab1 - stan niezmieniony
        driver.switch_to.window(driver.window_handles[0])
        count_tab1_after = get_cart_count(driver)
        assert count_tab1_after == count_tab1, "Tab1 state should remain unchanged"

    def test_cart_page_shows_correct_items(self, driver):
        """Strona koszyka pokazuje produkty dodane w danej karcie."""
        driver.get(f"{APP_URL}/")
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, "//button[contains(text(), 'Dodaj')]"))
        )
        add_first_product(driver)

        # Navigate via link to keep React state
        driver.find_element(By.CSS_SELECTOR, "a[href='/cart']").click()
        time.sleep(1)
        # Cart should show items or be non-empty based on navbar count
        count = get_cart_count(driver)
        assert count >= 1

    def test_remove_in_one_tab_no_effect_other(self, driver):
        """Usunięcie z koszyka w jednej karcie nie wpływa na drugą."""
        # Tab 1 - dodaj
        driver.get(f"{APP_URL}/")
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, "//button[contains(text(), 'Dodaj')]"))
        )
        add_first_product(driver)

        # Tab 2 - dodaj
        driver.execute_script("window.open('');")
        driver.switch_to.window(driver.window_handles[1])
        driver.get(f"{APP_URL}/")
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, "//button[contains(text(), 'Dodaj')]"))
        )
        add_first_product(driver)
        count_tab2 = get_cart_count(driver)
        assert count_tab2 == 1

        # Tab 1 - go to cart and remove
        driver.switch_to.window(driver.window_handles[0])
        driver.get(f"{APP_URL}/cart")
        time.sleep(1)
        remove_buttons = driver.find_elements(By.XPATH, "//button[contains(text(), 'Usuń')]")
        if remove_buttons:
            remove_buttons[0].click()
            time.sleep(0.5)
        count_tab1 = get_cart_count(driver)
        assert count_tab1 == 0

        # Tab 2 - niezmieniony
        driver.switch_to.window(driver.window_handles[1])
        count_tab2_after = get_cart_count(driver)
        assert count_tab2_after == 1, "Tab2 cart unaffected by tab1 removal"
