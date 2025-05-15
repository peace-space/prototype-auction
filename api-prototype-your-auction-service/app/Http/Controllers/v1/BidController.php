<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class BidController extends Controller
{
    public function index($id_auctions) {

        $high_bit = DB::table('bids')
                                ->select('id_users', 'id_auctions', 'bid_price')
                                ->where('id_auctions', '=', $id_auctions)
                                ->orderByDesc('bid_price')
                                ->get();

        return $high_bit;
    }

    public function highBids($id_auctions) {
        $high_bit = DB::table('bids')
                                ->select('id_users', 'id_auctions', 'bid_price')
                                ->where('id_auctions', '=', $id_auctions)
                                ->orderByDesc('bid_price')
                                ->get();

        return $high_bit->first();
    }

    public function bidding(Request $request) {
        try {

            $bidding = [
                'id_users' => $request->id_users,
                'id_auctions' => $request->id_auctions,
                'bid_price' => $request->bid_price
            ];

            $save_data_bidding = DB::table('bids')
                                    ->insert($bidding);

            return response()->json([
                'status' => 1,
                'message' => 'Successfully.',
                'data' => $save_data_bidding
            ]);

        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => 'Error.',
                'data' => $e
            ], 404);
        }
    }
}
