<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class BidController extends Controller
{
    public function index() {
        return "Test";
    }

    public function highBids($id) {
        $high_bit = DB::table('bids')
                                ->select('id_users', 'id_auctions', 'bid_price')
                                ->where('id_auctions', '=', $id)
                                ->orderByDesc('bid_price')
                                ->get();

        return $high_bit;
    }
}
