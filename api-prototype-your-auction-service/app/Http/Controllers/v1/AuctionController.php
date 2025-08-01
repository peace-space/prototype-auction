<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\algorithm\RunAuctionSystem;
use App\Http\Controllers\Controller;
use App\Http\Controllers\v1\BidController;
use App\Models\ResultReportAuction;
use Carbon\Carbon;
use DateTime;
use Exception;
use Illuminate\Database\Query\JoinClause;
use Illuminate\Http\Request;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\Storage;

class AuctionController extends Controller
{
    public function index()
    {
        try {

            $run_auction_system = new RunAuctionSystem();

            $run_auction_system->runAuctionSystem();

            $auctions_list = DB::table('auctions')
                ->select(
                    'auctions.id_auctions',
                    'auctions.auction_status',
                    'auctions.shipping_cost',
                    'auctions.start_price',
                    'auctions.end_date_time',
                    'auctions.max_price',
                    'auctions.id_auction_types',
                    'auctions.id_payment_types',
                    'auctions.id_bank_accounts',
                    'products.id_products',
                    'products.name_product',
                    'images.image_path_1',
                    'users.id_users',
                    'users.first_name_users',
                    'users.last_name_users',
                )
                ->join('products', function (JoinClause $join) {
                    $join->on('auctions.id_products', '=', 'products.id_products');
                })
                ->join('images', function (JoinClause $join) {
                    $join->on('images.id_images', '=', 'products.id_images');
                })
                ->join('users', function (JoinClause $join) {
                    $join->on('users.id_users', '=', 'products.id_users');
                })
                ->where('auctions.auction_status', '=', true)
                ->where('id_auction_types', '=', 1)
                // ->orderByRaw('id_auctions')
                ->orderByDesc('id_auctions')
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

    public function addImageForProduct()
    {
        // Schema::table('auctions', function($table){
        //     $table->string('test');
        // });
    }

    public function deleteImageForProduct()
    {
        // Schema::table('auctions', function($table){
        //     $table->dropColumn('test');
        // });
    }

    public function createProduct(Request $request)
    {
        try {
            if (
                $request->id_users != null
                && $request->name_product != ''
                && $request->detail_product != ''
                && $request->start_price != ''
                && $request->end_date_time != ''
                && $request->id_product_types != ''
                && $request->id_auction_types != ''
            ) {

                $request_data = [
                    'id_users' => $request->id_users,
                    'id_product_types' => $request->id_product_types,
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
                    'id_product_types' => $request_data['id_product_types'],
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
                    'id_payment_status_types' => 1,
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

                if ($request->id_auction_types == 2) {
                    $private_auction_groups_data = [
                        'id_auctions' => $reAction->id_auctions,
                        'id_users' => $request->id_users,
                    ];

                    $create_private_auction_group = DB::table('private_auction_groups')
                                                    ->insert($private_auction_groups_data);
                }

                return response()->json([
                    'status' => 1,
                    'message' => "Successfully.",
                    'data' => $reAction->last()
                ], 201);
            } else {
                return response()->json([
                    'status' => 0,
                    'message' => "Not Data",
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

    public function myAuctions($id_user)
    {
        try {
            // return "A";
            $my_auctions = DB::table('auctions')
                ->select(
                    '*',
                )
                ->join('products', function (JoinClause $join) {
                    $join->on('products.id_products', '=', 'auctions.id_products');
                })
                ->join('images', function (JoinClause $join) {
                    $join->on('images.id_images', '=', 'products.id_images');
                })
                // ->join('bids', function (JoinClause $join) {
                //     $join->on('bids.id_auctions', '=', 'auctions.id_auctions');
                // })
                // ->join('result_auctions', function (JoinClause $join) {
                //     $join->on('result_auctions.id_bids', '=', 'bids.id_bids');
                // })
                ->orderByRaw('id_auctions')
                ->where('products.id_users', '=', $id_user)
                ->get();
            // return "AA";
            // return $my_auctions[0]->id_auctions;

            // if ($request->image_1 != null) {
            //     if ($request->image_1 != null) {
            //         $image_name_1 = Storage::disk('public')->put('images/product-images', $request->image_1);
            //         $image_path_1 = Storage::url($image_name_1);
            //     } else {
            //         $image_path_1 = null;
            //     }

            //     if ($request->image_2 != null) {
            //         $image_name_2 = Storage::disk('public')->put('images/product-images', $request->image_2);
            //         $image_path_2 = Storage::url($image_name_2);
            //     } else {
            //         $image_path_2 = null;
            //     }

            //     if ($request->image_3 != null) {
            //         $image_name_3 = Storage::disk('public')->put('images/product-images', $request->image_3);
            //         $image_path_3 = Storage::url($image_name_3);
            //     } else {
            //         $image_path_3 = null;
            //     }

            //     if ($request->image_4 != null) {
            //         $image_name_4 = Storage::disk('public')->put('images/product-images', $request->image_4);
            //         $image_path_4 = Storage::url($image_name_4);
            //     } else {
            //         $image_path_4 = null;
            //     }

            //     if ($request->image_5 != null) {
            //         $image_name_5 = Storage::disk('public')->put('images/product-images', $request->image_5);
            //         $image_path_5 = Storage::url($image_name_5);
            //     } else {
            //         $image_path_5 = null;
            //     }

            //     if ($request->image_6 != null) {
            //         $image_name_6 = Storage::disk('public')->put('images/product-images', $request->image_6);
            //         $image_path_6 = Storage::url($image_name_6);
            //     } else {
            //         $image_path_6 = null;
            //     }

            //     if ($request->image_7 != null) {
            //         $image_name_7 = Storage::disk('public')->put('images/product-images', $request->image_7);
            //         $image_path_7 = Storage::url($image_name_7);
            //     } else {
            //         $image_path_7 = null;
            //     }

            //     if ($request->image_8 != null) {
            //         $image_name_8 = Storage::disk('public')->put('images/product-images', $request->image_8);
            //         $image_path_8 = Storage::url($image_name_8);
            //     } else {
            //         $image_path_8 = null;
            //     }

            //     if ($request->image_9 != null) {
            //         $image_name_9 = Storage::disk('public')->put('images/product-images', $request->image_9);
            //         $image_path_9 = Storage::url($image_name_9);
            //     } else {
            //         $image_path_9 = null;
            //     }

            //     if ($request->image_10 != null) {
            //         $image_name_10 = Storage::disk('public')->put('images/product-images', $request->image_10);
            //         $image_path_10 = Storage::url($image_name_10);
            //     } else {
            //         $image_path_10 = null;
            //     }
            // }

            // $image_model = [
            //     'image_path_1' => $image_path_1,
            //     'image_path_2' => $image_path_2,
            //     'image_path_3' => $image_path_3,
            //     'image_path_4' => $image_path_4,
            //     'image_path_5' => $image_path_5,
            //     'image_path_6' => $image_path_6,
            //     'image_path_7' => $image_path_7,
            //     'image_path_8' => $image_path_8,
            //     'image_path_9' => $image_path_9,
            //     'image_path_10' => $image_path_10,
            // ];
            return response()->json([
                'status' => 1,
                'message' => 'Successfully.',
                'data' => $my_auctions

            ]);
        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => 'Error.',
                'data' => $e
            ], 404);
        }
    }

    // public function myAuctionDetail($id_users)
    // {
    //     try {
    //         // return "AAA";
    //         $my_auction_detail = DB::table('auctions')
    //             ->select('*')
    //             ->join('products', function (JoinClause $join) {
    //                 $join->on('products.id_products', '=', 'auctions.id_products');
    //             })
    //             ->join('images', function (JoinClause $join) {
    //                 $join->on('images.id_images', '=', 'products.id_images');
    //             })
    //             ->join('bids', function (JoinClause $join) {
    //                 $join->on('bids.id_auctions', '=', 'auctions.id_auctions');
    //             })
    //             // ->join('result_auctions', function (JoinClause $join) {
    //             //     $join->on('result_auctions.id_bids', '=', 'bids.id_bids');
    //             // })
    //             ->join('users', function (JoinClause $join) {
    //                 $join->on('users.id_users', '=', 'products.id_users');
    //             })
    //             ->where('products.id_users', '=', $id_users)
    //             ->get();


    //         // return $my_auction_detail[0];
    //         $select_data_my_auctions = $my_auction_detail[0];

    //         // return $select_data_my_auctions;

    //         if ($select_data_my_auctions->id_payment_status_types == 2) {
    //             $my_bill_data = DB::table('bill_auctions')
    //                 ->select('*')
    //             ->join('payment_proof_images', function(JoinClause $join) {
    //                 $join->on('payment_proof_images.id_payment_proof_images', '=', 'bill_auctions.id_payment_proof_images');
    //             })
    //             ->join('result_auctions', function(JoinClause $join) {
    //                 $join->on('result_auctions.id_result_auctions', '=', 'bill_auctions.id_result_auctions');
    //             })
    //             ->join('bids', function(JoinClause $join) {
    //                 $join->on('bids.id_bids', '=', 'result_auctions.id_bids');
    //             })
    //             ->where('bids.id_auctions', '=', $select_data_my_auctions->id_auctions)
    //             ->get();
    //             // return "AA";
    //             // return $my_bill_data;
    //         }



    //         // return $select_data_my_auctions->payment_proof_images_path_1;

    //         // $payment_proof_images = [];

    //         // if ($select_data_my_auctions->payment_proof_images_path_1 != null) {
    //         //     array_push($payment_proof_images, $select_data_my_auctions->payment_proof_images_path_1);
    //         // } else {
    //         //    $payment_proof_images = 'null';
    //         // }
    //         // if ($select_data_my_auctions->payment_proof_images_path_2 != null) {
    //         //     array_push($payment_proof_images, $select_data_my_auctions->payment_proof_images_path_2);
    //         // } else {
    //         //    $payment_proof_images = 'null';
    //         // }

    //         $images_model = [];
    //         // return $select_data_my_auctions;

    //         if ($select_data_my_auctions->image_path_1 != null) {
    //             array_push($images_model, $select_data_my_auctions->image_path_1);
    //         }
    //         if ($select_data_my_auctions->image_path_2 != null) {
    //             array_push($images_model, $select_data_my_auctions->image_path_2);
    //         }
    //         if ($select_data_my_auctions->image_path_3 != null) {
    //             array_push($images_model, $select_data_my_auctions->image_path_3);
    //         }
    //         if ($select_data_my_auctions->image_path_4 != null) {
    //             array_push($images_model, $select_data_my_auctions->image_path_4);
    //         }
    //         if ($select_data_my_auctions->image_path_5 != null) {
    //             array_push($images_model, $select_data_my_auctions->image_path_5);
    //         }
    //         if ($select_data_my_auctions->image_path_6 != null) {
    //             array_push($images_model, $select_data_my_auctions->image_path_6);
    //         }
    //         if ($select_data_my_auctions->image_path_7 != null) {
    //             array_push($images_model, $select_data_my_auctions->image_path_7);
    //         }
    //         if ($select_data_my_auctions->image_path_8 != null) {
    //             array_push($images_model, $select_data_my_auctions->image_path_8);
    //         }
    //         if ($select_data_my_auctions->image_path_9 != null) {
    //             array_push($images_model, $select_data_my_auctions->image_path_9);
    //         }
    //         if ($select_data_my_auctions->image_path_10 != null) {
    //             array_push($images_model, $select_data_my_auctions->image_path_10);
    //         }

    //         return response()->json([
    //             'status' => 1,
    //             'message' => 'Successfully.',
    //             'data' => $my_auction_detail,
    //             'images' => $images_model,
    //             // 'payment_proof_images' => $payment_proof_images,
    //         ], 200);
    //     } catch (Exception $e) {
    //         return response()->json([
    //             'status' => 0,
    //             'message' => 'ERROR.',
    //             'data' => $e,
    //         ], 500);
    //     }
    // }



    public function historyProduct($id_users)
    {
        try {
            $auctions_list = DB::table('bids')
                ->select(
                    'bids.id_bids',
                    'auctions.id_auctions',
                    'images.id_images',
                    'products.name_product',
                    'images.image_path_1',
                    'auctions.shipping_cost',
                    'auctions.start_price',
                    'auctions.end_date_time',
                    'auctions.max_price',
                    'bids.created_at',
                    'bids.bid_price'
                )
                ->join('auctions', function (JoinClause $join) {
                    $join->on('auctions.id_auctions', '=', 'bids.id_auctions');
                })
                ->join('users', function (JoinClause $join) {
                    $join->on('users.id_users', '=', 'bids.id_users');
                })
                ->join('products', function (JoinClause $join) {
                    $join->on('products.id_products', '=', 'auctions.id_products');
                })
                ->join('images', function (JoinClause $join) {
                    $join->on('images.id_images', '=', 'products.id_images');
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

    public function onEndDateTime(Request $request)
    {
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

    public function closeAuctions() {
        return "TEST";
    }

//     public function test(Request $request)
//     {
//         try {

//             $test_date_time = DB::table('auctions')
//                             ->select('*')
//                             // ->where('id_auctions', '=', 1)
//                             ->get();
//             // return $test_date_time;
//             $end_date_time_auctions = Carbon::parse($test_date_time[0]->end_date_time, 'Asia/Bangkok');


//             $current_date_time = Carbon::now('Asia/Bangkok');

//             $end_date_time_auctions->toPeriod();

//             $data = [
//                 'test' => $end_date_time_auctions.' เปรียบเทียบ '.$current_date_time,
//                 'CurrentDateTime' => $current_date_time->toDateTimeString(),
//                 'EndDateTime' => $end_date_time_auctions->toDateTimeString(),
//             ];

//             $a = $this->test1($test_date_time);
//             return $a;

//             // return view('welcome', [

//             // ]));
//                 sleep(1);
//             if ($end_date_time_auctions <= $current_date_time) {


//                 return view('welcome', [
//                     'status' => 'หมดเวลา',
//                     'test' => $end_date_time_auctions->toDateTimeString().' น้อยกว่า '.$current_date_time->toDateTimeString(),
//                     'message' => 'end น้อยกว่า current',
//                     'data' => $data
//                 ]);

//                 return response()->json([
//                     'status' => 'หมดเวลา',
//                     'test' => $end_date_time_auctions->toDateTimeString().' น้อยกว่า '.$current_date_time->toDateTimeString(),
//                     'message' => 'end น้อยกว่า current',
//                     'data' => $data
//                 ], 200);
//             } else {

//                 return view('welcome', [
//                     'status' => $end_date_time_auctions->toDateTimeString(),
//                     'test' => $end_date_time_auctions->toDateTimeString().' มากกว่า '.$current_date_time->toDateTimeString(),
//                     'message' => 'end มากกว่า current',
//                     'data' => $data
//                 ]);

//                 return response()->json([
//                     'status' => $end_date_time_auctions->toDateTimeString(),
//                     'test' => $end_date_time_auctions->toDateTimeString().' มากกว่า '.$current_date_time->toDateTimeString(),
//                     'message' => 'end มากกว่า current',
//                     'data' => $data
//                 ], 200);
//             }


//             // dd($diff_in_hours);
//             return $diff_in_hours;
//         } catch (Exception $e) {
//             return response()->json([
//                 'status' => 0,
//                 'message' => "Error",
//                 'data' => $e
//             ]);
//         }
//     }

//  public function test1($data) {
//         $newData = [];
//         // $count = 0;
//         if ($data != '') {
//             foreach ($data as $d) {
//                 // return $d->end_date_time;
//                 $end_date_time_auctions = Carbon::parse($d->end_date_time, 'Asia/Bangkok');
//                 $current_date_time = Carbon::now('Asia/Bangkok');

//                 if ($end_date_time_auctions <= $current_date_time) {
//                     // $count += 1;
//                     // return $d->id_auctions;
//                     $auctions_timeout = DB::table('auctions')
//                                             ->where('id_auctions', '=', $d->id_auctions)
//                                             ->update(['auction_status' => false]);

//                     array_push($newData, $auctions_timeout);

//                     // return $count;
//                 }

//             }
//                 // return $count;
//                 return $newData;
//         }

//         return $data;

//     }

}


