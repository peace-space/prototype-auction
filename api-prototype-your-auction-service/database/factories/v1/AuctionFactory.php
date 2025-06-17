<?php

namespace Database\Factories\v1;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Model>
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
            'id_products' => fake()->numberBetween(1, 10),
            'auction_status' => fake()->boolean(),
            'shipping_cost' => fake()->numberBetween(20, 50),
            'start_price' => fake()->numberBetween(1, 1000),
            'max_price' => fake()->numberBetween(1, 1000),
            'id_auction_types' => fake()->numberBetween(1, 2),
            'id_payment_types' => fake()->numberBetween(1, 3),
            'id_bank_accounts' => fake()->numberBetween(1, 10),
            // 'end_date_time' => fake()->dateTime(),
            'end_date_time' => '2025-12-01 22:30:38',
            // 'updated_at' =>
        ];
    }
}
