<?php

namespace Database\Factories\v1;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\v1\PrivateAuctionGroup>
 */
class PrivateAuctionGroupFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            // 'id_private_auction_groups' => fake()->numberBetween(1, 10),
            'id_auctions' => fake()->numberBetween(1, 50),
            'id_users' => fake()->numberBetween(1, 50),
        ];
    }
}
