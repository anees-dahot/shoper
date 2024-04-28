const express = require("express");
const adminRouter = express.Router();
const admin = require("../middlewares/admin");
const Product = require("../model/product");
const User = require("../model/user");
const ReviewModel = require("../model/review");

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
    const products = await Product.find({ senderId: user.name });
    res.json({ products });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

//* review posting
adminRouter.post("/admin/post-review/:productId", admin, async (req, res) => {
  try {
    const { user, review, time } = req.body;
    const productId = req.params.productId;

    // Find the product by ID
    const product = await Product.findById(productId);

    // Push the new review to the reviews array
    product.reviews.push({ user, review, time });

    // Save the product with the new review
    await product.save();

    res.status(200).json({ message: "Review added successfully", product });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


//* delete product
adminRouter.post("/admin/delete-product/:productId", admin, async (req, res) => {
  try {
    const productId = req.params.productId;

    // // Find the product by ID
    await Product.findByIdAndDelete(productId);

    // // Save the product with the new review
   

    res.status(200).json({ message: "Product deleted successfully" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});





module.exports = adminRouter;
