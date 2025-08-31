<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;

use App\Models\v1\Auction;
use App\Models\v1\Bid;
use App\Models\v1\Image;
use App\Models\v1\AuctionType;
use App\Models\v1\BankAccount;
use App\Models\v1\BillAuction;
use App\Models\v1\Chat;
use App\Models\v1\ChatRoom;
use App\Models\v1\ImageInChats;
use App\Models\v1\PaymentProofImages;
use App\Models\v1\PaymentStatusType;
use App\Models\v1\PaymentType;
use App\Models\v1\PrivateAuctionGroup;
use App\Models\v1\Product;
use App\Models\v1\ProductType;
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
        $number = 50;
        User::factory($number)->create();
        AuctionType::factory(2)->create();
        PaymentType::factory(3)->create();
        ProductType::factory($number)->create();
        PaymentStatusType::factory(3)->create();
        BankAccount::factory($number)->create();
        Image::factory($number)->create();
        Product::factory($number)->create();
        Auction::factory($number)->create();
        Bid::factory($number)->create();
        ResultAuction::factory($number)->create();
        PaymentProofImages::factory($number)->create();
        BillAuction::factory($number)->create();
        ImageInChats::factory($number)->create();
        ChatRoom::factory($number)->create();
        Chat::factory($number)->create();
        PrivateAuctionGroup::factory($number)->create();
        // \App\Models\User::factory()->create([
        //     'name' => 'Test User',
        //     'email' => 'test@example.com',
        // ]);
    }
}
