<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Bid>
 */
class BidFactory extends Factory
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
            // 'id_auctions' => fake()->numberBetween(1, 10),
            // 'bid_price' => fake()->numberBetween(1, 1000)
        ];
    }
}
