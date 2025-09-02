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
        Schema::create('chats', function (Blueprint $table) {
            $table->id('id_chats');
            $table->foreignId('id_chat_rooms');
            $table->bigInteger('id_users_sender');
            // $table->text('message')->nullable()->default('null');
            // $table->foreignId('id_image_in_chats')->nullable();
            $table->text('message')->nullable();
            $table->foreignId('id_image_in_chats')->nullable();
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at')->useCurrent()->useCurrentOnUpdate();


            $table->foreign('id_chat_rooms')->references('id_chat_rooms')->on('chat_rooms')->onDelete('cascade');
            $table->foreign('id_image_in_chats')->references('id_image_in_chats')->on('image_in_chats')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('chats');
    }
};

