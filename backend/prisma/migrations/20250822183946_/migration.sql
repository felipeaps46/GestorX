/*
  Warnings:

  - A unique constraint covering the columns `[entity_id]` on the table `Carrier` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[entity_id]` on the table `Client` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[email]` on the table `Entity` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[finances_id]` on the table `Expense` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[finances_id]` on the table `Receipt` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[entity_id]` on the table `Supplier` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `entity_id` to the `Carrier` table without a default value. This is not possible if the table is not empty.
  - Added the required column `entity_id` to the `Client` table without a default value. This is not possible if the table is not empty.
  - Added the required column `cpf_cnpj` to the `Entity` table without a default value. This is not possible if the table is not empty.
  - Added the required column `email` to the `Entity` table without a default value. This is not possible if the table is not empty.
  - Added the required column `enterprise_id` to the `Entity` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `Entity` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `Entity` table without a default value. This is not possible if the table is not empty.
  - Added the required column `finances_id` to the `Expense` table without a default value. This is not possible if the table is not empty.
  - Added the required column `desc` to the `Finances` table without a default value. This is not possible if the table is not empty.
  - Added the required column `type` to the `Finances` table without a default value. This is not possible if the table is not empty.
  - Added the required column `value` to the `Finances` table without a default value. This is not possible if the table is not empty.
  - Added the required column `enterprise_id` to the `Product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `Product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `price` to the `Product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `stock` to the `Product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `type` to the `Product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `Product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `finances_id` to the `Receipt` table without a default value. This is not possible if the table is not empty.
  - Added the required column `enterprise_id` to the `Service` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `Service` table without a default value. This is not possible if the table is not empty.
  - Added the required column `price` to the `Service` table without a default value. This is not possible if the table is not empty.
  - Added the required column `type` to the `Service` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `Service` table without a default value. This is not possible if the table is not empty.
  - Added the required column `entity_id` to the `Supplier` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "public"."EntitiesTypes" AS ENUM ('Client', 'Supplier', 'Carrier');

-- CreateEnum
CREATE TYPE "public"."FinancesTypes" AS ENUM ('Receipt', 'Expense');

-- AlterTable
ALTER TABLE "public"."Carrier" ADD COLUMN     "entity_id" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "public"."Client" ADD COLUMN     "entity_id" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "public"."Entity" ADD COLUMN     "cpf_cnpj" VARCHAR(14) NOT NULL,
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "email" TEXT NOT NULL,
ADD COLUMN     "enterprise_id" INTEGER NOT NULL,
ADD COLUMN     "image_url" TEXT,
ADD COLUMN     "name" "public"."EntitiesTypes" NOT NULL,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "public"."Expense" ADD COLUMN     "finances_id" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "public"."Finances" ADD COLUMN     "create_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "desc" TEXT NOT NULL,
ADD COLUMN     "type" "public"."FinancesTypes" NOT NULL,
ADD COLUMN     "value" DECIMAL(10,2) NOT NULL;

-- AlterTable
ALTER TABLE "public"."Product" ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "enterprise_id" INTEGER NOT NULL,
ADD COLUMN     "name" VARCHAR(70) NOT NULL,
ADD COLUMN     "price" DECIMAL(10,2) NOT NULL,
ADD COLUMN     "quantity_min" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "stock" INTEGER NOT NULL,
ADD COLUMN     "type" TEXT NOT NULL,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "public"."Receipt" ADD COLUMN     "finances_id" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "public"."Service" ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "enterprise_id" INTEGER NOT NULL,
ADD COLUMN     "name" VARCHAR(100) NOT NULL,
ADD COLUMN     "price" DECIMAL(10,2) NOT NULL,
ADD COLUMN     "type" TEXT NOT NULL,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "public"."Supplier" ADD COLUMN     "entity_id" INTEGER NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "Carrier_entity_id_key" ON "public"."Carrier"("entity_id");

-- CreateIndex
CREATE UNIQUE INDEX "Client_entity_id_key" ON "public"."Client"("entity_id");

-- CreateIndex
CREATE UNIQUE INDEX "Entity_email_key" ON "public"."Entity"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Expense_finances_id_key" ON "public"."Expense"("finances_id");

-- CreateIndex
CREATE UNIQUE INDEX "Receipt_finances_id_key" ON "public"."Receipt"("finances_id");

-- CreateIndex
CREATE UNIQUE INDEX "Supplier_entity_id_key" ON "public"."Supplier"("entity_id");

-- AddForeignKey
ALTER TABLE "public"."Entity" ADD CONSTRAINT "Entity_enterprise_id_fkey" FOREIGN KEY ("enterprise_id") REFERENCES "public"."Enterprise"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Supplier" ADD CONSTRAINT "Supplier_entity_id_fkey" FOREIGN KEY ("entity_id") REFERENCES "public"."Entity"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Carrier" ADD CONSTRAINT "Carrier_entity_id_fkey" FOREIGN KEY ("entity_id") REFERENCES "public"."Entity"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Client" ADD CONSTRAINT "Client_entity_id_fkey" FOREIGN KEY ("entity_id") REFERENCES "public"."Entity"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Service" ADD CONSTRAINT "Service_enterprise_id_fkey" FOREIGN KEY ("enterprise_id") REFERENCES "public"."Enterprise"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Product" ADD CONSTRAINT "Product_enterprise_id_fkey" FOREIGN KEY ("enterprise_id") REFERENCES "public"."Enterprise"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Receipt" ADD CONSTRAINT "Receipt_finances_id_fkey" FOREIGN KEY ("finances_id") REFERENCES "public"."Finances"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Expense" ADD CONSTRAINT "Expense_finances_id_fkey" FOREIGN KEY ("finances_id") REFERENCES "public"."Finances"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
