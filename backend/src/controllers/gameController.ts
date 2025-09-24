
import { ZodError } from "zod";
import * as gameService from "../services/gameService";
import { Request, Response, NextFunction } from "express";
import { GameCreateSchema, GameListResponse, GameListResponseSchema, GameResponse } from "../schemas/GameSchema";
import { GameResponseSchema, } from "../schemas/GameSchema";



export async function createGame(req: Request, res: Response, next: NextFunction) {
    try {
        const game = await gameService.createGame(req.body);
        res.json(game);
    } catch (err) {
        next(err);
    }
}

export async function getGame(req : Request, res : Response<GameResponse>, next: NextFunction){
    const id = req.params.id
    try {
        const game = await gameService.getGame(Number(id))
        console.log(game)
        const parsedGame = GameResponseSchema.parse(game)
        res.json(parsedGame)
    }
    catch(err: any) {
        next(err);
    }
}

export async function udpateGame(req: Request, res: Response, next: NextFunction) {
    const id = req.params.id
    try {
        const game = await gameService.updateGame(req.body, Number(id) );
        res.json(game);
    } catch (err: any) {
        next(err);
    }
}

export async function deleteGame(req: Request, res: Response, next: NextFunction) {
    const id = req.params.id
    try {
        const game = await gameService.deleteGame(Number(id));
        res.json(game);
    } catch (err : any) {
        res.status(500).send("Internal Server Error : " + err.message)
    }
}


export async function getGames(req: Request, res: Response<GameListResponse>, next: NextFunction) {
    try {
        const games =  await gameService.getGames(req.query)
        const parsedGames = GameListResponseSchema.parse(games)
        console.log("games: " +JSON.stringify(games))
        res.json(parsedGames)
    }
    catch (err) {
        next(err)
    }
}

