<?php

namespace App\Http\Controllers;

use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class AuctionController extends Controller
{
    public function index() {
        try{

            $auction = DB::table('auctions')
                        ->select('*')
                        ->get();

            return response()->json([
                'status' => 1,
                'message' => "Successfully.",
                'data' => $auction
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
