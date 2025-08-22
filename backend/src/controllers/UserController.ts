import { Handler } from "express"
import { UserService } from "../services/UserService";


export class UserController {
    constructor(private userService: UserService) {}

    index: Handler = (req, res) => {
        res.json({ message: "Tela inicial" });
    };

   
}