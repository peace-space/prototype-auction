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
            // 'id_users' => fake()->numberBetween(1, 10),
            // 'name_product' => fake()->firstName(),
            // 'detail_product' => fake()->sentence(45),
            // // 'start_price' => fake()->randomNumber(),
            // 'shipping_cost' => fake()->numberBetween(20, 50),
            // 'start_price' => fake()->numberBetween(1, 1000),
            // 'start_date_time' => fake()->dateTime(),
            // // 'id_images' => fake()->numberBetween(1, 10),
            // 'id_images' => fake()->unique()->numberBetween(1, 10),
            // 'max_price' => fake()->numberBetween(1, 1000),
            // // 'end_date_time' => fake()->dateTime(),
            // 'end_date_time' => '2025-12-01 22:30:38',
        ];
    }
}
