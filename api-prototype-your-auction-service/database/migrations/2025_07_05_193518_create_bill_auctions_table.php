<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('bill_auctions', function (Blueprint $table) {
            $table->id('id_bill_auctions');
            $table->foreignId('id_result_auctions');
            $table->foreignId('id_payment_status_types');
            $table->string('shipping_number');
            $table->integer('debts');
            $table->boolean('delivery_status')->default(false);
            $table->foreignId('id_payment_proof_images')->nullable();
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at')->useCurrent()->useCurrentOnUpdate();

            $table->foreign('id_result_auctions')->references('id_result_auctions')->on('result_auctions');
            $table->foreign('id_payment_status_types')->references('id_payment_status_types')->on('payment_status_types');
            $table->foreign('id_payment_proof_images')->references('id_payment_proof_images')->on('payment_proof_images');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('bill_auctions');
    }
};
