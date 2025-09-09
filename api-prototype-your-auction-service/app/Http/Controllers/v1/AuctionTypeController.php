<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class AuctionTypeController extends Controller
{
    public function auctionTypes() {
        try {
            // return "AA";
            $auction_types = DB::table('auction_types')
                                ->select('*')
                                ->get();

            return response()->json([
                'status' => 1,
                'message' => "Successfully",
                'data' => $auction_types
            ], 200);

        } catch (Exception $e){
            return response()->json([
                'status' => 0,
                'message' => 'Error.',
                'data' => $e
            ], 500);
        }
    }
}
