import { Request, Response, NextFunction } from 'express';
import UserModel from '../schemas/user'
import jwt, { JwtPayload } from 'jsonwebtoken';
require('dotenv').config()
const env = process.env

export const verifyTokenAny = async (req: Request, res: Response, next: NextFunction) => {
    const token = req.header('Authorization');

    if (!token) {
        return res.status(401).json({ error: 'Unauthorized: No token provided' });
    }

    try {
        jwt.verify(token, env.SECRET!);
        next();
    } catch (err) {
        console.log(err)
        res.status(401).json({ error: 'Unauthorized: Invalid token' });
    }
};

export const verifyTokenVendor = async (req: Request, res: Response, next: NextFunction) => {
    const token = req.header('Authorization');

    if (!token) {
        return res.status(401).json({ error: 'Unauthorized: No token provided' });
    }

    try {
        const decodedToken = jwt.verify(token, env.SECRET!) as JwtPayload;
        if (decodedToken['accounttype'] == 'V') {
            const user = await UserModel.findOne({ "_id": decodedToken['_id'] });
            if (!user) {
                throw ("Not Found")
            }
        }
        else {
            throw ("Incorrect account type")
        }
        next();
    } catch (err) {
        console.log(err)
        res.status(401).json({ error: 'Unauthorized: Invalid token' });
    }
};

export const verifyTokenCustomer = async (req: Request, res: Response, next: NextFunction) => {
    const token = req.header('Authorization');
    if (!token) {
        return res.status(401).json({ error: 'Unauthorized: No token provided' });
    }

    try {
        const decodedToken = jwt.verify(token, env.SECRET!) as JwtPayload;
        if (decodedToken['accounttype'] == 'C') {
            const user = await UserModel.findOne({ "_id": decodedToken['_id'] });
            if (!user) {
                throw ("Not Found")
            }
        }
        else {
            throw ("Incorrect account type")
        }
        next();
    } catch (err) {
        console.log(err)
        res.status(401).json({ error: 'Unauthorized: Invalid token' });
    }
};