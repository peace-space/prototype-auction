<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ImageController extends Controller
{
    public function index() {
        return 'index';
    }

    public function oneImage($id_auction) {
        $images = DB::table('images')
                                ->select('id_images', 'id_auctions', 'image_path')
                                ->where('id_auctions', '=', $id_auction)
                                ->orderByRaw('id_images')
                                ->get();
        return $images;
    }
}
