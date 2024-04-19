const express = require("express");
const User = require("../model/user");
const bcryptjs = require("bcryptjs");
const authRouter = express.Router();
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");

// SIGN UP
authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body;

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists!" });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);

    let user = new User({
      email,
      password: hashedPassword,
      name,
    });
    user = await user.save();
    res.json(user);
    console.log(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Sign In Route
// Exercise
authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
      return res
        .status(400)
        .json({ msg: "User with this email does not exist!" });
    }

    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect password." });
    }

    const token = jwt.sign({ id: user._id }, "passwordKey");
    res.json({ token, ...user._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.post("/tokenIsValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) return res.json(false);
    const verified = jwt.verify(token, "passwordKey");
    if (!verified) return res.json(false);

    const user = await User.findById(verified.id);
    if (!user) return res.json(false);
    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// get user data
authRouter.get("/", auth, async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
});

module.exports = authRouter;





























// const express = require("express");
// const bcrypt = require("bcryptjs");
// const User = require("../model/user.js");
// const jwt = require("jsonwebtoken");
// const auth = require("../middlewares/auth.js");
// const authrouter = express.Router();

// authrouter.post("/api/signup", async (req, res) => {
//   try {
//     // we are getting name, email and password from the body of the request
//     const { name, email, password } = req.body;
//     // check if user already exists or not
//     const exisitingUser = await User.findOne({ email });
//     if (exisitingUser) {
//       return res.status(400).json({ msg: "User already exists" });
//     }

//     //assigning values to the model of user
//     let encryptedPass = await bcrypt.hash(password, 8);

//     let user = new User({
//       name,
//       email,
//       password: encryptedPass,
//     });

//     //* save uswer data to mongoDB

//     user = await user.save();
//     res.json(user);
//     console.log(user);
//   } catch (e) {
//     res.status(500).json({ error: e.message });
//   }
// });

// //* user signin

// authrouter.post("/api/signin", async (req, res) => {
//   try {
//     const { email, password } = req.body;

//     //* check if user exists or not
//     const user = await User.findOne({ email });
//     if (!user) {
//       res.status(400).json({ msg: "User with this email doesn't exist" });
//     }

//     //* match password with hashed password

//     const passMatches = bcrypt.compare(password, user.password);

//     if (!passMatches) {
//       res.status(400).json({ msg: "Incorect password!" });
//     }

//     const token = jwt.sign({ id: user._id }, "passwordKey");
//     res.json({ token, ...user._doc });
//   } catch (e) {
//     res.status(500).json({ error: e.message });
//   }
// });

// //* check token validation

// authrouter.post("/isTokenValid", async (req, res) => {
//   try {
//     const token = req.header("x-auth-token");

//     if (!token) return res.json(false);

//     const verify = jwt.verify(token, "passwordKey");
//     if (!verify) return res.json(false);

//     //* check if user exists or not
//     const user = await User.findById(verify.id);
//     if (!user) return res.json(false);

//     res.json(true);

//   } catch (e) {
//     res.status(500).json({ error: e.message });
//   }
// });



// authrouter.get('/', auth, async (req, res) =>{

//   const user = User.findById(req.id);
//   res.json({...user._doc, token: req.token});


// });

// module.exports = authrouter;
