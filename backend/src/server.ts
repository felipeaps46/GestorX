import dotenv from 'dotenv'
dotenv.config()

import express from "express";
import router from "./router.js";
import postgres from 'postgres'

const connectionString = process.env.DATABASE_URL

if (!connectionString) {
    throw new Error("DATABASE_URL is not defined in .env file");
}

const sql = postgres(connectionString)

const app = express()

app.use(express.json())
app.use('/api', router)

const PORT = process.env.PORT || 3000
app.listen(PORT, () => console.log(`Servidor Iniciado em http://localhost:${PORT}`))

export default sql