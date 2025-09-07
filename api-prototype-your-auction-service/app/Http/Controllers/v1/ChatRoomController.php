<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Database\Query\JoinClause;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ChatRoomController extends Controller
{
    public function chatRooms($id_users_sender, $id_products) {
        try {
            $chat_list = DB::table('chat_rooms')
                                // ->select('id_chat_rooms', 'id_users_chat_1', 'id_users_chat_2', 'created_at')
                                ->select('*')
                                // ->where('id_users_chat_2', '=', $id_users, 'and',
                                ->join('products', function(JoinClause $join) {
                                    $join->on('products.id_products', '=', 'chat_rooms.id_products');
                                })
                                ->join('product_types', function(JoinClause $join) {
                                    $join->on('product_types.id_product_types', '=', 'products.id_product_types');
                                })
                                // ->join('users', function(JoinClause $join) {
                                    // $join->on('users.id_users', '=', 'chat_rooms.id_users_chat_2');
                                // })                               //         'id_users_chat_1', '=', $id_users_sender)
                                ->join('auctions', function(JoinClause $join) {
                                    $join->on('auctions.id_products', '=', 'products.id_products');
                                })
                                ->join('images', function(JoinClause $join) {
                                    $join->on('images.id_images', '=', 'products.id_images');
                                })
                                // ->where('id_users_chat_2', '=', $id_users_sender, 'OR', 'id_users_chat_1', '=', $id_users_sender)
                                // ->where('products.id_products', '=', $id_products)
                                ->where('id_users_chat_2', '=', $id_users_sender)
                                ->where('auctions.auction_status', '=', false)
                                ->orWhere('id_users_chat_1', '=', $id_users_sender)
                                // ->where('id_users_chat_2', '=', $id_users_sender)
                                ->get();

            return response()->json([
                'status' => 1,
                'message' => "Successfully",
                'data' => $chat_list
            ], 200);

        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => "Error.",
                'data' => $e
            ], 500);
        }
    }

    public function createChatRooms(Request $request) {
        try {
            $request->validate([
              'id_users_chat_1' => 'required',
              'id_users_chat_2' => 'required',
              'id_products' => 'required'
            ]);

            // return "AA";
            $check_chat_rooms = DB::table('chat_rooms')
                                        ->select('*')
                                        ->where('id_users_chat_1', $request->id_users_chat_1)
                                        ->where('id_users_chat_2', $request->id_users_chat_2)
                                        ->where('id_products', '=', $request->id_products)
                                        ->first();
            // return $check_chat_rooms;
            if ($check_chat_rooms == '') {

                $chat_rooms_data = [
                    'id_users_chat_1' => $request->id_users_chat_1,
                    'id_users_chat_2' => $request->id_users_chat_2,
                    'id_products' => $request->id_products,
                ];

                $create_chat_room = DB::table('chat_rooms')
                                        ->insert($chat_rooms_data);

                $check_chat_rooms = DB::table('chat_rooms')
                                        ->select('*')
                                        ->where('id_users_chat_1', $request->id_users_chat_1)
                                        ->where('id_users_chat_2', $request->id_users_chat_2)
                                        ->where('id_products', $request->id_products)
                                        ->first();

                return response()->json([
                    'status' => 1,
                    'message' => "Successfully.",
                    'data' => $check_chat_rooms,
                ], 200);
            }

            return response()->json([
                'status' => 1,
                'message' => "Successfully.",
                'data' => $check_chat_rooms,
            ], 200);
        } catch (Exception $e) {
            return response()->josn([
                'status' => 0,
                'message' => 'Error.',
                'data' => $e
            ], 500);
        }
    }
}
