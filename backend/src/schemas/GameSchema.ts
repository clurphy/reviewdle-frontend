import * as z from "zod";
import { MovieSchema } from "./MovieSchema";
import { ReviewSchema } from "./ReviewSchema";



export const GameSchema = z.object({
    id: z.number(),
    date: z.coerce.date(),
    reviews: z.array(ReviewSchema).length(5),
    createdAt: z.date().optional(),
    updatedAt: z.date().optional(),
});
export type Game = z.infer<typeof GameSchema>

export const GameCreateSchema = GameSchema.omit({
    id: true,
    createdAt: true,
    updatedAt: true,
}).extend({
    movieId: z.number()
});
export type GameCreate = z.infer<typeof GameCreateSchema>

export const GameResponseSchema = GameSchema.extend({
    movie: MovieSchema
})
export type GameResponse = z.infer<typeof GameResponseSchema>


export const GameListResponseSchema = z.array(
    GameSchema.omit({ createdAt: true, updatedAt: true, reviews: true })
  );
export type GameListResponse = z.infer<typeof GameListResponseSchema>