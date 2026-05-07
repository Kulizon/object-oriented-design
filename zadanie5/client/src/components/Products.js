import React, { useEffect, useState, useContext } from "react";
import { fetchProducts } from "../api";
import { CartContext } from "../context/CartContext";

export default function Products() {
  const [products, setProducts] = useState([]);
  const { addToCart } = useContext(CartContext);

  useEffect(() => {
    fetchProducts().then((res) => setProducts(res.data));
  }, []);

  return (
    <div>
      <h2>Produkty</h2>
      <div style={{ display: "grid", gridTemplateColumns: "repeat(3, 1fr)", gap: "16px" }}>
        {products.map((p) => (
          <div key={p.id} style={{ border: "1px solid #ccc", borderRadius: "8px", padding: "16px", textAlign: "center" }}>
            <div style={{ fontSize: "48px" }}>{p.image}</div>
            <h3>{p.name}</h3>
            <p>{p.price.toFixed(2)} PLN</p>
            <button onClick={() => addToCart(p)}>Dodaj do koszyka</button>
          </div>
        ))}
      </div>
    </div>
  );
}
