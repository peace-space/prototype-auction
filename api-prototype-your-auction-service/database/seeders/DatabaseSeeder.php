<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;

use App\Models\v1\Auction;
use App\Models\v1\Bid;
use App\Models\v1\Image;
use App\Models\v1\AuctionType;
use App\Models\v1\BankAccount;
use App\Models\v1\BillAuction;
use App\Models\v1\PaymentType;
use App\Models\v1\Product;
use App\Models\v1\ResultAuction;
use App\Models\v1\User;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // \App\Models\User::factory(10)->create();
        // Bid::factory(10)->create();
        // Image::factory(10)->create();
        // Auction::factory(10)->create();
        // ResultReportAuction::factory(10)->create();
        User::factory(10)->create();
        AuctionType::factory(2)->create();
        PaymentType::factory(3)->create();
        BankAccount::factory(10)->create();
        Image::factory(10)->create();
        Product::factory(10)->create();
        Auction::factory(10)->create();
        Bid::factory(10)->create();
        ResultAuction::factory(10)->create();
        BillAuction::factory(10)->create();
        // \App\Models\User::factory()->create([
        //     'name' => 'Test User',
        //     'email' => 'test@example.com',
        // ]);
    }
}
