import { IUserRepository } from "../repositories/UserRepository";

export class UserService {
    constructor(private userRepository: IUserRepository) { }


}