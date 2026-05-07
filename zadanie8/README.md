# Zadanie 8 - Zapaszki (Code Smells)

## Przegląd

Analiza i naprawa problemów jakości kodu wykrytych przez SonarCloud w projektach: JS (zadanie5), Kotlin (zadanie3), Go (zadanie4), oraz PHP/HTML (zadanie2).

**SonarCloud Project:** https://sonarcloud.io/project/overview?id=Kulizon_object-oriented-design
**Issues:** https://sonarcloud.io/project/issues?issueStatuses=OPEN%2CCONFIRMED&id=Kulizon_object-oriented-design

[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=Kulizon_object-oriented-design&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=Kulizon_object-oriented-design)

---

## Before (46 issues total)

| # | Rule | Severity | File | Issue |
|---|------|----------|------|-------|
| 1 | go:S1192 | CRITICAL | zadanie4/main.go | Duplicated string "Preloaded from initial list (DB)" 3 times |
| 2 | text:S8569 | MAJOR | zadanie3/build.gradle.kts | Dependency versions not predictable without lock file |
| 3 | kotlin:S6515 | MAJOR | zadanie3/.../EagerAuthService.kt | Singleton pattern should use object declarations |
| 4 | shelldre:S7688 | MAJOR | zadanie3/run.sh | Use `[[` instead of `[` for conditional tests |
| 5 | docker:S6596 | MAJOR | zadanie2/Dockerfile | Use a specific version tag for the image |
| 6 | docker:S7031 | MINOR | zadanie2/Dockerfile | Merge consecutive RUN instructions |
| 7 | php:S2003 | MINOR | zadanie2/config/preload.php | Replace "require" with "require_once" (BUG) |
| 8 | php:S1192 | CRITICAL | zadanie2/.../CategoryApiController.php | Duplicated "/{id}" literal 3 times |
| 9 | php:S1192 | CRITICAL | zadanie2/.../OrderApiController.php | Duplicated "/{id}" literal 3 times |
| 10 | php:S1192 | CRITICAL | zadanie2/.../ProductApiController.php | Duplicated "/{id}" literal 3 times |
| 11 | php:S1186 | CRITICAL | zadanie2/.../SecurityController.php | Empty method without comment |
| 12 | php:S1186 | CRITICAL | zadanie2/.../AdminUser.php | Empty method without comment |
| 13 | php:S1066 | MAJOR | zadanie2/.../Category.php | Merge nested if statement |
| 14 | Web:S5254 | MAJOR | zadanie2/templates/base.html.twig | Missing "lang" on `<html>` (BUG) |
| 15-16 | Web:S5725 | MINOR | zadanie2/templates/base.html.twig | Missing resource integrity (VULNERABILITY) |
| 17-44 | Web:S6853 | MAJOR | zadanie2/templates/*.html.twig | Form labels not associated with controls (28 issues) |
| 45-46 | shelldre:S1192 | MINOR | zadanie2/tests/test_all.sh | Duplicated literal strings |

---

## After - Fixes Applied

### Fixed (35+ issues resolved)

| Rule | File | Fix |
|------|------|-----|
| go:S1192 | zadanie4/main.go | Extracted duplicated string to `preloadedSource` constant |
| (deprecated API) | zadanie4/services/weather_service.go | Replaced `strings.Title` with `cases.Title` (golang.org/x/text) |
| shelldre:S7688 | zadanie3/run.sh | Changed `[` to `[[` for conditional test |
| docker:S7031 | zadanie2/Dockerfile | Merged consecutive RUN instructions |
| php:S2003 | zadanie2/config/preload.php | Changed `require` to `require_once` |
| php:S1186 | zadanie2/.../SecurityController.php | Added explanatory comment |
| php:S1186 | zadanie2/.../AdminUser.php | Added explanatory comment |
| php:S1066 | zadanie2/.../Category.php | Merged nested if into single condition |
| Web:S5254 | zadanie2/templates/base.html.twig | Added `lang="pl"` to `<html>` |
| Web:S5725 | zadanie2/templates/base.html.twig | Added `integrity` + `crossorigin` to CDN resources |
| Web:S6853 (x28) | zadanie2/templates/*.html.twig | Added `for`/`id` to all labels and form controls |

---

## 3.0 - Husky + lint-staged

Skonfigurowano w katalogu głównym repozytorium:
- **husky** - pre-commit hook (`/.husky/pre-commit`)
- **lint-staged** - uruchamia ESLint na staged JS/JSX files z `zadanie5/`
- **ESLint** - `.eslintrc.json` z regułami: `no-unused-vars`, `eqeqeq`, `no-var`, `prefer-const`

## 3.5 - Bug Fixes (Sonar)

- `Web:S5254` (BUG): Dodano `lang="pl"` do `<html>` w `base.html.twig`
- `php:S2003` (BUG): Zamieniono `require` na `require_once` w `preload.php`
- **zadanie5/client** - dodano `.catch()` w `Products.js` useEffect

## 4.5 - Code Smell Fixes

- **Go**: Extracted constant, replaced deprecated API
- **Kotlin**: Fixed shell conditional syntax
- **JS**: ESLint configured, code passes linting
- **PHP/HTML**: Fixed 30+ accessibility and code quality issues

## 5.0 - GitHub Actions

CI pipeline w `.github/workflows/ci.yml`:
- **ESLint job** - lintuje kod JS z zadanie5
- **CodeQL job** - skanuje JavaScript/TypeScript i Go
