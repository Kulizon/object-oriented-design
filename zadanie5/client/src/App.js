import React from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import { CartProvider } from "./context/CartContext";
import Navbar from "./components/Navbar";
import Products from "./components/Products";
import Cart from "./components/Cart";
import Payment from "./components/Payment";
import Register from "./components/Register";
import Login from "./components/Login";

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
            <Route path="/register" element={<Register />} />
            <Route path="/login" element={<Login />} />
          </Routes>
        </div>
      </BrowserRouter>
    </CartProvider>
  );
}
