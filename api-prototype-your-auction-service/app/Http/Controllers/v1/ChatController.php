<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Database\Query\JoinClause;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ChatController extends Controller
{
    public function chat($id_chat_rooms) {
        try {
            // return $id_chat_rooms;
            $chat_list = DB::table('chats')
                                ->select('*')
                                ->where('id_chat_rooms', '=', $id_chat_rooms)
                                ->join('users', function(JoinClause $join) {
                                    $join->on('users.id_users')
                                })
                                ->get();
            return response()->json([
                'status' => 1,
                'message' => 'Successfully.',
                'data' => $chat_list
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => 'Error.',
                'data' => $e,
            ], 500);
        }
    }

    public function sendMessage(Request $request) {
        try {
            $request->validate([
                'id_chat_rooms' => 'required',
                'id_users_sender' => 'required',
                'message' => 'nullable',
                'image_in_chats' => 'nullable',
            ]);

            $message_data_model = [
                'id_chat_rooms' => $request->id_chat_rooms,
                'id_users_sender' => $request->id_users_sender,
                'message' => $request->message,
            ];

            if ($request->image_in_chats != '') {
                $message_data_model['message'] = null;
            }

            // if ()

            // $message_data_model['aaa'] = 'dasdasdada';

            // return $message_data_model;

            $save_chat = DB::table('chats')->insert($message_data_model);

            return response()->json([
                'status' => 1,
                'message' => 'Successfully.',
                // 'data' => $chat_list
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => 'Error.',
                'data' => $e,
            ], 500);
        }
    }
}
