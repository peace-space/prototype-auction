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
        Schema::create('products', function (Blueprint $table) {
            $table->id('id_products');
            $table->foreignId('id_users');
            $table->foreignId('id_product_types');
            $table->string('name_product');
            $table->text('detail_product');
            $table->foreignId('id_images');
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at')->useCurrent()->useCurrentOnUpdate();

            $table->foreign('id_users')->references('id_users')->on('users')->onDelete("cascade");
            $table->foreign('id_product_types')->references('id_product_types')->on('product_types');
            $table->foreign('id_images')->references('id_images')->on('images')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('products');
    }
};
