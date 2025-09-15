import express from "express";
import gamesRouter from "./routes/games";
import movieRouter from "./routes/movies";

import cors from 'cors';
import { errorHandler } from "./middlware/errorHandler";

const app = express();

app.get("/", (req, res) => {
    console.log("test")
    res.status(200).send()
})

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cors({
    origin: ["http://localhost:3000", "http://localhost:5173"], // add more here
    methods: ["GET", "POST", "PUT", "DELETE", "PATCH"],
    credentials: true
  }));  
app.use('/games', gamesRouter)
app.use('/movies', movieRouter)
app.use(errorHandler)

app.listen(3005)