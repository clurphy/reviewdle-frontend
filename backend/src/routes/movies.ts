import express, { Request, Response } from 'express';
import prisma from '../config/db';
import { getMoviesByTitle } from '../controllers/movieController';


const router = express.Router();




router.get("/search", getMoviesByTitle)



export default router;
