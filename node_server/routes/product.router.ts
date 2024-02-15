import express from "express";
import * as controller from "../controllers/product.controller";
import * as service from "../services/product.service"
const productRouter = express.Router();

productRouter.post("/api/add_product", service.verifyTokenVendor, controller.addProduct)
productRouter.delete("/api/delete_product", service.verifyTokenVendor, controller.deleteProduct)
productRouter.get("/api/get_all_products", service.verifyTokenCustomer, controller.getAllProducts)
productRouter.get("/api/get_product", service.verifyTokenAny, controller.getProduct)
productRouter.get("/api/get_products_of", service.verifyTokenVendor, controller.getProductsOf)
productRouter.put("/api/update_product", service.verifyTokenVendor, controller.updateProduct)
export default productRouter;