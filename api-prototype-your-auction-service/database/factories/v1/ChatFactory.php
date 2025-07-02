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
            'users_chat_1' => fake()->numberBetween(1, 10),
            'users_chat_2' => fake()->numberBetween(1, 10),
            'message' => fake()->sentence(50),
        ];
    }
}
