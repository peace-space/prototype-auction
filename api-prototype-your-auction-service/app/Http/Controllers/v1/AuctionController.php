<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Database\Query\JoinClause;
use Illuminate\Http\Request;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\Storage;

class AuctionController extends Controller
{
    public function index() {
        try{
            $auctions_list = DB::table('auctions')
                    ->select('auctions.id_auctions', 'images.id_images',
                            'name_product',
                            'images.image_path_1',
                            'auctions.shipping_cost',
                            'auctions.start_price',
                            'auctions.start_date_time',
                            'auctions.end_date_time',
                            'max_price',
                            )
                    ->join('images', function(JoinClause $join){
                        $join->on('auctions.id_images', '=', 'images.id_images');
                    })
                    ->orderByRaw('id_auctions')
                    ->get();

            return response()->json([
                'status' => 1,
                'message' => "Successfully.",
                'data' => $auctions_list
            ], 200);

        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => 'Error.',
                'data' => $e
            ], 500);
        }
    }

    public function productDetail($id_auctions) {
        try{
            $detail_product = DB::table('auctions')
                    ->select('auctions.id_auctions',
                            'images.id_images',
                            'users.name',
                            'auctions.name_product',
                            'auctions.detail_product',
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
                            'auctions.start_price', 'auctions.start_date_time',
                            'auctions.end_date_time',
                            'max_price')
                    ->join('images', 'auctions.id_images', '=', 'images.id_images')
                    ->join('users', 'users.id_users', '=', 'auctions.id_users')
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
                "name" => $detail_product->first()->name,
                "name_product" => $detail_product->first()->name_product,
                "detail_product" => $detail_product->first()->detail_product,
                "images" => $images,
                "shipping_cost"=> $detail_product->first()->shipping_cost,
                "start_price"=> $detail_product->first()->start_price,
                "start_date_time"=> $detail_product->first()->start_date_time,
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

    public function addImageForProduct() {
        // Schema::table('auctions', function($table){
        //     $table->string('test');
        // });
    }

    public function deleteImageForProduct() {
        // Schema::table('auctions', function($table){
        //     $table->dropColumn('test');
        // });
    }

    public function createProduct(Request $request) {
        try {
            $request->validate([
                'image' => 'required | image | mimes:png, jpg, jpeh, webp'
            ]);

            $image_name = Storage::disk('public')->put('images/product-images', $request->image);

            $path = Storage::url($image_name);

            $data = [
                'id_users' => 8,
                'name_product' => 'gg',
                'detail_product' => 'bmw',
                'shipping_cost' => 10,
                'start_price' => 10,
                'start_date_time' => "2015-09-11 03:23:17",
                'end_date_time' => "1992-05-09 00:48:10",
            ];

            DB::table('auctions')
                    ->insert($data);

            // $max = DB::raw('MAX(created_at) as last_time');
            $max = DB::table('auctions')
                            ->select(DB::raw('MAX(created_at) as last_time'))
                            ->where('id_users', '=', $data['id_users'])
                            ->get();

            $last_time = $max[0];

            // return $last_time->last_time;
            $last_time_data = DB::table('auctions')
                                    ->select('id_auctions', 'name_product', )
                                    ->where('created_at', '=', $last_time->last_time)
                                    ->get();


            $id_auctions_last_time = $last_time_data->first();
            // return $id_auctions_last_time->id_auctions;

            $image_model = [
                'id_auctions' => $id_auctions_last_time->id_auctions,
                'image_path' => $path
            ];

            DB::table('images')
                    ->insert($image_model);

            $reaction = DB::table('auctions')
                        ->select('auctions.id_auctions', 'auctions.name_product', 'images.image_path')
                        ->join('images', 'auctions.id_auctions', '=', 'images.id_auctions')
                        ->where('images.id_auctions', '=', $id_auctions_last_time->id_auctions)
                        ->get();

            return response()->json([
                'status' => 1,
                'message' => "Successfully.",
                'data' => $reaction
            ], 201);

        } catch (Exception $e) {
            return response()->json([
                'status' => 1,
                'message' => "Successfully.",
                'data' => $e
            ]);
        }
    }

    public function test($id_auctions) {
        // $data = [
        //     'id_users' => 8,
        //     'name_product' => 'gg',
        //     'detail_product' => 'bmw',
        //     'shipping_cost' => 10,
        //     'start_price' => 10,
        //     'start_date_time' => "2015-09-11 03:23:17",
        //     'end_date_time' => "1992-05-09 00:48:10",
        // ];

        $data = [
            'a', 'b', 'c', 'd'
        ];

        array_push($data, 'e');
        array_push($data, 'f');
        array_push($data, 1);
        array_push($data, 2);
        array_push($data, 3);
        // $test = array_push($data, '2');
        // $test = array_push($data, '3');
        // $test = array_push($data, '4');

        return $data;
    }


}
