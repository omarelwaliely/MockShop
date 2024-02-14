import express from "express";
import mongoose from "mongoose";
import productRoute from "./routes/product.router"
import userRoute from "./routes/user.router"

require('dotenv').config()
const env = process.env
//questions is this a good practice or not (putting exclamation points since im sure of the env variables), dotenv?
//add headers, middleware to verify, find by id not username

async function connectToDatabase() {
    try {
        await mongoose.connect(env.MONGOCONNECT!, {
        });
        console.log("Connected to mongoose");
    } catch (error) {
        console.error("Error connecting to mongoose:", error);
        throw error;
    }
}

function startServer() {
    const app = express();
    app.use(express.json());
    app.use(express.urlencoded({ extended: true }));
    app.use(productRoute);
    app.use(userRoute);
    app.listen(env.PORT, () => {
        console.log("Connected to server on port " + env.PORT);
    });
}

connectToDatabase().then(startServer);