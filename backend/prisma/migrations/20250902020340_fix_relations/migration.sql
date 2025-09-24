/*
  Warnings:

  - You are about to drop the column `movie_id` on the `reviews` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "public"."reviews" DROP CONSTRAINT "reviews_movie_id_fkey";

-- AlterTable
ALTER TABLE "public"."reviews" DROP COLUMN "movie_id";

-- AddForeignKey
ALTER TABLE "public"."games" ADD CONSTRAINT "games_movie_id_fkey" FOREIGN KEY ("movie_id") REFERENCES "public"."movies"("id") ON DELETE SET NULL ON UPDATE CASCADE;
