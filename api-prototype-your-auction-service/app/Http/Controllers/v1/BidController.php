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
                    'users.name',
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
        $high_bit = DB::table('bids')
            ->select('bids.id_users', 'bids.id_auctions', 'bids.bid_price')
            ->leftJoin('auctions', 'bids.id_auctions', '=', 'auctions.id_auctions')
            ->where('bids.id_auctions', '=', $id_auctions)
            ->orderByDesc('bid_price')
            ->get();

        return $high_bit->first();
    }

    public function bidding(Request $request)
    {
        try {

            $bid_price = (int)$request->bid_price;

            $bidding = [
                'id_users' => $request->id_users,
                'id_auctions' => $request->id_auctions,
                'bid_price' => $bid_price
            ];

            $save_data_bidding = DB::table('bids')
                ->insert($bidding);

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
}
