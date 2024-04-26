const express = require("express");
const adminRouter = express.Router();
const admin = require("../middlewares/admin");
const Product = require("../model/product");

adminRouter.post("/admin/sell-product", admin, async (req, res) => {
  try {
    const { name, price, description, quantity, category, images, senderId } =
      req.body;

    let product = new Product({
      name,
      price,
      description,
      quantity,
      category,
      images,
      senderId,
    });

    product = product.save();

    res.status(200).json({ msg: "product added successfully" });
    console.log(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});




module.exports = adminRouter;
