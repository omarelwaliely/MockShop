import express, { Request, Response } from "express";
import mongoose from "mongoose";
import UserModel from "./schemas/user";

async function connectToDatabase() {
    try {
        await mongoose.connect("mongodb+srv://omarelwaliely:omaradmin123@cluster0.ow7tz0m.mongodb.net/mockapp", {
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

    app.post("/api/create_user", async (req: Request, res: Response) => {
        console.log("Request Body:", req.body);
        let data = new UserModel(req.body);

        try {
            let dataToStore = await data.save();
            res.status(200).json(dataToStore);
        } catch (e: any) {
            res.status(400).json({
                status: e.message,
            });
        }
    });

    app.listen(2000, () => {
        console.log("Connected to server on port 2000");
    });
}

connectToDatabase().then(startServer);