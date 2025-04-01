<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ImageController extends Controller
{
    public function index() {
        // $images = DB::table('images')
        //             ->select('id_images', 'id_auctions', 'image_path')
        //             ->get();

        $images = DB::table('images')
                    ->select('images.id_images', 'images.id_auctions',
                            'images.image_path', 'auctions.shipping_cost',
                            'auctions.start_price', 'auctions.start_date_time',
                            'auctions.end_date_time')
                    ->leftJoin('auctions', 'images.id_auctions', '=', 'auctions.id_auctions')
                    ->get();

        return $images;
    }

    public function oneImage($id_auction) {

        $images = DB::table('images')
                                ->select('id_images', 'id_auctions', 'image_path')
                                ->where('id_auctions', '=', $id_auction)
                                ->orderByRaw('id_images')
                                ->get();

        return response()->json([
            'status' => 1,
            'message' => 'Successfully.',
            'data' => $images[0]
        ]);
    }
}
