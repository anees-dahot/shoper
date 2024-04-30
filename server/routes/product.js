const express = require("express");
const productRouter = express.Router();
const admin = require("../middlewares/admin");
const auth = require("../middlewares/auth");
const Product = require("../model/product");


//* get products by category
productRouter.get("/api/product/", auth, async (req, res) => {
  try {

    // // Find the product by ID
    const product = await Product.find({category : req.query.category});
    if (!product) {
      return res.status(400).json({ msg: "No products for this categroy." });
    }

    res.json({product });
    console.log(product);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


//* search products
productRouter.get("/api/product/search/:name", auth, async (req, res) => {
  try {

    const product = await Product.find({name: { $regex: req.params.name, $options: 'i' },});
    if (!product) {
      return res.status(400).json({ msg: "No products for this query." });
    }

    res.json({product });
    console.log(product);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = productRouter;