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
            $result_report_auction = DB::table('result_auctions')
                                                    ->select('*')
                                                    ->Join('bids', function(JoinClause $join) {
                                                        $join->on('bids.id_bids', '=', 'result_auctions.id_bids');
                                                    })
                                                    ->join('auctions', function(JoinClause $join){
                                                        $join->on('auctions.id_auctions', '=', 'bids.id_auctions');
                                                    })
                                                    ->join('products', function(JoinClause $join){
                                                        $join->on('products.id_products', '=', 'auctions.id_products');
                                                    })
													->join('images', function(JoinClause $join){
                                                        $join->on('images.id_images', '=', 'products.id_images');
                                                    })
                                                    ->join('bill_auctions', function(JoinClause $join){
                                                        $join->on('bill_auctions.id_result_auctions', '=', 'result_auctions.id_result_auctions');
                                                    })
                                                    ->where('result_auctions.id_users', '=', $id_bill_result)
                                                    #->orderBy('result_report_auction.created_at')
                                                    ->get();
                    return response()->json([
                        'status' => 1,
                        'message' => 'Successfully.',
                        'data' => $result_report_auction
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
