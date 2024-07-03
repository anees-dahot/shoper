const mongoose = require("mongoose");

const cartSchema = mongoose.Schema({
  sellerId: {
    type: String,
    required: true,
    trim: true,
  },
  buyerId: {
    type: String,
    required: true,
    trim: true,
  },
  productName: {
    type: String,
    required: true,
    trim: true,
  },
  productId: {
    type: String,
    required: true,
    trim: true,
  },
  description: {
    type: String,
    required: true,
    trim: true,
  },
  imageUrl: {
    type: String,
    required: true,
  },
  price: {
    type: Number,
    required: true,
  },
  quantity: {
    type: Number,
    required: true,
  },
  color: {
    type: String,
    required: true,
    trim: true,
  },

  size: {
    type: Number,
    required: true,
    trim: true,
  },
});

const Cart = mongoose.model("cart", cartSchema);

module.exports = Cart;
