import { Request, Response } from "express";
import UserModel from "../schemas/user";
import jwt from "jsonwebtoken";
var bcrypt = require('bcryptjs');
require('dotenv').config()
const env = process.env
const secret = env.SECRET!

export async function createUser(req: Request, res: Response) {
    if (await UserModel.findOne({ username: req.body.username }) || await UserModel.findOne({ email: req.body.email })) {
        res.status(505).json({
            status: false,
            message: "Username or Email already exists!"
        });
        console.log('here')
        return;
    }
    console.log(req.body.password)
    const encrypted_pass = await bcrypt.hash(req.body.password.toString(), 10);
    req.body.password = encrypted_pass;
    let data = new UserModel(req.body);
    try {
        data.save();
        const tokenData = { "_id": data._id, "email": data.email, "username": data.username, "accounttype": data.accounttype }
        const token = jwt.sign(tokenData, secret, { expiresIn: '1h' });
        res.status(200).json({ status: true, token });
    } catch (e: any) {
        res.status(400).json({
            status: false,
            message: e.message
        });
    }
}

export async function getUser(req: Request, res: Response) {
    try {
        var { username, password, accounttype } = req.query;
        password = password ? password : "";
        if (!username || !password) {
            return res.status(400).json({ error: 'no username or password' });
        }
        const user = await UserModel.findOne({ username, accounttype });

        if (user && await bcrypt.compare(password.toString(), user.password)) {
            const tokenData = { "_id": user._id, "username": user.username, "email": user.email, "accounttype": user.accounttype }
            const token = jwt.sign(tokenData, secret, { expiresIn: '1h' });
            res.status(200).json({ status: true, token });
        }
        else {
            res.status(404).json({ error: 'User not found' });
        }
    } catch (e: any) {
        res.status(500).json({ error: e.message });
    }
}