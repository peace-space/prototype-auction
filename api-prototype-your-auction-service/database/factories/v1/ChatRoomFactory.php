<?php

namespace Database\Factories\v1;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\v1\ChatRoom>
 */
class ChatRoomFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'id_users_chat_1' => fake()->numberBetween(1, 10),
            'id_users_chat_2' => fake()->numberBetween(1, 10),
            'id_products' => fake()->numberBetween(1, 10),
        ];
    }
}
