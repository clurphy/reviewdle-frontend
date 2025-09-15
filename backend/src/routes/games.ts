import express from 'express';
import prisma from '../config/db';
import * as gameController from "../controllers/gameController";
import { validateRequest } from '../middlware/requestValidation';
import { GameCreateSchema } from '../schemas/GameSchema';


const router = express.Router();

//https://dev.to/moibra/best-practices-for-structuring-an-expressjs-project-148i saving this for later
router.get("/", gameController.getGames)

router.get("/:id", gameController.getGame)
router.post("/", validateRequest({body: GameCreateSchema}), gameController.createGame);

router.patch("/:id", validateRequest({body: GameCreateSchema}), gameController.udpateGame);

router.delete("/:id", gameController.deleteGame);


export default router;
