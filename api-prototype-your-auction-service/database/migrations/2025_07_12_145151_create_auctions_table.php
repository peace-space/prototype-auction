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
        Schema::create('auctions', function (Blueprint $table) {
            $table->id('id_auctions');
            $table->foreignId('id_products');
            $table->boolean('auction_status');
            $table->integer('shipping_cost');
            $table->integer('start_price');
            $table->dateTime('end_date_time');
            $table->integer('max_price');
            $table->foreignId('id_auction_types');
            $table->foreignId('id_payment_types');
            $table->foreignId('id_bank_accounts');
            $table->foreignId('id_payment_status_types');
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at')->useCurrent()->useCurrentOnUpdate();

            $table->foreign('id_products')->references('id_products')->on('products');
            $table->foreign('id_auction_types')->references('id_auction_types')->on('auction_types');
            $table->foreign('id_payment_types')->references('id_payment_types')->on('payment_types');
            $table->foreign('id_bank_accounts')->references('id_bank_accounts')->on('bank_accounts');
            $table->foreign('id_payment_status_types')->references('id_payment_status_types')->on('payment_status_types');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('auctions');
    }
};
