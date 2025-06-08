<?php

namespace App\Http\Controllers\algorithm;

use App\Http\Controllers\Controller;
use DateTime;
use Illuminate\Http\Request;

class RunAuctionSystem extends Controller
{
    public function runAuctionSystem() {
        $now = new DateTime('now');

        return $now = date('Y-m-d H:i:s');
    }
}
