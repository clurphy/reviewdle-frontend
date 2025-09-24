/*
  Warnings:

  - You are about to drop the column `author` on the `reviews` table. All the data in the column will be lost.
  - You are about to drop the column `suggested_by` on the `reviews` table. All the data in the column will be lost.
  - You are about to drop the `movie_genres` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `oauth_users` table. If the table is not empty, all the data it contains will be lost.
  - Made the column `movie_id` on table `reviews` required. This step will fail if there are existing NULL values in that column.
  - Made the column `game_id` on table `reviews` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "public"."movie_genres" DROP CONSTRAINT "movie_genres_genre_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."movie_genres" DROP CONSTRAINT "movie_genres_movie_id_fkey";

-- AlterTable
ALTER TABLE "public"."reviews" DROP COLUMN "author",
DROP COLUMN "suggested_by",
ALTER COLUMN "movie_id" SET NOT NULL,
ALTER COLUMN "game_id" SET NOT NULL;

-- DropTable
DROP TABLE "public"."movie_genres";

-- DropTable
DROP TABLE "public"."oauth_users";

-- CreateTable
CREATE TABLE "public"."_genresTomovies" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_genresTomovies_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE INDEX "_genresTomovies_B_index" ON "public"."_genresTomovies"("B");

-- AddForeignKey
ALTER TABLE "public"."_genresTomovies" ADD CONSTRAINT "_genresTomovies_A_fkey" FOREIGN KEY ("A") REFERENCES "public"."genres"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."_genresTomovies" ADD CONSTRAINT "_genresTomovies_B_fkey" FOREIGN KEY ("B") REFERENCES "public"."movies"("id") ON DELETE CASCADE ON UPDATE CASCADE;
