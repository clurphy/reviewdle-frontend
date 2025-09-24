import { ZodObject } from 'zod';

export default interface RequestValidators {
    params?: ZodObject
    body?: ZodObject
    query?: ZodObject
}