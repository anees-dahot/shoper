const mongoose = require("mongoose");

const reviewSchema = mongoose.Schema({
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
});

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
  images: [
    {
      type: String,
      required: true,
      trim: true,
    },
  ],
  senderId: {
    type: String,
    required: true,
    trim: true,
  },
  reviews: [reviewSchema],
});

const Product = mongoose.model("Products", productSchema);

module.exports = Product;
