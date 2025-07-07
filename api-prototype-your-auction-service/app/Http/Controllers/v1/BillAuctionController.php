<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Database\Query\JoinClause;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class BillAuctionController extends Controller
{
    public function billAuction($id_bill_result)
    {
        try {
            $bill_auction = DB::table('bill_auctions')
                ->select('*')
                ->join('result_auctions', function (JoinClause $join) {
                    $join->on('result_auctions.id_result_auctions', '=', 'bill_auctions.id_result_auctions');
                })
                ->join('bids', function (JoinClause $join) {
                    $join->on('bids.id_bids', '=', 'result_auctions.id_bids');
                })
                ->join('auctions', function (JoinClause $join) {
                    $join->on('auctions.id_auctions', '=', 'bids.id_auctions');
                })
                ->join('products', function (JoinClause $join) {
                    $join->on('products.id_products', '=', 'auctions.id_products');
                })
                ->join('images', function (JoinClause $join) {
                    $join->on('images.id_images', '=', 'products.id_images');
                })
                ->join('users', function (JoinClause $join) {
                    $join->on('users.id_users', '=', 'products.id_users');
                })
                ->join('bank_accounts', function (JoinClause $join) {
                    $join->on('bank_accounts.id_users', '=', 'products.id_users');
                })

                ->where('bill_auctions.id_bill_auctions', '=', $id_bill_result)
                ->get();

            // return $bill_auction;
            $ion =  $bill_auction->first();

            // return $ion;
            $images_model = [];
            // return $ion;

            if ($ion->image_path_1 != null) {
                array_push($images_model, $ion->image_path_1);
            }
            if ($ion->image_path_2 != null) {
                array_push($images_model, $ion->image_path_2);
            }
            if ($ion->image_path_3 != null) {
                array_push($images_model, $ion->image_path_3);
            }
            if ($ion->image_path_4 != null) {
                array_push($images_model, $ion->image_path_4);
            }
            if ($ion->image_path_5 != null) {
                array_push($images_model, $ion->image_path_5);
            }
            if ($ion->image_path_6 != null) {
                array_push($images_model, $ion->image_path_6);
            }
            if ($ion->image_path_7 != null) {
                array_push($images_model, $ion->image_path_7);
            }
            if ($ion->image_path_8 != null) {
                array_push($images_model, $ion->image_path_8);
            }
            if ($ion->image_path_9 != null) {
                array_push($images_model, $ion->image_path_9);
            }
            if ($ion->image_path_10 != null) {
                array_push($images_model, $ion->image_path_10);
            }

            // return $images_model;


            // $bill_auction_model = [
            //     'id_bill_auctions' => $ion->id_bill_auctions,
            //     // 'id_'

            // ];

            return response()->json([
                'status' => 1,
                'message' => 'Successfully.',
                // 'test' => $bill_auction,
                'data' => $bill_auction,
                'images' => $images_model,
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => 'Error.',
                'data' => $e
            ], 404);
        }
    }


    public function insertReceiptBillAuction(Request $request) {
        try {
            $payment_proof_images_1 = $request->payment_proof_images_path_1;
            $payment_proof_images_2 = $request->payment_proof_images_path_2;
            $id_result_auctions = $request->id_result_auctions;
            $id_auctions = $request->id_auctions;

            if ($payment_proof_images_1 != null) {
                $image_name_1 = Storage::disk('public')->put('images/payment-proof-images', $payment_proof_images_1);
                $image_path_1 = Storage::url($image_name_1);
            } else {
                $image_path_1 = null;
            }

            if ($payment_proof_images_2 != null) {
                $image_name_2 = Storage::disk('public')->put('images/payment-proof-images', $payment_proof_images_2);
                $image_path_2 = Storage::url($image_name_2);
            } else {
                $image_path_2 = null;
            }

            $image_model = [
                'payment_proof_images_path_1' => $image_path_1,
                'payment_proof_images_path_2' => $image_path_2,
            ];

            $save_images = DB::table('payment_proof_images')
                    ->insert($image_model);

            $last_time_image = DB::table('payment_proof_images')
                    ->select(DB::raw('MAX(created_at) as last_time'))
                    ->get();

            $last_id_image = DB::table('payment_proof_images')
                    ->select('id_payment_proof_images')
                    ->where('created_at', '=', $last_time_image[0]->last_time)
                    ->get();
            $id_payment_proof_images = $last_id_image[0]->id_payment_proof_images;
            // return $id_result_auctions;

            $update_data = [
                'id_payment_proof_images' => $id_payment_proof_images,
                'id_payment_status_types' => 2,
            ];

            $update_image_in_bill_auctions = DB::table('bill_auctions')
                    ->where('id_result_auctions', '=', $id_result_auctions)
                    ->update($update_data);

            $update_payment_status_types_auction = DB::table('auctions')
                                                ->where('id_auctions', '=', $id_auctions)
                                                ->update(['id_payment_status_types' => 2]);

          return response()->json([
            'status' => 1,
            'message' => 'Successfully.',
            // 'data' => '',
          ], 201);


        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => 'Error.',
                'data' => $e
            ]);
        }
    }


    public function myAuctionBill($id_auctions)
    {
        try {
            // return "AAA";
            $my_auction_bill = DB::table('bill_auctions')
                ->select('*')
                ->join('result_auctions', function (JoinClause $join) {
                    $join->on('result_auctions.id_result_auctions', '=', 'bill_auctions.id_result_auctions');
                })
                ->join('bids', function (JoinClause $join) {
                    $join->on('bids.id_bids', '=', 'result_auctions.id_bids');
                })
                ->join('payment_proof_images', function (JoinClause $join) {
                    $join->on('payment_proof_images.id_payment_proof_images', '=', 'bill_auctions.id_payment_proof_images');
                })
                ->join('users', function (JoinClause $join) {
                    $join->on('users.id_users', '=', 'result_auctions.id_users');
                })
                ->where('bids.id_auctions', '=', $id_auctions)
                ->get();

            $my_auction_detail = DB::table('auctions')
                                    ->join('products', function (JoinClause $join) {
                                        $join->on('products.id_products', '=', 'auctions.id_products');
                                    })
                                    ->join('images', function (JoinClause $join) {
                                        $join->on('images.id_images', '=', 'products.id_images');
                                    })
                                    ->join('bank_accounts', function (JoinClause $join) {
                                        $join->on('bank_accounts.id_bank_accounts', '=', 'auctions.id_bank_accounts');
                                    })
                                    ->where('auctions.id_auctions', '=', $id_auctions)
                                    ->get();

            $get_images = $my_auction_detail[0];
            $images_model = [];
            // return $ion;

            if ($get_images->image_path_1 != null) {
                array_push($images_model, $get_images->image_path_1);
            }
            if ($get_images->image_path_2 != null) {
                array_push($images_model, $get_images->image_path_2);
            }
            if ($get_images->image_path_3 != null) {
                array_push($images_model, $get_images->image_path_3);
            }
            if ($get_images->image_path_4 != null) {
                array_push($images_model, $get_images->image_path_4);
            }
            if ($get_images->image_path_5 != null) {
                array_push($images_model, $get_images->image_path_5);
            }
            if ($get_images->image_path_6 != null) {
                array_push($images_model, $get_images->image_path_6);
            }
            if ($get_images->image_path_7 != null) {
                array_push($images_model, $get_images->image_path_7);
            }
            if ($get_images->image_path_8 != null) {
                array_push($images_model, $get_images->image_path_8);
            }
            if ($get_images->image_path_9 != null) {
                array_push($images_model, $get_images->image_path_9);
            }
            if ($get_images->image_path_10 != null) {
                array_push($images_model, $get_images->image_path_10);
            }

            // return $get_images;

            $image_bill = $my_auction_bill[0];

            $data_model_bill = [
                'data' => $my_auction_bill[0],
                'image_bill' => [
                    $image_bill->payment_proof_images_path_1,
                    $image_bill->payment_proof_images_path_2,
                ]
            ];

            $data_model = [
                'data_auction' => $my_auction_detail[0],
                'data_bill' => $data_model_bill,
                'images' => $images_model,
            ];
            return response()->json([
                'status' => 1,
                'message' => 'Successfully.',
                'data' => $data_model,
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => 'Error.',
                'data' => $e
            ], 404);
        }
    }


    public function confirmVerification() {
        return "AAA";
    }
}
