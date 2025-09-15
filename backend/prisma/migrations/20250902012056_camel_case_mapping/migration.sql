/*
  Warnings:

  - You are about to drop the `_genresTomovies` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "public"."_genresTomovies" DROP CONSTRAINT "_genresTomovies_A_fkey";

-- DropForeignKey
ALTER TABLE "public"."_genresTomovies" DROP CONSTRAINT "_genresTomovies_B_fkey";

-- DropTable
DROP TABLE "public"."_genresTomovies";

-- CreateTable
CREATE TABLE "public"."_GenreToMovie" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_GenreToMovie_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE INDEX "_GenreToMovie_B_index" ON "public"."_GenreToMovie"("B");

-- AddForeignKey
ALTER TABLE "public"."_GenreToMovie" ADD CONSTRAINT "_GenreToMovie_A_fkey" FOREIGN KEY ("A") REFERENCES "public"."genres"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."_GenreToMovie" ADD CONSTRAINT "_GenreToMovie_B_fkey" FOREIGN KEY ("B") REFERENCES "public"."movies"("id") ON DELETE CASCADE ON UPDATE CASCADE;
