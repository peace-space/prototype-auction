<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Database\Query\JoinClause;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PrivateAuctionGroupController extends Controller
{
    public function privateAuctionsGroup($id_users)
    {
        try {

            $get_private_auction_group = DB::table('private_auction_groups')
                ->select(
                    'private_auction_groups.id_private_auction_groups',
                    'auctions.id_auctions',
                    'auctions.auction_status',
                    'auctions.shipping_cost',
                    'auctions.start_price',
                    'auctions.end_date_time',
                    'auctions.max_price',
                    'auctions.id_auction_types',
                    'auctions.id_payment_types',
                    'auctions.id_bank_accounts',
                    'products.id_products',
                    'products.name_product',
                    'images.image_path_1',
                )
                ->join('auctions', function (JoinClause $join) {
                    $join->on('auctions.id_auctions', '=', 'private_auction_groups.id_auctions');
                })
                ->join('products', function (JoinClause $join) {
                    $join->on('products.id_products', '=', 'auctions.id_products');
                })
                ->join('images', function (JoinClause $join) {
                    $join->on('images.id_images', '=', 'products.id_images');
                })
                ->where('private_auction_groups.id_users', '=', $id_users)
                ->get();

            $private_auctions_model_data = [
                ''
            ];

            return response()->json([
                'status' => 1,
                'message' => "Successfully.",
                'data' => $get_private_auction_group
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => "Error.",
                'data' => $e
            ], 500);
        }
    }
}
