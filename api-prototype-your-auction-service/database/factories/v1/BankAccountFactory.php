<?php

namespace Database\Factories\v1;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\v1\BankAccount>
 */
class BankAccountFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'id_users' => fake()->unique()->numberBetween(1, 50),
            'name_bank_account' => fake()->word(),
            'name_account' => fake()->name(),
            'bank_account_number' => fake()->numberBetween(1000000000, 9999999999),
            'prompt_pay' => fake()->numberBetween(1000000000, 9999999999),
        ];
    }
}
