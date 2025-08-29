<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class ImageController extends Controller
{
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


        // return response()->file('public/'.$path); // สำหรัย Server
        return response()->file($path); // สำหรับ Local
    }

    // Route::get('/get-image-profile/{storage}/{images}/{user-profile-image}', [ImageController::class, 'getImageProfile']);
    public function getImageProfile($storage_path, $images_path, $user_profile_image_path, $image_path) {
    // public function getImageProfile($image_path) {
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
