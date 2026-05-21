import React, { useContext } from "react";
import { Link } from "react-router-dom";
import { CartContext } from "../context/CartContext";

export default function Navbar() {
  const { cart } = useContext(CartContext);
  const count = cart.reduce((s, i) => s + i.quantity, 0);

  return (
    <nav style={{ display: "flex", gap: "16px", padding: "16px", borderBottom: "1px solid #ccc", alignItems: "center" }}>
      <Link to="/">Produkty</Link>
      <Link to="/cart">Koszyk ({count})</Link>
      <Link to="/payment">Płatności</Link>
      <Link to="/register">Rejestracja</Link>
      <Link to="/login">Logowanie</Link>
    </nav>
  );
}
