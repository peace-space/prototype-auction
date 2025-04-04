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
            $table->foreignId('id_users');
            $table->string('name_product');
            $table->text('detail_product');
            $table->text('shipping_cost');
            $table->integer('start_price')->unsigned();
            $table->dateTime('start_date_time');
            $table->dateTime('end_date_time');
            $table->foreignId('id_images');
            $table->integer('max_price');
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at')->useCurrent()->useCurrentOnUpdate();


            $table->foreign('id_users')->references('id_users')->on('users');
            $table->foreign('id_images')->references('id_images')->on('images');
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
