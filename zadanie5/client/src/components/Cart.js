import React, { useContext } from "react";
import { useNavigate } from "react-router-dom";
import { CartContext } from "../context/CartContext";

export default function Cart() {
  const { cart, removeFromCart, total } = useContext(CartContext);
  const navigate = useNavigate();

  if (cart.length === 0) {
    return (
      <div>
        <h2>Koszyk</h2>
        <p>Koszyk jest pusty.</p>
      </div>
    );
  }

  return (
    <div>
      <h2>Koszyk</h2>
      <table style={{ width: "100%", borderCollapse: "collapse" }}>
        <thead>
          <tr>
            <th style={{ textAlign: "left", borderBottom: "1px solid #ccc", padding: "8px" }}>Produkt</th>
            <th style={{ textAlign: "right", borderBottom: "1px solid #ccc", padding: "8px" }}>Cena</th>
            <th style={{ textAlign: "right", borderBottom: "1px solid #ccc", padding: "8px" }}>Ilość</th>
            <th style={{ textAlign: "right", borderBottom: "1px solid #ccc", padding: "8px" }}>Suma</th>
            <th style={{ borderBottom: "1px solid #ccc", padding: "8px" }}></th>
          </tr>
        </thead>
        <tbody>
          {cart.map((item) => (
            <tr key={item.id}>
              <td style={{ padding: "8px" }}>{item.image} {item.name}</td>
              <td style={{ padding: "8px", textAlign: "right" }}>{item.price.toFixed(2)} PLN</td>
              <td style={{ padding: "8px", textAlign: "right" }}>{item.quantity}</td>
              <td style={{ padding: "8px", textAlign: "right" }}>{(item.price * item.quantity).toFixed(2)} PLN</td>
              <td style={{ padding: "8px", textAlign: "right" }}>
                <button onClick={() => removeFromCart(item.id)}>Usuń</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
      <h3 style={{ textAlign: "right", marginTop: "16px" }}>Razem: {total.toFixed(2)} PLN</h3>
      <button onClick={() => navigate("/payment")} style={{ marginTop: "8px", padding: "8px 24px" }}>
        Przejdź do płatności
      </button>
    </div>
  );
}
