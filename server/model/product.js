const mongoose = require("mongoose");



const productSchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true,
  },
  description: {
    type: String,
    required: true,
    trim: true,
  },
  price: {
    type: Number,
    required: true,
  },
  quantity: {
    type: Number,
    required: true,
  },
  category: {
    type: String,
    required: true,
    trim: true,
  },
  sale: {
    type: Number,

    trim: true,
  },
  images: [
    {
      type: String,
      required: true,
      trim: true,
    },
  ],
  colors: [
    {
      type: String,
      required: true,
      trim: true,
    },
  ],
  sizes: [
    {
      type: Number,
      required: true,
      trim: true,
    },
  ],
  seller: {
    type: String,
    required: true,
    trim: true,
  },
  createdAt: { 
    type: Date, 
    default: Date.now 
  },
  reviews: {
    type: Array,
    user: {
      type: String,
      required: true,
      trim: true,
    },
    review: {
      type: String,
      required: true,
      trim: true,
    },
    time: {
      type: String,
      required: true,
    },
  },
});

const Product = mongoose.model("Products", productSchema);

module.exports = Product;
