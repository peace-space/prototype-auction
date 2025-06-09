<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\ResultReportAuction>
 */
class ResultReportAuctionFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            //  'id_users' => fake()->numberBetween(1, 10),
            //  'id_auctions' => fake()->numberBetween(1, 10),
            //  'id_bids' => fake()->numberBetween(1, 10),
            //  'payment_status' => fake()->boolean(),
            //  'shipping_number' => fake()->numberBetween(1000000000, 9999999999),
            //  'delivery_status' => fake()->boolean(),
            //  'id_auction_types' => fake()->boolean(),
            //  'id_payment_types' => fake()->boolean(),
            //  'bank_account_number' => fake()->numberBetween(1000000000, 9999999999),
        ];
    }
}
