const express = require("express");
const adminRouter = express.Router();
const admin = require("../middlewares/admin");
const Product = require("../model/product");
const User = require("../model/user");

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

    product = await product.save();

    res.status(200).json({ msg: "product added successfully" });
    console.log(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// * get all products

adminRouter.get("/admin/get-products", admin, async (req, res) => {
  try {
    const user = await User.findById(req.user);
    if (!user) {
      return res.status(500).json({ error: "User not found" });
    }
    const products = await Product.find({senderId: user.name});
    res.json({ products });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = adminRouter;
