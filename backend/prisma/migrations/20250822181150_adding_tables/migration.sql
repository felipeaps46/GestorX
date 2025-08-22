/*
  Warnings:

  - The values [User,Ceo,Admin] on the enum `Roles` will be removed. If these variants are still used in the database, this will fail.
  - The `role` column on the `User` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- CreateEnum
CREATE TYPE "public"."Types" AS ENUM ('Services', 'Products', 'Clients', 'Suppliers', 'Carriers', 'Buys', 'Sells', 'Orders', 'Receipts', 'Expenses');

-- CreateEnum
CREATE TYPE "public"."Permissions" AS ENUM ('READ', 'WRITE', 'OWNER');

-- AlterEnum
BEGIN;
CREATE TYPE "public"."Roles_new" AS ENUM ('USER', 'CEO', 'ADMIN');
ALTER TABLE "public"."User" ALTER COLUMN "role" TYPE "public"."Roles_new" USING ("role"::text::"public"."Roles_new");
ALTER TYPE "public"."Roles" RENAME TO "Roles_old";
ALTER TYPE "public"."Roles_new" RENAME TO "Roles";
DROP TYPE "public"."Roles_old";
COMMIT;

-- AlterTable
ALTER TABLE "public"."User" DROP COLUMN "role",
ADD COLUMN     "role" "public"."Roles" NOT NULL DEFAULT 'USER';

-- CreateTable
CREATE TABLE "public"."Notifications" (
    "id" SERIAL NOT NULL,
    "title" VARCHAR(50),
    "desc" TEXT NOT NULL,
    "read" BOOLEAN NOT NULL DEFAULT false,
    "type" "public"."Types" NOT NULL,
    "user_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Notifications_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Ceo" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "enterpriseId" INTEGER NOT NULL,

    CONSTRAINT "Ceo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Admin" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "Admin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."AdminToEnterprise" (
    "permissions" "public"."Permissions"[] DEFAULT ARRAY[]::"public"."Permissions"[],
    "admin_id" INTEGER NOT NULL,
    "enterprise_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "AdminToEnterprise_pkey" PRIMARY KEY ("admin_id","enterprise_id")
);

-- CreateTable
CREATE TABLE "public"."Entity" (
    "id" SERIAL NOT NULL,

    CONSTRAINT "Entity_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Supplier" (
    "id" SERIAL NOT NULL,

    CONSTRAINT "Supplier_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Carrier" (
    "id" SERIAL NOT NULL,

    CONSTRAINT "Carrier_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Client" (
    "id" SERIAL NOT NULL,

    CONSTRAINT "Client_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Sells" (
    "id" SERIAL NOT NULL,

    CONSTRAINT "Sells_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Buys" (
    "id" SERIAL NOT NULL,

    CONSTRAINT "Buys_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Orders" (
    "id" SERIAL NOT NULL,

    CONSTRAINT "Orders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Service" (
    "id" SERIAL NOT NULL,

    CONSTRAINT "Service_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Product" (
    "id" SERIAL NOT NULL,

    CONSTRAINT "Product_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Finances" (
    "id" SERIAL NOT NULL,

    CONSTRAINT "Finances_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Receipt" (
    "id" SERIAL NOT NULL,

    CONSTRAINT "Receipt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Expense" (
    "id" SERIAL NOT NULL,

    CONSTRAINT "Expense_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Ceo_user_id_key" ON "public"."Ceo"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "Ceo_enterpriseId_key" ON "public"."Ceo"("enterpriseId");

-- CreateIndex
CREATE UNIQUE INDEX "Admin_user_id_key" ON "public"."Admin"("user_id");

-- AddForeignKey
ALTER TABLE "public"."Notifications" ADD CONSTRAINT "Notifications_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Ceo" ADD CONSTRAINT "Ceo_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Ceo" ADD CONSTRAINT "Ceo_enterpriseId_fkey" FOREIGN KEY ("enterpriseId") REFERENCES "public"."Enterprise"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Admin" ADD CONSTRAINT "Admin_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."AdminToEnterprise" ADD CONSTRAINT "AdminToEnterprise_admin_id_fkey" FOREIGN KEY ("admin_id") REFERENCES "public"."Admin"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."AdminToEnterprise" ADD CONSTRAINT "AdminToEnterprise_enterprise_id_fkey" FOREIGN KEY ("enterprise_id") REFERENCES "public"."Enterprise"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
