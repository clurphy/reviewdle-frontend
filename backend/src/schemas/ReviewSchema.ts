import * as z from "zod";

export const ReviewSchema = z.object({
    hintNumber: z.number(),
    reviewLink: z.string().nullable().optional(),
    reviewText: z.string(),
    reviewAuthor: z.string().optional(),
    reviewSuggester: z.string().optional()
})

