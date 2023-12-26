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
    app.get("/api/get_user", async (req: Request, res: Response) => {
        try {
            const { username, password, accounttype } = req.query;
            console.log(req.query);
            if (!username || !password) {
                return res.status(400).json({ error: 'no username or password' });
            }
            const user = await UserModel.findOne({ username, password, accounttype });
            if (user) {
                res.status(200).json(user);
            } else {
                res.status(404).json({ error: 'User not found' });
            }
        } catch (e: any) {
            res.status(500).json({ error: e.message });
        }
    });

    app.listen(2000, () => {
        console.log("Connected to server on port 2000");
    });
}

connectToDatabase().then(startServer);