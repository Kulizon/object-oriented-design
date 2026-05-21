"""3.5 - Testy bezpieczeństwa XSS w aplikacji React (Selenium)"""
import os
import pytest
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.alert import Alert
from selenium.common.exceptions import NoAlertPresentException

APP_URL = os.environ.get("APP_URL", "http://localhost:3000")

XSS_PAYLOADS = [
    '<script>alert("XSS")</script>',
    '"><img src=x onerror=alert("XSS")>',
    "javascript:alert('XSS')",
    '<svg onload=alert("XSS")>',
    "';alert('XSS');//",
    '<iframe src="javascript:alert(1)">',
    '<body onload=alert("XSS")>',
    '{{constructor.constructor("alert(1)")()}}',
]


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


def check_no_alert(driver):
    """Sprawdza czy nie pojawił się alert JavaScript (XSS)."""
    try:
        alert = Alert(driver)
        alert_text = alert.text
        alert.accept()
        return False, f"XSS Alert triggered: {alert_text}"
    except NoAlertPresentException:
        return True, "No alert"


def check_no_script_execution(driver):
    """Sprawdza czy skrypt nie został wykonany w DOM."""
    scripts_in_body = driver.execute_script(
        "return document.body.querySelectorAll('script').length"
    )
    iframes = driver.execute_script(
        "return document.body.querySelectorAll('iframe').length"
    )
    return scripts_in_body == 0 and iframes == 0


class TestXSSRegistrationForm:
    """Testy XSS na formularzu rejestracji."""

    @pytest.mark.parametrize("payload", XSS_PAYLOADS)
    def test_xss_in_name_field(self, driver, payload):
        """Wstrzyknięcie XSS w polu imię."""
        driver.get(f"{APP_URL}/register")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-name']").send_keys(payload)
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-email']").send_keys("xss@test.com")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-password']").send_keys("password123")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-confirm']").send_keys("password123")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-submit']").click()

        safe, msg = check_no_alert(driver)
        assert safe, f"XSS vulnerability found with payload: {payload} - {msg}"
        assert check_no_script_execution(driver), f"Script/iframe injected with: {payload}"

    @pytest.mark.parametrize("payload", XSS_PAYLOADS)
    def test_xss_in_email_field(self, driver, payload):
        """Wstrzyknięcie XSS w polu email."""
        driver.get(f"{APP_URL}/register")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-name']").send_keys("Test")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-email']").send_keys(payload)
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-password']").send_keys("password123")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-confirm']").send_keys("password123")
        driver.find_element(By.CSS_SELECTOR, "[data-testid='register-submit']").click()

        safe, msg = check_no_alert(driver)
        assert safe, f"XSS vulnerability in email field: {payload} - {msg}"


class TestXSSProductSearch:
    """Testy XSS poprzez URL/nawigację."""

    @pytest.mark.parametrize("payload", XSS_PAYLOADS[:4])
    def test_xss_via_url_hash(self, driver, payload):
        """Próba XSS przez URL hash."""
        driver.get(f"{APP_URL}/#{payload}")
        safe, msg = check_no_alert(driver)
        assert safe, f"XSS via URL hash: {payload}"

    @pytest.mark.parametrize("payload", XSS_PAYLOADS[:4])
    def test_xss_via_url_param(self, driver, payload):
        """Próba XSS przez URL query param."""
        driver.get(f"{APP_URL}/?q={payload}")
        safe, msg = check_no_alert(driver)
        assert safe, f"XSS via URL param: {payload}"
