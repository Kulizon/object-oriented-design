import React, { useState } from "react";

function isAsciiAlphaNumeric(char) {
  const code = char.charCodeAt(0);
  const isUpper = code >= 65 && code <= 90;
  const isLower = code >= 97 && code <= 122;
  const isDigit = code >= 48 && code <= 57;
  return isUpper || isLower || isDigit;
}

function isValidLocalPart(local) {
  if (!local || local.startsWith(".") || local.endsWith(".")) return false;
  if (local.includes("..")) return false;

  for (const ch of local) {
    const allowedSpecial = ch === "." || ch === "_" || ch === "+" || ch === "-";
    if (!isAsciiAlphaNumeric(ch) && !allowedSpecial) return false;
  }

  return true;
}

function isValidDomainPart(domain) {
  if (!domain || domain.startsWith(".") || domain.endsWith(".")) return false;
  if (!domain.includes(".")) return false;

  const labels = domain.split(".");
  for (const label of labels) {
    if (!label) return false;
    if (label.startsWith("-") || label.endsWith("-")) return false;

    for (const ch of label) {
      if (!isAsciiAlphaNumeric(ch) && ch !== "-") return false;
    }
  }

  return true;
}

function isValidEmail(email) {
  if (typeof email !== "string") return false;
  if (email.length < 3 || email.length > 254) return false;
  if ([...email].some((ch) => ch === " " || ch === "\t" || ch === "\n" || ch === "\r")) return false;

  const atIndex = email.indexOf("@");
  if (atIndex <= 0) return false;
  if (email.indexOf("@", atIndex + 1) !== -1) return false;

  const local = email.slice(0, atIndex);
  const domain = email.slice(atIndex + 1);
  return isValidLocalPart(local) && isValidDomainPart(domain);
}

export default function Register() {
  const [form, setForm] = useState({ name: "", email: "", password: "", confirmPassword: "" });
  const [errors, setErrors] = useState({});
  const [success, setSuccess] = useState(false);

  const handleChange = (e) => setForm({ ...form, [e.target.name]: e.target.value });

  const validate = () => {
    const errs = {};
    if (!form.name.trim()) errs.name = "Imię jest wymagane";
    if (!form.email.trim()) errs.email = "Email jest wymagany";
    else if (!isValidEmail(form.email.trim())) errs.email = "Nieprawidłowy format email";
    if (!form.password) errs.password = "Hasło jest wymagane";
    else if (form.password.length < 6) errs.password = "Hasło musi mieć min. 6 znaków";
    if (form.password !== form.confirmPassword) errs.confirmPassword = "Hasła nie są zgodne";
    return errs;
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    const errs = validate();
    setErrors(errs);
    if (Object.keys(errs).length === 0) {
      setSuccess(true);
    }
  };

  if (success) {
    return (
      <div>
        <h2>Rejestracja</h2>
        <p data-testid="register-success">Rejestracja zakończona pomyślnie!</p>
      </div>
    );
  }

  return (
    <div>
      <h2>Rejestracja</h2>
      <form onSubmit={handleSubmit} style={{ display: "flex", flexDirection: "column", gap: "8px", maxWidth: "320px" }}>
        <div>
          <input name="name" placeholder="Imię" value={form.name} onChange={handleChange} data-testid="register-name" />
          {errors.name && <p style={{ color: "red" }} data-testid="error-name">{errors.name}</p>}
        </div>
        <div>
          <input name="email" placeholder="Email" value={form.email} onChange={handleChange} data-testid="register-email" />
          {errors.email && <p style={{ color: "red" }} data-testid="error-email">{errors.email}</p>}
        </div>
        <div>
          <input name="password" type="password" placeholder="Hasło" value={form.password} onChange={handleChange} data-testid="register-password" />
          {errors.password && <p style={{ color: "red" }} data-testid="error-password">{errors.password}</p>}
        </div>
        <div>
          <input name="confirmPassword" type="password" placeholder="Potwierdź hasło" value={form.confirmPassword} onChange={handleChange} data-testid="register-confirm" />
          {errors.confirmPassword && <p style={{ color: "red" }} data-testid="error-confirm">{errors.confirmPassword}</p>}
        </div>
        <button type="submit" data-testid="register-submit">Zarejestruj się</button>
      </form>
    </div>
  );
}
