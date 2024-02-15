import express from "express";
import * as controller from "../controllers/user.controller";
const userRouter = express.Router();

userRouter.post("/api/create_user", controller.createUser)
userRouter.get("/api/get_user", controller.getUser)

export default userRouter