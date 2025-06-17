<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use App\Http\Controllers\v1\BidController;
use App\Models\ResultReportAuction;
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

            // $high_bit = DB::table('bids')
            //                     ->select('id_users', 'id_auctions', 'bid_price')
            //                     ->where('id_auctions', '=', $id_auctions)
            //                     ->orderByDesc('bid_price')
            //                     ->get();
            // $counter = 0;
            // for ($i = 0; $i < count($auctions_list); $i++) {
            //     $counter += $i;
            // }

            // return $counter;

            // highBids();

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
            if(
                $request->id_users != null
                && $request->name_product != ''
                && $request->detail_product != ''
                && $request->start_price != ''
                && $request->end_date_time != ''
            ) {

                $request_data = [
                    'id_users' => $request->id_users,
                    'name_product' => $request->name_product,
                    'detail_product' => $request->detail_product,
                    'shipping_cost' => $request->shipping_cost,
                    'start_price' => $request->start_price,
                    'end_date_time' => $request->end_date_time,
                    'id_auction_types' => $request->id_auction_types,
                    'id_payment_types' => $request->id_payment_types,
                    'id_bank_accounts' => $request->id_bank_accounts,
                ];

                if ($request->image_1 != null) {
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
                }

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

                $product_data = [
                    'id_users' => $request_data['id_users'],
                    'name_product' => $request_data['name_product'],
                    'detail_product' => $request_data['detail_product'],
                    'id_images' => $last_id_image[0]->id_images,
                ];

                $save_product = DB::table('products')->insert($product_data);

                $product = DB::table('products')
                                    ->select('id_products')
                                    ->where('id_users', '=', $request_data['id_users'])
                                    ->orderByDesc('created_at')
                                    ->get();

                // return $product->first();

                $product = $product->first();
                // return $product;

                $current_highest_price = $request_data['start_price'];

                // return $current_highest_price;

                $auction_data = [
                    'id_products' => $product->id_products,
                    'auction_status' => 1,
                    'shipping_cost' => $request_data['shipping_cost'],
                    'start_price' => $request_data['start_price'],
                    'end_date_time' => $request_data['end_date_time'],
                    'max_price' => $current_highest_price,
                    'id_auction_types' => $request_data['id_auction_types'],
                    'id_payment_types' => $request_data['id_payment_types'],
                    'id_bank_accounts' => $request_data['id_bank_accounts']
                ];

                // return $auction_data;

                $create_auction = DB::table('auctions')
                                        ->insert($auction_data);

                $reAction = DB::table('products')
                                ->select('*')
                                ->join('images', 'products.id_images', '=', 'images.id_images')
                                // ->orderByDesc('auctions.id_auctions')
                                // ->where('auctions.id_users', '=', $data['id_users'], '&',
                                //         'auctions.created_at', '=', $last_time_auction[0]->last_time)
                                ->get();


                return response()->json([
                    'status' => 1,
                    'message' => "Successfully.",
                    'data' => $reAction->last()
                ], 201);
            } else {
                return response()->json([
                    'status' => 0,
                    'message' => "Not Data",
                ]);
            }
        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => "Error.",
                'data' => $e
            ]);
        }
    }

    public function userProduct($id_user) {
        try {
            $user_product = DB::table('auctions')
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
                    ->where('id_users', '=', $id_user)
                    ->get();

        return response()->json([
            'status' => 1,
            'message' => 'Successfully.',
            'data' => $user_product
        ]);


        } catch(Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => 'Error.',
                'data' => $e
            ], 404);
        }
    }

    public function userProductDelete($id_user, $id_auctions) {
        try {
            $user_product_delete = DB::table('auctions')
            ->where('id_auctions', '=', $id_auctions, 'and', 'id_users', '=', $id_user)
            ->delete();

            if ($user_product_delete) {
                return response()->json([
                    'status' => 1,
                    'message' => "Successfully."
                ], 200);
            } else {
                return response()->json([
                    'status' => 0,
                    'message' => "ไม่มีสินค้าในฐานข้อมูล"
                ], 404);
            }
        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => "Error.",
                'data' => $e
            ], 500);
        }
    }

    public function historyProduct($id_users) {
        try{
            $auctions_list = DB::table('bids')
                                ->select('auctions.id_auctions', 'images.id_images',
                                            'auctions.name_product', 'images.image_path_1',
                                            'auctions.shipping_cost', 'auctions.start_price',
                                            'auctions.start_date_time', 'auctions.end_date_time',
                                            'auctions.max_price', 'bids.created_at',
                                            'bids.bid_price'
                                            )
                                ->join('auctions', function(JoinClause $join){
                                    $join->on('auctions.id_auctions', '=', 'bids.id_auctions');
                                })
                                ->join('users', function(JoinClause $join){
                                        $join->on('users.id_users', '=', 'bids.id_users');
                                    })->join('images', function(JoinClause $join){
                                        $join->on('images.id_images', '=', 'auctions.id_images');
                                    })
                                ->orderByDesc('created_at')
                                ->where('bids.id_users', '=', $id_users)
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

    public function onEndDateTime(Request $request) {
        try {
                $id_users = $request->id_users;
                $id_bids = $request->id_bids;
                $id_auctions = $request->id_auctions;
                $payment_status = $request->payment_status;
                $shipping_number = $request->shipping_number;
                $delivery_status = $request->delivery_status;
                $id_auction_types = $request->id_auction_types;
                $id_payment_types = $request->id_payment_types;
                $bank_account_number = $request->bank_account_number;

            if ($payment_status == '') {
                $payment_status = false;
            }

            if ($shipping_number == null) {
                $shipping_number = '';
            }

            if ($delivery_status == null) {
                $delivery_status = false;
            }

            if ($id_auction_types == null) {
                $id_auction_types = 0;
            }

            if ($id_payment_types == null) {
                $id_payment_types = 0;
            }

            if ($bank_account_number == null) {
                $bank_account_number = '';
            }


            $data = [
                'id_users' => $id_users,
                'id_bids' => $id_bids,
                'id_auctions' => $id_auctions,
                'payment_status' => $payment_status,
                'shipping_number' => $shipping_number,
                'delivery_status' => $delivery_status,
                'id_auction_types' => $id_auction_types,
                'id_payment_types' => $id_payment_types,
                'bank_account_number' => $bank_account_number,
            ];
            // return $data;
            $save_result_report_auction = DB::table('result_report_auctions')
                                            ->insert($data);


            if ($save_result_report_auction == true) {
                return response()->json([
                    'status' => 1,
                    'message' => 'Successfully.',
                    'data' => $data
                ], 201);
            } else {
                return response()->json([
                    'status' => 0,
                    'message' => 'Error.',
                    'data' => 'มีข้อผิดพลาดในการบันทึกข้อมูล'
                ], 404);
            }

        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => 'Error.',
                'data' => $e
            ], 404);
        }
    }

    public function test(Request $request) {
        try {
            // $request->validate([
            //     'image' => 'required | image | mimes:png, jpg, jpeh, webp'
            // ]);

            if ($request->image != null && $request->image != '') {
                $image_name = Storage::disk('public')->put('images/product-images', $request->image);

                $path = Storage::url($image_name);


                return response()->json([
                    'status' => 1,
                    'message' => "Successfully.",
                ], 201);
            } else {
                return response()->json([
                    'status' => 0,
                    'message' => "Error.",
                ]);
            }

        } catch (Exception $e) {
            return response()->json([
                'status' => 1,
                'message' => "Successfully.",
                'data' => $e
            ]);
        }
    }


}
