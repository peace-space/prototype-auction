<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Image>
 */
class ImageFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'image_path_1' => '/storage/images/product-images/car-001.jpg',
            'image_path_2' => '/storage/images/product-images/car-002.jpg',
            'image_path_3' => '/storage/images/product-images/car-003.jpg',
            'image_path_4' => '/storage/images/product-images/choes-001.jpg',
            'image_path_5' => '/storage/images/product-images/choes-002.jpg',
            'image_path_6' => '/storage/images/product-images/choes-003.jpg',
            // 'image_path_7' => null,
            // 'image_path_8' => null,
            // 'image_path_9' => null,
            // 'image_path_10' => null,
        ];
    }
}
