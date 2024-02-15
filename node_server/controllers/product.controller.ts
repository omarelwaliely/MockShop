import { Request, Response } from "express";
import ProductModel from "../schemas/product";

export async function addProduct(req: Request, res: Response) {
    let data = new ProductModel(req.body);
    try {
        let dataToStore = await data.save();
        console.log(dataToStore)
        res.status(200).json(dataToStore);
    }
    catch (e: any) {
        res.status(400).json({
            status: e.message,
        })
    }
}
export async function getAllProducts(req: Request, res: Response) {
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
}

export async function getProductsOf(req: Request, res: Response) {
    try {
        var vendorid = req.query.vendorid;
        const products = await ProductModel.find({ "vendorid": vendorid });
        console.log(products)
        if (products) {
            res.status(200).json(products);
        } else {
            res.status(404).json({ error: 'No products found' });
        }
    } catch (e: any) {
        res.status(500).json({ error: e.message });
    }
}

export async function getProduct(req: Request, res: Response) {
    try {
        const id = req.query.id;
        const product = await ProductModel.findById(id);
        console.log(product);
        if (product) {
            res.status(200).json(product);
        }
        else {
            res.status(404).json({ error: 'product not found' });
        }
    } catch (e: any) {
        res.status(500).json({ error: e.message });
    }
}

export async function updateProduct(req: Request, res: Response) {
    try {
        const id = req.query.id;
        var newProduct = await ProductModel.findByIdAndUpdate(id, req.body, { new: true });
        res.send(newProduct)
    }
    catch (e: any) {
        console.log(e.message)
        res.status(500).json({ error: e.message });
    }
}
export async function deleteProduct(req: Request, res: Response) {
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
}