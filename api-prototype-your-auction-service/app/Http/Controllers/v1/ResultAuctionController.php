<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Database\Query\JoinClause;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ResultAuctionController extends Controller
{
    public function resultReportAuction($id_user) {
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
                                                    ->where('result_auctions.id_users', '=', $id_user)
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


    public function saveTheWinnerAuctions(Request $request) {
        try {

            $id_auctions = $request->id_auctions;
            // return $id_auctions;

            $high_bid = DB::table('bids')
                                        ->select('bids.id_bids', 'bids.id_users',
                                                'bids.id_auctions', 'bids.bid_price',
                                                'auctions.shipping_cost', 'auctions.id_payment_types')
                                        ->leftJoin('auctions', function(JoinClause $join) {
                                            $join->on('auctions.id_auctions', '=', 'bids.id_auctions');
                                        })
                                        ->where('bids.id_auctions', '=', $id_auctions)
                                        ->orderByDesc('bid_price')
                                        ->get();

            $the_winner_auctions = $high_bid->first();
            // return $high_bid->first();

            $data = [
              'id_users' => $the_winner_auctions->id_users,
            //   'id_auctions' => $the_winner_auctions->id_auctions,
              'id_bids' => $the_winner_auctions->id_bids,
            //   'payment_status' => '',
            //   'shipping_number' => '',
            //   'delivery_status' => '',
            //   'id_auction_types' => '',
            //   'id_payment_types' => '',
            //   'bank_account_number' => '',
            ];
            // return $data;
            // DB::table('result_auctions')->insert($data);

            $result_auction_datas = [

            ];

            $result_auction_datas = DB::table('result_auctions')
                                    ->select('*')
                                    ->where('id_users', '=', $data['id_users'],
                                                'and',
                                            'id_bids', '=', $data['id_bids'])
                                    ->orderByDesc('id_result_auctions')
                                    ->get();

            // return $result_auction_datas->first();

            $id_result_auctions = $result_auction_datas->first()->id_result_auctions;

            // return $id_result_auctions;

            $bill_auction_data = [
                'id_result_auctions' => $id_result_auctions,
                'payment_status' => false,
                'debts' => $the_winner_auctions->bid_price,
                'shipping_number' => $the_winner_auctions->shipping_cost,
                'delivery_status' => false
            ];

            // return $bill_auction_data;

            $create_bill_auction = DB::table('bill_auctions')
                                        ->insert($bill_auction_data);

            return response()->json([
                'status' => 1,
                'message' => 'Successfully.',
                // 'data' => $create_bill_auction
            ], 201);


        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => 'Error.',
                'data' => $e
            ], 404);
        }
    }

    public function test(Request $request) {
        try {

            $data = [
              'id_users' => $request->id_users,
              'id_auctions' => $request->id_auctions,
              'id_bids' => $request->id_bids,
              'payment_status' => $request->payment_status,
              'shipping_number' => $request->shipping_number,
              'delivery_status' => $request->delivery_status,
              'id_auction_types' => $request->id_auction_types,
              'id_payment_types' => $request->id_payment_types,
              'bank_account_number' => $request->bank_account_number,
            ];

            if ($data['payment_status'] == null) {
               $data['payment_status'] = false;
            }

            if ($data['shipping_number'] == null) {
                $data['shipping_number'] = '';
            }

            if ($data['delivery_status'] == null) {
                $data['delivery_status'] = false;
            }

            if ($data['bank_account_number'] == null) {
                $data['bank_account_number'] = '';
            }

            DB::table('result_report_auctions')->insert($data);

            return response()->json([
                'status' => 1,
                'message' => 'Successfully.',
                'data' => $data
            ], 201);


        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => 'Error.',
                'data' => $e
            ], 404);
        }
    }

    public function checkTheWinners(Request $request) {

        try {
            $id_user = $request->id_users;
            $id_auction = $request->id_auctions;

            $winner = DB::table('result_auctions')
                            ->select('*')
                            ->join('bids', function(JoinClause $join){
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
                            ->join('users', function(JoinClause $join) {
                                $join->on('users.id_users', '=', 'products.id_users');
                            })
                            ->join('bill_auctions', function(JoinClause $join) {
                                $join->on('bill_auctions', '=', '');
                            })
                            ->where('result_auctions.id_users', '=', $id_user, 'and', 'id_auctions', '=', $id_auction)
                            ->get();

            return response()->json([
                'status' => 1,
                'message' => 'Successfull.',
                'data' => $winner
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
