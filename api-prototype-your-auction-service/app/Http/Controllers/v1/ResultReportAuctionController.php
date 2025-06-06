<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Database\Query\JoinClause;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ResultReportAuctionController extends Controller
{
    public function resultReportAuction() {
       try {
            $result_report_auction = DB::table('result_report_auctions')
                                                    ->select('*')
                                                    ->Join('bids', function(JoinClause $join) {
                                                        $join->on('bids.id_bids', '=', 'result_report_auctions.id_bids');
                                                    })
                                                    ->where('result_report_auctions.id_users', '=', 5)
                                                    // ->orderBy('result_report_auction.created_at')
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
            ], 500);
       }
    }
}
