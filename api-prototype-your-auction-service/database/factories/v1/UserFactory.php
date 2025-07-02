<?php

namespace Database\Factories\v1;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\Hash;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\v1\User>
 */
class UserFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'first_name_users' => fake()->firstName(),
            'last_name_users' => fake()->lastName(),
            'phone' => fake()->unique()->phoneNumber(),
            'email' => fake()->unique()->email(),
            'address' => fake()->address(),
            // 'password' => static::$password ??= Hash::make('password'),
            'password' => Hash::make('1'),
            'admin_status' => fake()->boolean(),
            'image_profile' => "/storage/images/user-profile-image/public/storage/images/user-profile-image/profile-default-image.png"
        ];
    }
}
