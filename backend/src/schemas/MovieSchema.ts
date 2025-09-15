import * as z from "zod";

export const MovieSchema = z.object({
    id: z.number(),
    title: z.string(),
    originalTitle: z.string(),
    releaseDate: z.date(),
    originalLanguage: z.string(),
    poster: z.string(),
    genres: z.array(z.string())
})
