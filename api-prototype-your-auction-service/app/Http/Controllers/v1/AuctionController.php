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
            // $request->validate([
            //     // 'image_1' => 'nullable | required | image | mimes:png, jpg, jpeh, webp',
            //     // 'image_2' => 'required | image | mimes:png, jpg, jpeh, webp',
            //     // 'image_3' => 'required | image | mimes:png, jpg, jpeh, webp',
            //     // 'image_4' => 'required | image | mimes:png, jpg, jpeh, webp',
            //     // 'image_5' => 'required | image | mimes:png, jpg, jpeh, webp',
            //     // 'image_6' => 'required | image | mimes:png, jpg, jpeh, webp',
            //     // 'image_7' => 'required | image | mimes:png, jpg, jpeh, webp',
            //     // 'image_8' => 'required | image | mimes:png, jpg, jpeh, webp',
            //     // 'image_9' => 'required | image | mimes:png, jpg, jpeh, webp',
            //     // 'image_10' => 'required | image | mimes:png, jpg, jpeh, webp',
            // ]);

            // $image_name = Storage::disk('public')->put('images/product-images', $request->image_1);

            // $path = Storage::url($image_name);
            // return $request->image_1;
            if ($request->image_1 != null) {
                $image_name_1 = Storage::disk('public')->put('images/product-images', $request->image_1);
                $image_path_1 = Storage::url($image_name_1);
            } else {
                $image_path_1 = null;
            }

            if ($request->image_2 != null) {
                $image_name_2 = Storage::disk('public')->put('images/product-images', $request->image_2);
                $image_path_2 = Storage::url($image_name_2);
            } else {
                $image_path_2 = null;
            }

            if ($request->image_3 != null) {
                $image_name_3 = Storage::disk('public')->put('images/product-images', $request->image_3);
                $image_path_3 = Storage::url($image_name_3);
            } else {
                $image_path_3 = null;
            }

            if ($request->image_4 != null) {
                $image_name_4 = Storage::disk('public')->put('images/product-images', $request->image_4);
                $image_path_4 = Storage::url($image_name_4);
            } else {
                $image_path_4 = null;
            }

            if ($request->image_5 != null) {
                $image_name_5 = Storage::disk('public')->put('images/product-images', $request->image_5);
                $image_path_5 = Storage::url($image_name_5);
            } else {
                $image_path_5 = null;
            }

            if ($request->image_6 != null) {
                $image_name_6 = Storage::disk('public')->put('images/product-images', $request->image_6);
                $image_path_6 = Storage::url($image_name_6);
            } else {
                $image_path_6 = null;
            }

            if ($request->image_7 != null) {
                $image_name_7 = Storage::disk('public')->put('images/product-images', $request->image_7);
                $image_path_7 = Storage::url($image_name_7);
            } else {
                $image_path_7 = null;
            }

            if ($request->image_8 != null) {
                $image_name_8 = Storage::disk('public')->put('images/product-images', $request->image_8);
                $image_path_8 = Storage::url($image_name_8);
            } else {
                $image_path_8 = null;
            }

            if ($request->image_9 != null) {
                $image_name_9 = Storage::disk('public')->put('images/product-images', $request->image_9);
                $image_path_9 = Storage::url($image_name_9);
            } else {
                $image_path_9 = null;
            }

            if ($request->image_10 != null) {
                $image_name_10 = Storage::disk('public')->put('images/product-images', $request->image_10);
                $image_path_10 = Storage::url($image_name_10);
            } else {
                $image_path_10 = null;
            }

            $path = 'test';

            $image_model = [
                'image_path_1' => $image_path_1,
                'image_path_2' => $image_path_2,
                'image_path_3' => $image_path_3,
                'image_path_4' => $image_path_4,
                'image_path_5' => $image_path_5,
                'image_path_6' => $image_path_6,
                'image_path_7' => $image_path_7,
                'image_path_8' => $image_path_8,
                'image_path_9' => $image_path_9,
                'image_path_10' => $image_path_10,
            ];

            $save_images = DB::table('images')
                                ->insert($image_model);

            $last_time_image = DB::table('images')
                                ->select(DB::raw('MAX(created_at) as last_time'))
                                ->get();

            $last_id_image = DB::table('images')
                                ->select('id_images')
                                ->where('created_at', '=', $last_time_image[0]->last_time)
                                ->get();

            // return $last_id_image[0]->id_images;

            $data = [
                'id_users' => $request->id_users,
                'name_product' => $request->name_product,
                'detail_product' => $request->detail_product,
                'shipping_cost' => $request->shipping_cost,
                'start_price' => $request->start_price,
                'start_date_time' => $request->start_date_time,
                'end_date_time' => $request->end_date_time,
                'id_images' => $last_id_image[0]->id_images,
                'max_price' => $request->max_price
            ];

            $save_product = DB::table('auctions')
                                ->insert($data);

            $last_time_auction = DB::table('auctions')
                            ->select(DB::raw('MAX(created_at) as last_time'))
                            ->where('id_users', '=', $data['id_users'])
                            ->get();
            // return $last_time_auction[0]->last_time;

            $reAction = DB::table('auctions')
                            ->select('*')
                            ->join('images', 'auctions.id_images', '=', 'images.id_images')
                            // ->orderByDesc('auctions.id_auctions')
                            // ->where('auctions.id_users', '=', $data['id_users'], '&',
                            //         'auctions.created_at', '=', $last_time_auction[0]->last_time)
                            ->get();


            return response()->json([
                'status' => 1,
                'message' => "Successfully.",
                'data' => $reAction->last()
            ], 201);

        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => "Successfully.",
                'data' => $e
            ]);
        }
    }

    // public function test(Request $request) {
    //     try {
    //         $request->validate([
    //             'image' => 'required | image | mimes:png, jpg, jpeh, webp'
    //         ]);

    //         $image_name = Storage::disk('public')->put('images/product-images', $request->image);

    //         $path = Storage::url($image_name);


    //         return response()->json([
    //             'status' => 1,
    //             'message' => "Successfully.",
    //             'data' => $reaction
    //         ], 201);

    //     } catch (Exception $e) {
    //         return response()->json([
    //             'status' => 1,
    //             'message' => "Successfully.",
    //             'data' => $e
    //         ]);
    //     }
    // }


}
