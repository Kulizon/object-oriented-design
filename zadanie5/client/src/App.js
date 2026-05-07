import React from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import { CartProvider } from "./context/CartContext";
import Navbar from "./components/Navbar";
import Products from "./components/Products";
import Cart from "./components/Cart";
import Payment from "./components/Payment";

export default function App() {
  return (
    <CartProvider>
      <BrowserRouter>
        <Navbar />
        <div style={{ padding: "16px", maxWidth: "960px", margin: "0 auto" }}>
          <Routes>
            <Route path="/" element={<Products />} />
            <Route path="/cart" element={<Cart />} />
            <Route path="/payment" element={<Payment />} />
          </Routes>
        </div>
      </BrowserRouter>
    </CartProvider>
  );
}
