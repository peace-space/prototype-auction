<?php

namespace Database\Factories\v1;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\v1\Product>
 */
class ProductFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'id_users' => fake()->numberBetween(1, 10),
            'id_product_types' => fake()->numberBetween(1, 10),
            // 'id_users' => 1,
            'name_product' => fake()->word(10),
            'detail_product' => fake()->sentence(45),
            'id_images' => fake()->numberBetween(1, 10),
        ];
    }
}
