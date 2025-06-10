<?php

namespace Database\Factories\v1;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Model>
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
            'image_path_1' => '/coffee-mug-002.jpg',
            'image_path_2' => '/vase-002.jpg',
            'image_path_3' => '/vase-003.jpg',
            'image_path_4' => '/shoes-001.jpg',
            'image_path_5' => '/watch-002.jpg',
            'image_path_6' => '/watch-003.jpg',
            // 'image_path_7' => null,
            // 'image_path_8' => null,
            // 'image_path_9' => null,
            // 'image_path_10' => null,
        ];
    }
}
