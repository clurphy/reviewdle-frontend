import { Request, Response, NextFunction } from "express";
import { searchMovies } from "../services/movieService";


export async function getMoviesByTitle(req: Request, res : Response){
    const {title} = req.query;
    if(!title) return res.status(400).json({"message": "missing query parameter title"})
    try {
       const movies = await searchMovies(title as string)
       res.json(movies)
    }
    catch(err) {
        console.error(err);
    }
}