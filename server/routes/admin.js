const express = require("express");
const adminRouter = express.Router();
const admin = require("../middlewares/admin");
const auth = require("../middlewares/auth");
const Product = require("../model/product");
const User = require("../model/user");
const ReviewModel = require("../model/review");

adminRouter.post("/admin/sell-product", admin, async (req, res) => {
  try {
    const {
      name,
      price,
      description,
      quantity,
      category,
      colors,
      sizes,
      images,
      senderId,
      sale,
    } = req.body;

    let product = new Product({
      name,
      price,
      description,
      quantity,
      category,
      colors,
      sizes,
      images,
      senderId,
      sale,
    });

    product = await product.save();

    res.status(200).json({ msg: "product added successfully" });
    console.log(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// * get all products

adminRouter.get("/admin/get-products",  async (req, res) => {
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
// * get products with sale


adminRouter.get("/admin/get-saleproducts",  async (req, res) => {
  try {
    // const user = await User.find({sale});
    // if (!user) {
    //   return res.status(500).json({ error: "User not found" });
    // }
    const products = await Product.find({
      sale: { $gt: 0 }, // Filter for sale greater than 0 using $gt operator
    });
    res.json({ products });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

//* review posting
adminRouter.post("/admin/post-review/:productId", admin, async (req, res) => {
  try {
    const { user, review, time, stars } = req.body;
    const productId = req.params.productId;

    // Find the product by ID
    const product = await Product.findById(productId);

    // Push the new review to the reviews array
    product.reviews.push({ user, review, time, stars });

    // Save the product with the new review
    await product.save();

    res.status(200).json({ message: "Review added successfully", product });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

//* get reviews
adminRouter.get("/admin/get-reviews/:productId", admin, async (req, res) => {
  try {
    const productId = req.params.productId;

    // Execute population and retrieve populated product
    const product = await Product.findById(productId).populate("reviews");

    if (!product || !product.reviews || product.reviews.length === 0) {
      return res.status(404).json({ message: "Reviews not found" });
    }

    // Extract and return only the reviews data
    const reviews = product.reviews.map((review) => ({
      user: review.user,
      review: review.review,
      time: review.time, // Assuming time is a Date object
      stars: review.stars,
    }));

    res
      .status(200)
      .json({ message: "Reviews retrieved successfully", reviews });
  } catch (err) {
    console.error(err); // Log the error for debugging
    res.status(500).json({ error: "An error occurred" }); // Generic error message
  }
});

//* delete product
adminRouter.post(
  "/admin/delete-product/:productId",

  async (req, res) => {
    try {
      const productId = req.params.productId;

      // // Find the product by ID
      await Product.findByIdAndDelete(productId);

      // // Save the product with the new review

      res.status(200).json({ message: "Product deleted successfully" });
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  }
);

//* become a user
adminRouter.post("/admin/become-buyer", auth, async (req, res) => {
  try {
    const { id } = req.body;

    // // Find the product by ID
    const user = await User.findByIdAndUpdate(
      id,
      { type: "user" },
      {
        new: true,
      }
    );
    if (!user) {
      return res.status(400).json({ msg: "no user" });
    }

    res.status(200).json({ message: "You are now buyer!" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});
//* become a user
adminRouter.post("/admin/update-product/:productId", auth, async (req, res) => {
  const productId = req.params.productId;
  const updateData = req.body; // Object containing fields to update

  try {
    const updatedProduct = await Product.findOneAndUpdate(
      { _id: productId }, // Filter by product ID
      { $set: updateData }, // Update specific fields using $set
      { new: true } // Return the updated document
    );

    if (updatedProduct) {
      res.json({
        message: "Product updated successfully!",
        product: updatedProduct.value,
      }); // Send updated product data
      console.log("Product updated successfully!", updatedProduct);
    } else {
      res.status(404).json({ error: "Product not found." });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Error updating product." });
  }
});

module.exports = adminRouter;
