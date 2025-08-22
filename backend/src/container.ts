import { UserController } from "./controllers/UserController"
import { UserService } from "./services/UserService"
import { UserPrismaRepository } from "./repositories/prisma/UserPrismaRepository"

//* USERS

const userRepository = new UserPrismaRepository()
const userService = new UserService(userRepository)

//* CONTROLLERS

export const userController = new UserController(userService)