const express = require("express");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());

const products = [
  { id: 1, name: "Laptop", price: 3999.99, image: "💻" },
  { id: 2, name: "Smartphone", price: 1999.99, image: "📱" },
  { id: 3, name: "Headphones", price: 299.99, image: "🎧" },
  { id: 4, name: "Keyboard", price: 149.99, image: "⌨️" },
  { id: 5, name: "Monitor", price: 1299.99, image: "🖥️" },
  { id: 6, name: "Mouse", price: 89.99, image: "🖱️" },
];

app.get("/api/products", (_req, res) => {
  res.json(products);
});

app.post("/api/payments", (req, res) => {
  const { cardNumber, expiry, cvv, items, total } = req.body;

  if (!cardNumber || !expiry || !cvv || !items || !total) {
    return res.status(400).json({ success: false, message: "Missing payment data" });
  }

  res.json({
    success: true,
    message: `Payment of ${total.toFixed(2)} PLN accepted`,
    orderId: "ORD-" + Date.now(),
  });
});

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
