<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Database\Query\JoinClause;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class ProductController extends Controller
{
    public function test() {
        return "TEST";
    }
    public function productDetail($id_auctions) {
        try{
            $detail_product = DB::table('auctions')
                    ->select('auctions.id_auctions',
                            'images.id_images',
                            'users.first_name_users', 'users.last_name_users',
                            'products.name_product',
                            'products.detail_product',
                            'images.image_path_1',
                            'images.image_path_2',
                            'images.image_path_3',
                            'images.image_path_4',
                            'images.image_path_5',
                            'images.image_path_6',
                            'images.image_path_7',
                            'images.image_path_8',
                            'images.image_path_9',
                            'images.image_path_10',
                            'auctions.shipping_cost',
                            'auctions.start_price',
                            'auctions.end_date_time',
                            'auctions.max_price')
                    ->join('products', 'products.id_products', '=', 'auctions.id_products')
                    ->join('images', 'images.id_images', '=', 'products.id_images')
                    ->join('users', 'users.id_users', '=', 'products.id_users')
                    ->where('id_auctions', '=', $id_auctions)
                    ->orderByRaw('id_auctions')
                    ->get();

                // return $detail_product->first();


            $counter = DB::raw('count(id_users) as bids_counter');

            $bids_counter = DB::table('bids')
                                ->select($counter)
                                ->where('id_auctions', '=', $id_auctions)
                                ->get();
            // return $bids_counter;

            $images = [];

            if ($detail_product->first()->image_path_1 != null) {
                array_push($images, $detail_product->first()->image_path_1);
            }
            if ($detail_product->first()->image_path_2 != null) {
                array_push($images, $detail_product->first()->image_path_2);
            }
            if ($detail_product->first()->image_path_3 != null) {
                array_push($images, $detail_product->first()->image_path_3);
            }
            if ($detail_product->first()->image_path_4 != null) {
                array_push($images, $detail_product->first()->image_path_4);
            }
            if ($detail_product->first()->image_path_5 != null) {
                array_push($images, $detail_product->first()->image_path_5);
            }
            if ($detail_product->first()->image_path_6 != null) {
                array_push($images, $detail_product->first()->image_path_6);
            }
            if ($detail_product->first()->image_path_7 != null) {
                array_push($images, $detail_product->first()->image_path_7);
            }
            if ($detail_product->first()->image_path_8 != null) {
                array_push($images, $detail_product->first()->image_path_8);
            }
            if ($detail_product->first()->image_path_9 != null) {
                array_push($images, $detail_product->first()->image_path_9);
            }
            if ($detail_product->first()->image_path_10 != null) {
                array_push($images, $detail_product->first()->image_path_10);
            }

            // return $images[4];

            $data = [
                "id_auctions" => $detail_product->first()->id_auctions,
                "id_images"=> $detail_product->first()->id_images,
                "first_name_users" => $detail_product->first()->first_name_users,
                "last_name_users" => $detail_product->first()->last_name_users,
                "name_product" => $detail_product->first()->name_product,
                "detail_product" => $detail_product->first()->detail_product,
                "images" => $images,
                "shipping_cost"=> $detail_product->first()->shipping_cost,
                "start_price"=> $detail_product->first()->start_price,
                "end_date_time"=> $detail_product->first()->end_date_time,
                "max_price"=> $detail_product->first()->max_price,
                "bids_count" => $bids_counter->first()->bids_counter
            ];

            return response()->json([
                'status' => 1,
                'message' => "Successfully.",
                'data' => $data
            ], 200);

        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => 'Error.',
                'data' => $e
            ], 500);
        }

    }


public function userProductDelete($id_users, $id_products)
    {
        try {
            $product_images = DB::table('products')
                                    ->select('*')
                                    ->join('images', function (JoinClause $join) {
                                        $join->on('images.id_images', '=', 'products.id_images');
                                    })
                                    ->where('products.id_products', '=', $id_products)
                                    ->first();
            // return $product_images->image_path_2;

            // for ($index = 1; $index <= 10; $index++) {
            //     // if ($product_images->images_path_.$index )
            // }

            // return $product_images['image_path_1'];

            $images_model = [
                $product_images->image_path_1,
                $product_images->image_path_2,
                $product_images->image_path_3,
                $product_images->image_path_4,
                $product_images->image_path_5,
                $product_images->image_path_6,
                $product_images->image_path_7,
                $product_images->image_path_8,
                $product_images->image_path_9,
                $product_images->image_path_10,
            ];

            for ($index = 0; $index < 10; $index++) {
                if ($images_model[$index] != '') {
                    $local_path = public_path($images_model[$index]);
                    unlink($local_path);
                }
            }

            // return $images_model;

            $delete_products = DB::table('products')->where('id_products', '=', $id_products)->delete();

            return response()->json([
                'status' => 1,
                'message' => "Successfully.",
                'data' => $delete_products,
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => "Error.",
                'data' => $e
            ], 500);
        }
    }
}
