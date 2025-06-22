<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class ImageController extends Controller
{
    // public function index() {
    //     $images = DB::table('images')
    //                 ->select('*')
    //                 ->get();

    //     // $images = DB::table('images')
    //     //             ->select('images.id_images', 'images.id_auctions',
    //     //                     'images.image_path', 'auctions.shipping_cost',
    //     //                     'auctions.start_price', 'auctions.start_date_time',
    //     //                     'auctions.end_date_time')
    //     //             ->leftJoin('auctions', 'images.id_auctions', '=', 'auctions.id_auctions')
    //     //             ->get();

    //     return $images;
    // }

    // public function oneImage($id_auction, $index) {

    //     $image_path = "images.image_path_".$index;
    //     // return $image_path;

    //     $images = DB::table('auctions')
    //                         ->select('auctions.id_auctions', 'auctions.id_users',
    //                                     'auctions.name_product', $image_path)
    //                         ->join('images', 'images.id_images', '=', 'auctions.id_images')
    //                         ->where('auctions.id_auctions', '=', $id_auction)
    //                         ->get();
    //     // $data = [
    //     //     $imdex =>
    //     // ];
    //     // return $images[0];

    //     $get_image =Storage::disk('public')->put('storage/images/product-images/', 'car-003.jpg');

    //     return $get_image;

    //     return response()->json([
    //         'status' => 1,
    //         'message' => 'Successfully.',
    //         'data' => $images[0]
    //     ]);
    // }

    // public function images($id_auction, $index) {

    //     $image_path = "images.image_path_".$index;
    //     // return $image_path;

    //     $images = DB::table('auctions')
    //                         ->select('auctions.id_auctions', 'auctions.id_users',
    //                                     'auctions.name_product', 'images.image_path_1',
    //                                     'images.image_path_2', 'images.image_path_3',
    //                                     'images.image_path_4', 'images.image_path_5',
    //                                     'images.image_path_6', 'images.image_path_7',
    //                                     'images.image_path_8', 'images.image_path_8',
    //                                     'images.image_path_9', 'images.image_path_10')
    //                         ->join('images', 'images.id_images', '=', 'auctions.id_images')
    //                         ->where('auctions.id_auctions', '=', $id_auction)
    //                         ->get();

    //     return response()->json([
    //         'status' => 1,
    //         'message' => 'Successfully.',
    //         'data' => $images
    //     ]);
    // }

    public function getImage($storage_path, $images_path, $user_profile_image_path, $image_path) {
        // $path = 'storage/images//'.$image_path;

        $path = $storage_path;

        if ($images_path != '') {
            $path = $storage_path. '/' .$images_path;
        }

        if ($user_profile_image_path != '') {
            $path = $storage_path. '/' . $images_path . '/' . $user_profile_image_path;
        }
        if ($image_path != '') {
            $path = $storage_path. '/' . $images_path . '/' . $user_profile_image_path . '/' . $image_path;
        }

        // return $path;

        // $path = 'storage/images/user-profile-image/'.$image_path;
        // $path = $image_path;
        // return $path;

        // return response()->file('public/'.$path); // สำหรัย Server
        return response()->file($path); // สำหรับ Local
    }

    // Route::get('/get-image-profile/{storage}/{images}/{user-profile-image}', [ImageController::class, 'getImageProfile']);
    public function getImageProfile($storage_path, $images_path, $user_profile_image_path, $image_path) {
    // public function getImageProfile($image_path) {
        // return response()->file('storage\images\user-profile-image\profile-default-image.png');
        // $path = $storage_path . $images_path . $user_profile_image_path;

         $path = $storage_path;

        if ($images_path != '') {
            $path = $storage_path. '/' .$images_path;
        }

        if ($user_profile_image_path != '') {
            $path = $storage_path. '/' . $images_path . '/' . $user_profile_image_path;
        }
        if ($image_path != '') {
            $path = $storage_path. '/' . $images_path . '/' . $user_profile_image_path . '/' . $image_path;
        }
        // return $path;
        // return response()->file('public/'.$path); // สำหรัย Server
        return response()->file($path); // สำหรับ Local

        // return $image_path;
        // return response()->file('storage/images/user-profile-image/'.$image_path);
        // return response()->file($image_path);
    }

    public function test($storage_path, $images_path, $user_profile_image_path, $image_path) {
        // $path = $storage_path.$images_path.$user_profile_image_path;
        $path = $storage_path;

        if ($images_path != '') {
            $path = $storage_path. '/' .$images_path;
        }

        if ($user_profile_image_path != '') {
            $path = $storage_path. '/' . $images_path . '/' . $user_profile_image_path;
        }

        return $path;
    }
}
