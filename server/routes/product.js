const express = require("express");
const productRouter = express.Router();
const admin = require("../middlewares/admin");
const auth = require("../middlewares/auth");
const Product = require("../model/product");

//* get products by category
productRouter.get("/api/product/", auth, async (req, res) => {
  try {
    // // Find the product by ID
    const product = await Product.find({ category: req.query.category });
    if (!product) {
      return res.status(400).json({ msg: "No products for this categroy." });
    }

    res.json({ product });
    console.log(product);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

//* get new arrival products
productRouter.get("/api/product/new-arrivals", auth, async (req, res) => {
  const { startDate, endDate } = req.query;
  const query = {};

  if (startDate && endDate) {
    query.createdAt = {
      $gte: new Date(startDate),
      $lte: new Date(endDate),
    };
  }

  try {
    const products = await Product.find(query);
    res.json(products);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: error.message });
  }
});

//* search products
productRouter.get("/api/product/search/:name", auth, async (req, res) => {
  try {
    const product = await Product.find({
      name: { $regex: req.params.name, $options: "i" },
    });
    if (!product) {
      return res.status(400).json({ msg: "No products for this query." });
    }

    res.json({ product });
    console.log(product);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

//* get trending products
productRouter.get("/api/product/trending-products", auth, async (req, res) => {
  try {
    const product = await Product.find({});
    const products = product.sort((a, b) => {
      let aSum = 0;
      let bSum = 0;

      for (let i = 0; i < a.reviews.length; i++) {
        aSum += a.reviews[i].stars;
      }
      for (let i = 0; i < b.reviews.length; i++) {
        bSum += b.reviews[i].stars;
      }

      return aSum < bSum ? 1 : -1;
    });

    res.json({ products });
    console.log(products);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


//* get products
productRouter.get("/api/product/get-products", auth, async (req, res) => {
  try {
    const products = await Product.find({});
    
    res.json({ products });
    console.log(products);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


//* Add to wishlist
productRouter.post('/api/product/add-to-wishlist', auth, async (req, res) => {

  try {
    const {userId, productId} = req.body;
    const user = await User.findById(userId);
    if (!user) {
       res.status(400).json({msg: 'User not found'})
    }

    const product = await Product.findById(productId);
    if (!product) {
      res.status(400).json({msg: 'Product not found'})
    }

    user.wishlist.push(product._id);
    await user.save();

    console.log('Product added to wishlist');
    res.json({ products });
    console.log(products);
 } catch (error) {
    console.error(error);
 }

});

module.exports = productRouter;
