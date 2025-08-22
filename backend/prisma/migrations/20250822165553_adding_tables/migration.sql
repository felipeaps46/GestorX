/*
  Warnings:

  - You are about to drop the `Post` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "public"."Roles" AS ENUM ('User', 'Ceo', 'Admin');

-- DropTable
DROP TABLE "public"."Post";

-- CreateTable
CREATE TABLE "public"."User" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "role" VARCHAR(500) NOT NULL,
    "cpf" VARCHAR(14) NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Enterprise" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "cnpj" VARCHAR(14) NOT NULL,
    "image_url" TEXT,
    "address_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Enterprise_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Phone" (
    "id" SERIAL NOT NULL,
    "phone" TEXT NOT NULL,
    "user_id" INTEGER,
    "enterprise_id" INTEGER,

    CONSTRAINT "Phone_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Address" (
    "id" SERIAL NOT NULL,
    "street" VARCHAR(50) NOT NULL,
    "number" VARCHAR(10) NOT NULL,
    "neighborhood" VARCHAR(50) NOT NULL,
    "city" VARCHAR(50) NOT NULL,
    "state" VARCHAR(50) NOT NULL,
    "cep" VARCHAR(10) NOT NULL,
    "complement" VARCHAR(200),

    CONSTRAINT "Address_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_cpf_key" ON "public"."User"("cpf");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "public"."User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Enterprise_cnpj_key" ON "public"."Enterprise"("cnpj");

-- CreateIndex
CREATE UNIQUE INDEX "Enterprise_address_id_key" ON "public"."Enterprise"("address_id");

-- CreateIndex
CREATE UNIQUE INDEX "Phone_phone_key" ON "public"."Phone"("phone");

-- CreateIndex
CREATE UNIQUE INDEX "Phone_user_id_key" ON "public"."Phone"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "Phone_enterprise_id_key" ON "public"."Phone"("enterprise_id");

-- AddForeignKey
ALTER TABLE "public"."Enterprise" ADD CONSTRAINT "Enterprise_address_id_fkey" FOREIGN KEY ("address_id") REFERENCES "public"."Address"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Phone" ADD CONSTRAINT "Phone_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Phone" ADD CONSTRAINT "Phone_enterprise_id_fkey" FOREIGN KEY ("enterprise_id") REFERENCES "public"."Enterprise"("id") ON DELETE SET NULL ON UPDATE CASCADE;
