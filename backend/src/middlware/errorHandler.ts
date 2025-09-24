import { Request, Response, NextFunction } from "express";
import { prismaError } from "prisma-better-errors";
import { ZodError } from "zod";
export const errorHandler = (
  err: any,
  req: Request,
  res: Response,
  next: NextFunction
) => {
  console.log(JSON.stringify(err))
  if (err instanceof ZodError) {
    return res.status(400).json({
      error: {
        type: "validation_error",
        message: "Invalid input",
        details: err.flatten()
      }
    })
  }
  if (err instanceof prismaError) {
    res.status(err.statusCode).json({
      title: err.title,
      message: err.message,
      metaData: err.metaData,
    });
  }

  res.status(err.status || 500).json({ message: err.message || "Server error" })
}