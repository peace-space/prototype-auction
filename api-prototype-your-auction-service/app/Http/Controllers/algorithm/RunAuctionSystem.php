<?php

namespace App\Http\Controllers\algorithm;

use App\Http\Controllers\Controller;
use App\Http\Controllers\v1\ResultAuctionController;
use Carbon\Carbon;
use DateTime;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class RunAuctionSystem extends Controller
{
    public function runAuctionSystem() {
        $check_date_time_auctions = DB::table('auctions')
                                        ->select('*')
                                        ->where('auction_status', '=', true)
                                        ->get();

        $save_result_auctions = new ResultAuctionController();

        $message = '';
        // return 'tset';
        if ($check_date_time_auctions != '') {


            foreach ($check_date_time_auctions as $data) {

                $end_date_time_auctions = Carbon::parse($data->end_date_time, 'Asia/Bangkok');
                $current_date_time = Carbon::now('Asia/Bangkok');

                if ($end_date_time_auctions <= $current_date_time) {

                    $auctions_timeout = DB::table('auctions')
                                            ->where('id_auctions', '=', $data->id_auctions)
                                            ->update(['auction_status' => false]);

                $message = $save_result_auctions->onSaveTheWinnerAuctions($data->id_auctions);
                // return $a;
                    // array_push($newData, $auctions_timeout);
                }

            }

            return $message;
        }
    }

    public function test1($data) {
        $newData = [];

        foreach ($data as $d) {
            $end_date_time_auctions = Carbon::parse($d->end_date_time, 'Asia/Bangkok');
            $current_date_time = Carbon::now('Asia/Bangkok');

            if ($end_date_time_auctions <= $current_date_time) {

                $auctions_timeout = DB::table('auctions')
                                        ->where('id_auctions')
                                        ->update(['auctions_status', '=', 0]);

                array_push($newData, $d);

            } else {

                array_push($newData, $d);
            }

            return $newData;

        }
    }
}
