import { Request, Response, NextFunction } from "express";
import RequestValidators from "../interfaces/RequestValidators";
import { ZodError } from "zod";

export function validateRequest(validators: RequestValidators) {
    return async (req: Request, res: Response, next: NextFunction) => {
      try {
        if (validators.body) {
          req.body = await validators.body.parseAsync(req.body);
        }
        next();
      } catch (error) {
        if (error instanceof ZodError) {
          res.status(422);
        }
        next(error);
      }
    };
  }
  