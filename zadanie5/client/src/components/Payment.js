import React, { useContext, useState } from "react";
import { CartContext } from "../context/CartContext";
import { sendPayment } from "../api";

export default function Payment() {
  const { cart, total, clearCart } = useContext(CartContext);
  const [form, setForm] = useState({ cardNumber: "", expiry: "", cvv: "" });
  const [result, setResult] = useState(null);

  const handleChange = (e) => setForm({ ...form, [e.target.name]: e.target.value });

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const res = await sendPayment({
        ...form,
        items: cart.map((i) => ({ id: i.id, quantity: i.quantity })),
        total,
      });
      setResult(res.data);
      if (res.data.success) clearCart();
    } catch {
      setResult({ success: false, message: "Payment request failed" });
    }
  };

  if (result?.success) {
    return (
      <div>
        <h2>Płatność zakończona</h2>
        <p>{result.message}</p>
        <p>Nr zamówienia: {result.orderId}</p>
      </div>
    );
  }

  if (cart.length === 0 && !result) {
    return (
      <div>
        <h2>Płatności</h2>
        <p>Koszyk jest pusty — dodaj produkty przed płatnością.</p>
      </div>
    );
  }

  return (
    <div>
      <h2>Płatności</h2>
      <p>Do zapłaty: {total.toFixed(2)} PLN</p>
      {result && !result.success && <p style={{ color: "red" }}>{result.message}</p>}
      <form onSubmit={handleSubmit} style={{ display: "flex", flexDirection: "column", gap: "8px", maxWidth: "320px" }}>
        <input name="cardNumber" placeholder="Numer karty" value={form.cardNumber} onChange={handleChange} required />
        <input name="expiry" placeholder="MM/RR" value={form.expiry} onChange={handleChange} required />
        <input name="cvv" placeholder="CVV" value={form.cvv} onChange={handleChange} required />
        <button type="submit" style={{ padding: "8px" }}>Zapłać</button>
      </form>
    </div>
  );
}
