import { Prisma, Review } from "@prisma/client";
import prisma from "../config/db";
import { prismaError } from "prisma-better-errors";

interface GameFilter {
    from?: string;
    to?: string;
}

export async function createGame(data: any) {
    {
        try {
        
            const game = await prisma.game.create({
                data: {
                    name: "reviewdle",
                    date: new Date(data.date),
                    movieId: data.movieId,
                    reviews: {
                        create: data.reviews.map((r: Review) => ({
                            reviewText: r.reviewText,
                            hintNumber: r.hintNumber,
                        }))
                    }
                }
            })
            return (game)
        }
        catch (err: any) {
            console.error(err);
            throw new prismaError(err)
        }
    }
}

export async function updateGame(data: any, id: number) {
    
    try {
        const game = await prisma.game.update({
            where: { id },
            data: {
              name: data.name,
              date: new Date(data.date),
              movieId: data.movieId,
              reviews: {
                deleteMany: {},
                create: data.reviews.map((r: Review) => ({
                  reviewText: r.reviewText,
                  hintNumber: r.hintNumber,
                }))
              },
            },
            include: { reviews: true }, 
          });
        return game
    }
    catch (err: any) {
        console.log("this is so sad., err : " + err)
        throw new prismaError(err)
    }
}

export async function deleteGame(id: number) {
    try {
        const game = await prisma.game.delete({
            where: { id }
        })
        return game
    }
    catch (err) {
        console.error(err);
    }
}


export async function getGames(filter: GameFilter) {

    const dateFilter: { gt?: Date; lt?: Date } = {};
    if (filter.from) dateFilter.gt = new Date(filter.from);
    if (filter.to) dateFilter.lt = new Date(filter.to);
    try {
        const games = await prisma.game.findMany({
            select: {
                id: true,
                date: true
            },
            where: dateFilter.gt || dateFilter.lt ? { date: dateFilter } : {},
            orderBy: { date: "asc" },
            take: 50
        });
        return games
    }
    catch (err: any) {
        console.log(err.details)
        throw new Error("Error occured " + err.details)
    }
}

export async function getGame(id: number) {
    try {
        const game = await prisma.game.findUniqueOrThrow({
            where: { id },
            include: {
                reviews: true,
                movie: {
                    include: {
                        genres: true
                    }
                }
            },
        });
        const genreNames = game.movie?.genres.map((genre) => genre.name);
        return {
            ...game,
            movie: {
                ...game.movie,
                genres: genreNames
            }
        };
    } catch (err) {
        if (err instanceof Prisma.PrismaClientKnownRequestError && err.code === "P2025") {
            throw new Error(`Game with ID ${id} not found`);
        }
        throw new Error("Database error");
    }
}


