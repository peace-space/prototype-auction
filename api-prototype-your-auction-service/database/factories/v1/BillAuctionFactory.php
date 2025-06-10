<?php

namespace Database\Factories\v1;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\v1\BillAuction>
 */
class BillAuctionFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'id_result_auctions' => fake()->numberBetween(1, 10),
            'payment_status' => fake()->boolean(),
            'shipping_number' => fake()->numberBetween(10000, 99999),
            'delivery_status' => fake()->boolean(),
        ];
    }
}
