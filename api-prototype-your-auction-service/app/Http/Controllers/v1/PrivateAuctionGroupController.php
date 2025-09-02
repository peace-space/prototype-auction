<?php

namespace App\Http\Controllers\v1;

use App\Events\PrivateAuctionAdminEvent;
use App\Events\PrivateAuctionListAdminEvent;
use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Database\Query\JoinClause;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class PrivateAuctionGroupController extends Controller
{
    public function privateAuctionsGroup($id_users)
    {
        try {

            $get_private_auction_group = DB::table('private_auction_groups')
                ->select(
                    'private_auction_groups.id_private_auction_groups',
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
                )
                ->join('auctions', function (JoinClause $join) {
                    $join->on('auctions.id_auctions', '=', 'private_auction_groups.id_auctions');
                })
                ->join('products', function (JoinClause $join) {
                    $join->on('products.id_products', '=', 'auctions.id_products');
                })
                ->join('images', function (JoinClause $join) {
                    $join->on('images.id_images', '=', 'products.id_images');
                })
                ->where('private_auction_groups.id_users', '=', $id_users)
                ->where('auctions.auction_status', '=', true)
                ->where('auctions.id_auction_types', '=', 2)
                ->orderByDesc('auctions.id_auctions')
                ->get();
            // return "TT";
            return response()->json([
                'status' => 1,
                'message' => "Successfully.",
                'data' => $get_private_auction_group
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => "Error.",
                'data' => $e
            ], 500);
        }
    }

    public function bidderList($id_auctions)
    {
        try {


            $bidder_data = DB::table('private_auction_groups')
                ->select(
                    'private_auction_groups.id_private_auction_groups',
                    'users.id_users',
                    'users.first_name_users',
                    'users.last_name_users',
                    'users.phone'
                )
                ->join('users', function (JoinClause $join) {
                    $join->on('users.id_users', '=', 'private_auction_groups.id_users');
                })
                ->where('id_auctions', '=', $id_auctions)
                ->get();

            return response()->json([
                'status' => 1,
                'message' => "Successfully.",
                'data' => $bidder_data
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => "Error.",
                'data' => $e
            ], 500);
        }
    }

    public function addBidder(Request $request)
    {
        try {
            $email = $request->email;
            $password = $request->password;

            $request->validate([
                'email' => 'required',
                'password' => 'required',
                'id_auctions' => 'required',
                'phone_bidder' => 'required'
            ]);

            $verify_password = DB::table('users')
                ->select(
                    'id_users',
                    'first_name_users',
                    'last_name_users',
                    'phone',
                    'address',
                    'email',
                    'admin_status',
                    'password'
                )
                ->where('email', '=', $request->email)
                ->first();

            if ($verify_password == true && Hash::check($password, $verify_password->password)) {

                $check_phone_bidder = DB::table('users')
                    ->select('*')
                    ->where('phone', '=', $request->phone_bidder)
                    ->first();

                // return $check_phone_bidder->id_users;

                if ($check_phone_bidder != '') {
                    // return "AA";
                    $check_bidder = DB::table('private_auction_groups')
                        ->select('*')
                        ->where('id_users', '=', $check_phone_bidder->id_users)
                        ->where('id_auctions', '=', $request->id_auctions)
                        ->get();
                    // return $check_bidder;
                    // return count($check_bidder);

                    if (
                        count($check_bidder) == 0
                    ) {
                        $bidder_data = [
                            'id_users' => $check_phone_bidder->id_users,
                            'id_auctions' => $request->id_auctions,
                        ];

                        $add_bidder = DB::table('private_auction_groups')
                            ->insert($bidder_data);

                        return response()->json([
                            'status' => 1,
                            'message' => 'Successfully.',
                            // 'data' => ''
                        ], 201);
                    } else {
                        return response()->json([
                            'status' => 0,
                            'message' => 'ผู้ใช้งานอยู่ในกลุ่มประมูลส่วนตัวแล้ว',
                            // 'data' => ''
                        ], 404);
                    }
                } else {
                    return response()->json([
                        'status' => 0,
                        'message' => 'ไม่มีบัญชีผู้ใช้งาน',
                        // 'data' => ''
                    ], 404);
                }
            } else {
                return response()->json([
                    'status' => 0,
                    'message' => 'ไม่มีข้อมูล'
                ], 500);
            }

            return response()->json([
                'status' => 1,
                'message' => "Successfully.",
                'data' => $bidder_data
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => "Error.",
                'data' => $e
            ], 500);
        }
    }

    public function deleteBidder(Request $request)
    {
        try {
            $request->validate([
                'email' => 'required',
                'password' => 'required',
                'id_private_auction_groups' => 'required',
            ]);

            $verify_password = DB::table('users')
                ->select(
                    'id_users',
                    'first_name_users',
                    'last_name_users',
                    'phone',
                    'address',
                    'email',
                    'admin_status',
                    'password'
                )
                ->where('email', '=', $request->email)
                ->first();

            if ($verify_password == true && Hash::check($request->password, $verify_password->password)) {

                $delete_bidder = DB::table('private_auction_groups')
                    ->where('id_private_auction_groups', '=', $request->id_private_auction_groups)
                    ->delete();

                return response()->json([
                    'status' => 1,
                    'message' => 'Successfully.',
                    // 'data' => ''
                ], 200);
            } else {
                return response()->json([
                    'status' => 0,
                    'message' => 'ไม่มีข้อมูล'
                ], 500);
            }


            return response()->json([
                'status' => 1,
                'message' => "Successfully.",
                'data' => $bidder_data
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => "Error.",
                'data' => $e
            ], 500);
        }
    }

public function privateAuctionAdmin()
    {
        try {

            $get_private_auction_group = DB::table('private_auction_groups')
                ->select(
                    'private_auction_groups.id_private_auction_groups',
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
                ->join('auctions', function (JoinClause $join) {
                    $join->on('auctions.id_auctions', '=', 'private_auction_groups.id_auctions');
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
                ->where('auctions.auction_status', '=', true)
                ->where('auctions.id_auction_types', '=', 2)
                ->orderByDesc('auctions.id_auctions')
                ->get();

               event(new PrivateAuctionListAdminEvent($get_private_auction_group));

            return response()->json([
                'status' => 1,
                'message' => "Successfully.",
                'data' => $get_private_auction_group
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

