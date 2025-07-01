<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Database\Query\JoinClause;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\v1\BidController;

use function Laravel\Prompts\select;

class ResultReportAuctionController extends Controller
{
    // public function resultReportAuction($id_user) {
    //    try {
    //         $result_report_auction = DB::table('result_report_auctions')
    //                                                 ->select('*')
    //                                                 ->Join('bids', function(JoinClause $join) {
    //                                                     $join->on('bids.id_bids', '=', 'result_report_auctions.id_bids');
    //                                                 })
    //                                                 ->join('auctions', function(JoinClause $join){
    //                                                     $join->on('auctions.id_auctions', '=', 'bids.id_auctions');
    //                                                 })
	// 												->join('images', function(JoinClause $join){
    //                                                     $join->on('images.id_images', '=', 'auctions.id_images');
    //                                                 })
    //                                                 ->where('result_report_auctions.id_users', '=', $id_user)
    //                                                 #->orderBy('result_report_auction.created_at')
    //                                                 ->get();
    //                 return response()->json([
    //                     'status' => 1,
    //                     'message' => 'Successfully.',
    //                     'data' => $result_report_auction
    //                 ], 200);

    //    } catch (Exception $e) {
    //         return response()->json([
    //             'status' => 0,
    //             'message' => 'Error.',
    //             'data' => $e
    //         ], 404);
    //    }
    // }


    // public function saveTheWinnerAuctions(Request $request) {
    //     try {

    //         $id_auctions = $request->id_auctions;


    //         $high_bid = DB::table('bids')
    //                                     ->select('bids.id_bids', 'bids.id_users', 'bids.id_auctions', 'bids.bid_price')
    //                                     ->leftJoin('auctions', 'bids.id_auctions', '=', 'auctions.id_auctions')
    //                                     ->where('bids.id_auctions', '=', $id_auctions)
    //                                     ->orderByDesc('bid_price')
    //                                     ->get();
    //         $the_winner_auctions = $high_bid->first();
    //         // return $high_bid->first();

    //         $data = [
    //           'id_users' => $the_winner_auctions->id_users,
    //           'id_auctions' => $the_winner_auctions->id_auctions,
    //           'id_bids' => $the_winner_auctions->id_bids,
    //           'payment_status' => '',
    //           'shipping_number' => '',
    //           'delivery_status' => '',
    //           'id_auction_types' => '',
    //           'id_payment_types' => '',
    //           'bank_account_number' => '',
    //         ];

    //         return $data;
    //         // DB::table('result_report_auctions')->insert($data);

    //         return response()->json([
    //             'status' => 1,
    //             'message' => 'Successfully.',
    //             'data' => $data
    //         ], 201);


    //     } catch (Exception $e) {
    //         return response()->json([
    //             'status' => 0,
    //             'message' => 'Error.',
    //             'data' => $e
    //         ], 404);
    //     }
    // }

    // public function test(Request $request) {
    //     try {

    //         $data = [
    //           'id_users' => $request->id_users,
    //           'id_auctions' => $request->id_auctions,
    //           'id_bids' => $request->id_bids,
    //           'payment_status' => $request->payment_status,
    //           'shipping_number' => $request->shipping_number,
    //           'delivery_status' => $request->delivery_status,
    //           'id_auction_types' => $request->id_auction_types,
    //           'id_payment_types' => $request->id_payment_types,
    //           'bank_account_number' => $request->bank_account_number,
    //         ];

    //         if ($data['payment_status'] == null) {
    //            $data['payment_status'] = false;
    //         }

    //         if ($data['shipping_number'] == null) {
    //             $data['shipping_number'] = '';
    //         }

    //         if ($data['delivery_status'] == null) {
    //             $data['delivery_status'] = false;
    //         }

    //         if ($data['bank_account_number'] == null) {
    //             $data['bank_account_number'] = '';
    //         }

    //         DB::table('result_report_auctions')->insert($data);

    //         return response()->json([
    //             'status' => 1,
    //             'message' => 'Successfully.',
    //             'data' => $data
    //         ], 201);


    //     } catch (Exception $e) {
    //         return response()->json([
    //             'status' => 0,
    //             'message' => 'Error.',
    //             'data' => $e
    //         ], 404);
    //     }
    // }

    // public function checkTheWinners(Request $request) {

    //     try {
    //         $id_user = $request->id_users;
    //         $id_auction = $request->id_auctions;

    //         $winner = DB::table('result_report_auctions')
    //                         ->select('*')
    //                         ->where('id_users', '=', $id_user, 'and', 'id_auctions', '=', $id_auction)
    //                         ->get();

    //         return response()->json([
    //             'status' => 1,
    //             'message' => 'Successfull.',
    //             'data' => $winner
    //         ], 200);

    //     } catch (Exception $e) {

    //         return response()->json([
    //             'status' => 0,
    //             'message' => 'Error.',
    //             'data' => $e
    //         ], 404);
    //     }
    // }
}
