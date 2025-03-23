<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Auction>
 */
class AuctionFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'id_users' => 2,
            'name_product' => fake()->firstName(),
            'detail_product' => fake()->sentence(45),
            'start_price' => fake()->randomNumber(),
            'start_date_time' => fake()->dateTime(),
            'end_date_time' => fake()->dateTime(),
            'image_files' => fake()->filePath(),
        ];
    }
}
