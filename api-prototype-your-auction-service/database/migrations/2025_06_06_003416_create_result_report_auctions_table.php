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
        Schema::create('result_report_auctions', function (Blueprint $table) {
            $table->id('id_result_report_auctions');
            $table->integer('id_users')->unsigned();
            $table->integer('id_auctions')->unsigned();
            $table->foreignId('id_bids');
            $table->boolean('payment_status')->default(false);
            $table->string('shipping_number')->default(null);
            $table->boolean('delivery_status')->default(false);
            $table->integer('id_auction_types')->default(null);
            $table->integer('id_payment_types')->default(null);
            $table->string('bank_account_number')->default(null);
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at')->useCurrent()->useCurrentOnUpdate();

            $table->foreign('id_bids')->references('id_bids')->on('bids');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('result_report_auctions');
    }
};
