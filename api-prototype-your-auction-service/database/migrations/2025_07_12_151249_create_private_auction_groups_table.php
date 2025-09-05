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
        Schema::create('private_auction_groups', function (Blueprint $table) {
            $table->id('id_private_auction_groups');
            $table->foreignId('id_auctions');
            $table->foreignId('id_users');
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at')->useCurrent()->useCurrentOnUpdate();


            $table->foreign('id_auctions')->references('id_auctions')->on('auctions')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('private_auction_groups');
    }
};
