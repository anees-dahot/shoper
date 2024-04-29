const express = require("express");
const authrouter = require("./routes/auth");
const mongoose = require("mongoose");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");
const app = express();
const PORT = 3000;

// const db =
//   "mongodb+srv://anees:anees@cluster0.s9pe4rq.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";
app.use(express.json());
app.use(authrouter);
app.use(adminRouter);
app.use(productRouter);

mongoose
  .connect(
    "mongodb://anees:anees@ac-746qcat-shard-00-00.s9pe4rq.mongodb.net:27017,ac-746qcat-shard-00-01.s9pe4rq.mongodb.net:27017,ac-746qcat-shard-00-02.s9pe4rq.mongodb.net:27017/?ssl=true&replicaSet=atlas-x1f788-shard-0&authSource=admin&retryWrites=true&w=majority&appName=Cluster0"
  )
  .then(() => console.log("MongoDB connected successfully!"))
  .catch((err) => console.error(err));

app.get("/send", (req, res) => {
  console.log(req.body);
  res.status(200).json({ no: "anees" });
});

app.listen(PORT, "0.0.0.0", () => {
  console.log("connecting to port " + PORT);
});
