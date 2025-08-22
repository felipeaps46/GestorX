import express from "express";
import { userController } from "./container";

const router = express.Router()

router.get('/', userController.index)

router.get('/user')


export default router