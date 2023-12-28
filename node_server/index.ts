import express, { Request, Response } from "express";
import mongoose from "mongoose";
import UserModel from "./schemas/user";
import ProductModel from "./schemas/product";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";

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
    const secret = "H*Jq>NcX8qkZkZA";//im manually putting the key here but typically id store it in env, since env would be pushed to my github for demo purposes ill just manually put it here

    app.use(express.json());
    app.use(express.urlencoded({ extended: true }));

    app.post("/api/create_user", async (req: Request, res: Response) => {
        console.log("Request Body:", req.body);
        const encrypted_pass = await bcrypt.hash(req.body.password.toString(), 10);
        req.body.password = encrypted_pass;
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
            var { username, password, accounttype } = req.query;
            password = password ? password : "";
            if (!username || !password) {
                return res.status(400).json({ error: 'no username or password' });
            }
            const user = await UserModel.findOne({ username, accounttype });

            if (user && await bcrypt.compare(password.toString(), user.password)) {
                const tokenData = { "_id": user._id, "email": user.email, "accounttype": user.accounttype }
                const token = jwt.sign(tokenData, secret, { expiresIn: '1h' });
                res.status(200).json({ status: true, token });
            }
            else {
                res.status(404).json({ error: 'User not found' });
            }
        } catch (e: any) {
            res.status(500).json({ error: e.message });
        }
    });
    app.post("/api/add_product", async (req: Request, res: Response) => {
        let data = new ProductModel(req.body);
        try {
            let dataToStore = await data.save();
            res.status(200).json(dataToStore);
        }
        catch (e: any) {
            res.status(400).json({
                status: e.message,
            })
        }
    })
    app.get("/api/get_all_products", async (req: Request, res: Response) => {
        try {
            const products = await ProductModel.find();
            if (products) {
                res.status(200).json(products);
            } else {
                res.status(404).json({ error: 'No products not found' });
            }
        } catch (e: any) {
            res.status(500).json({ error: e.message });
        }

    })
    app.get("/api/get_products_of", async (req: Request, res: Response) => {
        try {
            var vendorusername = req.query.vendorusername;
            const products = await ProductModel.find({ vendorusername });
            if (products) {
                res.status(200).json(products);
            } else {
                res.status(404).json({ error: 'No products not found' });
            }
        } catch (e: any) {
            res.status(500).json({ error: e.message });
        }

    })
    app.listen(2000, () => {
        console.log("Connected to server on port 2000");
    });
    app.put('/api/update_product', async (req: Request, res: Response) => { //im using put here so you should update the entire product
        try {
            const id = req.query.id;
            var newProduct = await ProductModel.findByIdAndUpdate(id, req.body, { new: true });
            res.send(newProduct)
        }
        catch (e: any) {
            console.log(e.message)
            res.status(500).json({ error: e.message });
        }
    })
    app.delete('/api/delete_product', async (req: Request, res: Response) => { //im using put here so you should update the entire product
        try {
            const id = req.query.id;
            var data = await ProductModel.findByIdAndDelete(id);
            res.json({
                status: "Successfully Deleted"
            })
        }
        catch (e: any) {
            console.log(e.message)
            res.status(500).json({ error: e.message });
        }
    })
}

connectToDatabase().then(startServer);