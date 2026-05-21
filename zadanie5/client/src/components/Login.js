import React, { useState } from "react";

export default function Login() {
  const [form, setForm] = useState({ email: "", password: "" });
  const [error, setError] = useState("");
  const [loggedIn, setLoggedIn] = useState(false);

  const handleChange = (e) => setForm({ ...form, [e.target.name]: e.target.value });

  const handleSubmit = (e) => {
    e.preventDefault();
    setError("");
    if (!form.email || !form.password) {
      setError("Wypełnij wszystkie pola");
      return;
    }
    // Mock login - store session token
    const token = btoa(`${form.email}:${Date.now()}`);
    sessionStorage.setItem("auth_token", token);
    sessionStorage.setItem("user_email", form.email);
    setLoggedIn(true);
  };

  if (loggedIn) {
    return (
      <div>
        <h2>Zalogowano</h2>
        <p data-testid="login-success">Witaj, {form.email}!</p>
        <p>Token sesji: <code data-testid="session-token">{sessionStorage.getItem("auth_token")}</code></p>
      </div>
    );
  }

  return (
    <div>
      <h2>Logowanie</h2>
      {error && <p style={{ color: "red" }} data-testid="login-error">{error}</p>}
      <form onSubmit={handleSubmit} style={{ display: "flex", flexDirection: "column", gap: "8px", maxWidth: "320px" }}>
        <input name="email" placeholder="Email" value={form.email} onChange={handleChange} data-testid="login-email" />
        <input name="password" type="password" placeholder="Hasło" value={form.password} onChange={handleChange} data-testid="login-password" />
        <button type="submit" data-testid="login-submit">Zaloguj się</button>
      </form>
    </div>
  );
}
