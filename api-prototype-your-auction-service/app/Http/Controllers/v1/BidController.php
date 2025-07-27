<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class BidController extends Controller
{
    public function index($id_auctions)
    {

        try {
            $high_bit = DB::table('bids')
                ->select(
                    'users.first_name_users', 'users.last_name_users',
                    'bids.bid_price',
                    'bids.created_at'
                )
                ->leftJoin('auctions', 'bids.id_auctions', '=', 'auctions.id_auctions')
                ->leftJoin('users', 'bids.id_users', '=', 'users.id_users')
                ->where('bids.id_auctions', '=', $id_auctions)
                ->orderByDesc('bid_price')
                ->get();

            return response()->json([
                'status' => 1,
                'message' => 'Successfully.',
                'data' => $high_bit
            ]);

        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => 'Error.',
                'data' => $e
            ]);
        }
    }

    public function highBids($id_auctions)
    {
        $high_bid = DB::table('bids')
            ->select('bids.id_users', 'bids.id_auctions', 'bids.bid_price')
            ->leftJoin('auctions', 'bids.id_auctions', '=', 'auctions.id_auctions')
            ->where('bids.id_auctions', '=', $id_auctions)
            ->orderByDesc('bid_price')
            ->get();

        return $high_bid->first();
    }

    public function bidding(Request $request)
    {
        try {

            $bidController = new BidController();



            $bid_price = (int)$request->bid_price;

            $bidding = [
                'id_users' => $request->id_users,
                'id_auctions' => $request->id_auctions,
                'bid_price' => $bid_price
            ];

            $save_data_bidding = DB::table('bids')
                ->insert($bidding);

            $max_price = $bidController->highBids($request->id_auctions);
            // return $max_price->bid_price;
            $save_high_price = DB::table('auctions')
                                ->where('id_auctions', $request->id_auctions)
                                ->update(['max_price' => $max_price->bid_price]);

            // return $save_high_price;

            return response()->json([
                'status' => 1,
                'message' => 'Successfully.',
                'data' => $save_data_bidding
            ], 201);
        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => 'Error.',
                'data' => $e
            ], 404);
        }
    }

    public function userBidDelete($id_bids, $id_auctions) {
        try {
            $delete_bid = DB::table('bids')
                                ->where('id_bids', '=', $id_bids)
                                ->delete();

            $max_price = $this->highBids($id_auctions);
            // return $max_price->bid_price;

            $update_max_price_auctions =  DB::table('auctions')
                                            ->where('id_auctions', '=', $id_auctions)
                                            ->update(['max_price', '=', $max_price->bid_price]);
            // return $update_max_price_auctions;
            if ($delete_bid == false) {
                return response()->json([
                    'status' => 1,
                    'message' => "ไม่มีข้อมูล",
                ], 404);
            }

            return response()->json([
                'status' => 1,
                'message' => 'Successfully.',
                'data' => $delete_bid
            ], 200);

        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => 'Error.',
                'data' => $e
            ], 500);
        }
    }
}
