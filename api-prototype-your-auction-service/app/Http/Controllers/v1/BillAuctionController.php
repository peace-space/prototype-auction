<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Database\Query\JoinClause;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class BillAuctionController extends Controller
{
    public function billAuction($id_bill_result) {
        try {
            $bill_auction = DB::table('bill_auctions')
                                    ->select('*')
                                    ->join('result_auctions', function(JoinClause $join){
                                        $join->on('result_auctions.id_result_auctions', '=', 'bill_auctions.id_result_auctions');
                                    })
                                    ->join('bids', function(JoinClause $join){
                                        $join->on('bids.id_bids', '=', 'result_auctions.id_bids');
                                    })
                                    ->join('auctions', function(JoinClause $join){
                                        $join->on('auctions.id_auctions', '=', 'bids.id_auctions');
                                    })
                                    ->join('products', function(JoinClause $join){
                                        $join->on('products.id_products', '=', 'auctions.id_products');
                                    })
                                    ->join('images', function(JoinClause $join) {
                                        $join->on('images.id_images', '=', 'products.id_images');
                                    })
                                    ->join('users', function(JoinClause $join) {
                                        $join->on('users.id_users', '=', 'products.id_users');
                                    })
                                    ->join('bank_accounts', function(JoinClause $join) {
                                        $join->on('bank_accounts.id_users', '=', 'products.id_users');
                                    })
                                    ->where('bill_auctions.id_bill_auctions', '=', $id_bill_result)
                                    ->get();
                $get_data_bill_auction =  $bill_auction->first();

                $image_model = [
                    'image_path_1' => $get_data_bill_auction->image_path_1,
                    'image_path_2' => $get_data_bill_auction->image_path_2,
                    'image_path_3' => $get_data_bill_auction->image_path_3,
                    'image_path_4' => $get_data_bill_auction->image_path_4,
                    'image_path_5' => $get_data_bill_auction->image_path_5,
                    'image_path_6' => $get_data_bill_auction->image_path_6,
                    'image_path_7' => $get_data_bill_auction->image_path_7,
                    'image_path_8' => $get_data_bill_auction->image_path_8,
                    'image_path_9' => $get_data_bill_auction->image_path_9,
                    'image_path_10' => $get_data_bill_auction->image_path_10,

                ];

                $bill_auction_model = [
                    'id_bill_auctions' => $get_data_bill_auction->id_bill_auctions,
                    'id_'

                ];

                    return response()->json([
                        'status' => 1,
                        'message' => 'Successfully.',
                        'data' => $bill_auction,
                        'images' => $image_model,
                    ], 200);

       } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => 'Error.',
                'data' => $e
            ], 404);
       }
    }
}
