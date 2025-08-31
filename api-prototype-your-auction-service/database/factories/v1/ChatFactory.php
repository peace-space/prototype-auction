<?php

namespace Database\Factories\v1;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\v1\Chat>
 */
class ChatFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'id_chat_rooms' => fake()->numberBetween(1, 50),
            'id_users_sender' => fake()->numberBetween(1, 50),
            'message' => fake()->sentence(50),
            'id_image_in_chats' => fake()->numberBetween(1, 50),
        ];
    }
}
