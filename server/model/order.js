const mongoose = require("mongoose");

const orderSchema = mongoose.Schema({
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
  items: [
    {
      productId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Product",
        required: true,
      },
      productName: { type: String, required: true },
      quantity: { type: Number, required: true },
      price: { type: Number, required: true },
      imageUrl: {
        type: String,
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
    },
  ],
  shippingAddress: { type: String, required: true },
  paymentMethod: { type: String, required: true },
  totalAmount: { type: Number, required: true },
  status: { type: String, required: true, default: "Pending" },
  createdAt: { type: Date, default: Date.now },
  
});

const order = mongoose.model("order", orderSchema);

module.exports = order;
