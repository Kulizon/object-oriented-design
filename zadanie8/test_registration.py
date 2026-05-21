"""3.0 - Test walidacji formularza rejestracji (Selenium)"""
import os
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


class TestRegistrationValidation:
    """Testy walidacji formularza rejestracji."""

    def test_empty_form_shows_errors(self, driver):
        """Wysłanie pustego formularza powinno pokazać błędy."""
        driver.get(f"{APP_URL}/register")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-submit']").click()

        assert driver.find_element(By.CSS_SELECTOR, "[data-testid='error-name']").is_displayed()
        assert driver.find_element(By.CSS_SELECTOR, "[data-testid='error-email']").is_displayed()
        assert driver.find_element(By.CSS_SELECTOR, "[data-testid='error-password']").is_displayed()

    def test_required_name_field(self, driver):
        """Brak imienia powinien wyświetlić błąd."""
        driver.get(f"{APP_URL}/register")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-email']").send_keys("test@test.com")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-password']").send_keys("password123")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-confirm']").send_keys("password123")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-submit']").click()

        error = driver.find_element(By.CSS_SELECTOR, "[data-testid='error-name']")
        assert "wymagane" in error.text.lower()

    def test_invalid_email_format(self, driver):
        """Nieprawidłowy email powinien wyświetlić błąd formatu."""
        driver.get(f"{APP_URL}/register")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-name']").send_keys("Jan")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-email']").send_keys("invalid-email")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-password']").send_keys("password123")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-confirm']").send_keys("password123")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-submit']").click()

        error = driver.find_element(By.CSS_SELECTOR, "[data-testid='error-email']")
        assert "format" in error.text.lower() or "nieprawidłowy" in error.text.lower()

    def test_invalid_email_no_at(self, driver):
        """Email bez @ powinien być odrzucony."""
        driver.get(f"{APP_URL}/register")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-name']").send_keys("Jan")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-email']").send_keys("testtest.com")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-password']").send_keys("pass123")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-confirm']").send_keys("pass123")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-submit']").click()

        assert driver.find_element(By.CSS_SELECTOR, "[data-testid='error-email']").is_displayed()

    def test_invalid_email_no_domain(self, driver):
        """Email bez domeny powinien być odrzucony."""
        driver.get(f"{APP_URL}/register")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-name']").send_keys("Jan")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-email']").send_keys("test@")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-password']").send_keys("pass123")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-confirm']").send_keys("pass123")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-submit']").click()

        assert driver.find_element(By.CSS_SELECTOR, "[data-testid='error-email']").is_displayed()

    def test_short_password(self, driver):
        """Hasło krótsze niż 6 znaków powinno być odrzucone."""
        driver.get(f"{APP_URL}/register")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-name']").send_keys("Jan")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-email']").send_keys("jan@test.com")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-password']").send_keys("abc")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-confirm']").send_keys("abc")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-submit']").click()

        error = driver.find_element(By.CSS_SELECTOR, "[data-testid='error-password']")
        assert "6" in error.text or "min" in error.text.lower()

    def test_password_mismatch(self, driver):
        """Niezgodne hasła powinny wyświetlić błąd."""
        driver.get(f"{APP_URL}/register")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-name']").send_keys("Jan")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-email']").send_keys("jan@test.com")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-password']").send_keys("password123")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-confirm']").send_keys("different")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-submit']").click()

        error = driver.find_element(By.CSS_SELECTOR, "[data-testid='error-confirm']")
        assert "zgodne" in error.text.lower()

    def test_successful_registration(self, driver):
        """Poprawne dane powinny zakończyć rejestrację sukcesem."""
        driver.get(f"{APP_URL}/register")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-name']").send_keys("Jan Kowalski")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-email']").send_keys("jan@kowalski.pl")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-password']").send_keys("securePass123")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-confirm']").send_keys("securePass123")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-submit']").click()

        success = WebDriverWait(driver, 5).until(
            EC.presence_of_element_located((By.CSS_SELECTOR, "[data-testid='register-success']"))
        )
        assert "pomyślnie" in success.text.lower()
