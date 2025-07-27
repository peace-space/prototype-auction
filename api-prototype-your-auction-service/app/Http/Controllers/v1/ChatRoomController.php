<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ChatRoomController extends Controller
{
    public function chatRooms($id_users_sender) {
        try {
            $chat_list = DB::table('chat_rooms')
                                ->select('id_chat_rooms', 'id_users_chat_1', 'id_users_chat_2', 'created_at')
                                // ->where('id_users_chat_2', '=', $id_users, 'and',
                                //         'id_users_chat_1', '=', $id_users_sender)
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
}
