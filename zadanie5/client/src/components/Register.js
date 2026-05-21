import React, { useState } from "react";

export default function Register() {
  const [form, setForm] = useState({ name: "", email: "", password: "", confirmPassword: "" });
  const [errors, setErrors] = useState({});
  const [success, setSuccess] = useState(false);

  const handleChange = (e) => setForm({ ...form, [e.target.name]: e.target.value });

  const validate = () => {
    const errs = {};
    if (!form.name.trim()) errs.name = "Imię jest wymagane";
    if (!form.email.trim()) errs.email = "Email jest wymagany";
    else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(form.email)) errs.email = "Nieprawidłowy format email";
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
