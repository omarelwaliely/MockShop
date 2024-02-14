import express from "express";
import * as controller from "../controllers/product.controller";
const productRouter = express.Router();

productRouter.post("/api/add_product", controller.addProduct)
productRouter.delete("/api/delete_product", controller.deleteProduct)
productRouter.get("/api/get_all_products", controller.getAllProducts)
productRouter.get("/api/get_product", controller.getProduct)
productRouter.get("/api/get_products_of", controller.getProductsOf)
productRouter.put("/api/update_product", controller.updateProduct)
export default productRouter;