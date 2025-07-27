<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Database\Query\JoinClause;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ChatRoomController extends Controller
{
    public function chatRooms($id_users_sender) {
        try {
            $chat_list = DB::table('chat_rooms')
                                // ->select('id_chat_rooms', 'id_users_chat_1', 'id_users_chat_2', 'created_at')
                                ->select('*')
                                // ->where('id_users_chat_2', '=', $id_users, 'and',
                                ->join('users', function(JoinClause $join) {
                                    $join->on('users.id_users', '=', 'chat_rooms.id_users_chat_2');
                                })                               //         'id_users_chat_1', '=', $id_users_sender)
                                ->where('id_users_chat_1', '=', $id_users_sender)
                                // ->where('id_users_chat_2', '=', $id_users)
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
              'id_users_chat_2' => 'required'
            ]);


            $check_chat_rooms = DB::table('chat_rooms')
                                        ->select('*')
                                        ->where('id_users_chat_1', $request->id_users_chat_1)
                                        ->where('id_users_chat_2', $request->id_users_chat_2)
                                        ->first();

            if ($check_chat_rooms == '') {

                $chat_rooms_data = [
                    'id_users_chat_1' => $request->id_users_chat_1,
                    'id_users_chat_2' => $request->id_users_chat_2
                ];

                $create_chat_room = DB::table('chat_rooms')
                                        ->insert($chat_rooms_data);

                $check_chat_rooms = DB::table('chat_rooms')
                                        ->select('*')
                                        ->where('id_users_chat_1', $request->id_users_chat_1)
                                        ->where('id_users_chat_2', $request->id_users_chat_2)
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
