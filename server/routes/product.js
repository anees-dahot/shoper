const express = require("express");
const productRouter = express.Router();
const admin = require("../middlewares/admin");
const auth = require("../middlewares/auth");
const Product = require("../model/product");
const User = require("../model/user");
const Cart = require("../model/cart");
const Order = require("../model/order");

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
productRouter.post("/api/product/add-to-wishlist", auth, async (req, res) => {
  try {
    const { userId, productId } = req.body;
    const user = await User.findById(userId);
    if (!user) {
      res.status(400).json({ msg: "User not found" });
    }

    const product = await Product.findById(productId);
    if (!product) {
      res.status(400).json({ msg: "Product not found" });
    }

    user.wishlist.push(product._id);
    await user.save();

    console.log("Product added to wishlist");
    res.status(400).json({ user });
    console.log(user.wishlist);
  } catch (error) {
    console.error(error);
  }
});

//* Remove product from wishlist
productRouter.post(
  "/api/product/remove-from-wishlist",
  auth,
  async (req, res) => {
    try {
      const { userId, productId } = req.body;

      const user = await User.findById(userId);
      if (!user) {
        return res.status(400).json({ msg: "User not found" });
      }

      const productToRemoveIndex = user.wishlist.findIndex(
        (wishlistProduct) => wishlistProduct.toString() === productId
      );

      if (productToRemoveIndex === -1) {
        return res.status(400).json({ msg: "Product not found in wishlist" });
      }

      user.wishlist.splice(productToRemoveIndex, 1); // Remove the product
      await user.save();

      console.log("Product removed from wishlist");
      console.log(user.wishlist);
      res.status(200).json({ msg: "Product removed successfully" });
    } catch (error) {
      console.error(error);
      res.status(500).json({ msg: "Server Error" });
    }
  }
);

//* Check if product is in wishlist or not
productRouter.get("/api/product/is-in-wishlist", auth, async (req, res) => {
  try {
    const { userId, productId } = req.query; // Use query parameters

    const user = await User.findById(userId);
    if (!user) {
      return res.status(400).json({ msg: "User not found" });
    }

    const isInWishlist = user.wishlist.some(
      (wishlistProduct) => wishlistProduct.toString() === productId
    );

    console.log(`Product ${productId} is in wishlist: ${isInWishlist}`);
    res.status(200).json({ isInWishlist });
  } catch (error) {
    console.error(error);
    res.status(500).json({ msg: "Server Error" });
  }
});

productRouter.get(
  "/api/product/get-wishlist-products/:userId",
  auth,
  async (req, res) => {
    try {
      const userId = req.params.userId;
      const user = await User.findById(userId).populate("wishlist").exec();

      if (!user) {
        return res.status(404).send({ msg: "User not found" });
      }

      const wishlistProducts = user.wishlist;

      res.status(200).json({ wishlistProducts });
      console.log(wishlistProducts);
    } catch (error) {
      res.status(500).json({ message: "Server error", error });
      console.error("Error fetching wishlist:", error);
    }
  }
);

//* Add product to cart
productRouter.post("/api/product/add-to-cart", auth, async (req, res) => {
  try {
    const {
      sellerId,
      buyerId,
      productId,
      productName,
      description,
      imageUrl,
      price,
      quantity,
      color,
      size,
    } = req.body;

    let cartItem = await Cart.findOne({ buyerId, productId });

    console.log("Existing cart item:", cartItem);

    if (cartItem) {
      // If the item exists, increment the quantity by the amount in the request
      cartItem.quantity += quantity;
      await cartItem.save();
      console.log("Updated cart item:", cartItem);
    } else {
      // If the item doesn't exist, create a new cart item
      let cartItem = new Cart({
        sellerId,
        buyerId,
        productName,
        productId,
        description,
        imageUrl,
        price,
        quantity,
        color,
        size,
      });
      await cartItem.save();
    }

    res.status(200).json({ msg: "Added to cart successfully", cartItem });
    console.log(cartItem);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//* Delete product from cart
productRouter.post(
  "/api/product/delete-cart-item/:productId",
  async (req, res) => {
    try {
      const productId = req.params.productId;

      const deletedItem = await Cart.findOneAndDelete({
        productId: productId,
      });

      if (deletedItem.length == 0) {
        return res.status(400).json({ msg: "Cart is empty" });
      }

      res.status(200).json({ message: "Removed from cart successfully" });
      console.log("Removed from cart successfully");
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  }
);

//* Get add to cart  items
productRouter.get(
  "/api/product/get-addtocart-products/:userId",
  async (req, res) => {
    try {
      let user = req.params.userId;

      let cartItem = await Cart.find({ buyerId: user });

      if (cartItem.length == 0) {
        // If the item exists, increment the quantity
        return res.status(400).json({ msg: "Cart is empty" });
      }

      res.status(200).json({ cartItem });
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

//* Create a new order
productRouter.post("/api/orders", auth, async (req, res) => {
  try {
    const {
      sellerId,
      buyerId,
      items,
      shippingAddress,
      paymentMethod,
      totalAmount,
    } = req.body;

    const newOrder = new Order({
      sellerId: sellerId,
      buyerId: buyerId,
      items: items,
      shippingAddress: shippingAddress,
      paymentMethod: paymentMethod,
      totalAmount: totalAmount,
      status: "Pending",
    });

    const order = await newOrder.save();

    // Clear the user's cart after placing the order
    await Cart.deleteMany({ buyerId: buyerId });

    res.status(200).json({ message: "Order placed successfully", order });
    console.log(order);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// *Get user's orders for buyer
productRouter.get("/api/orders/buyer/:userId", auth, async (req, res) => {
  try {
    const userId = req.params.userId;
    const orders = await Order.find({ buyerId: userId }).sort({
      createdAt: -1,
    });

    res.status(200).json({ orders });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// *Get user's orders for seller
productRouter.get("/api/orders/seller/:sellerId", auth, async (req, res) => {
  try {
    const sellerId = req.params.sellerId;
    const orders = await Order.find({ sellerId }).sort({ createdAt: -1 });

    res.status(200).json({ orders });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

//* delete orders
productRouter.post("/api/orders/delete/:id", auth, async (req, res) => {
  try {
    const id = req.params.id;
    await Order.findOneAndDelete({ _id: id });

    res.status(200).json({ msg: "deleted succesfully" });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = productRouter;
