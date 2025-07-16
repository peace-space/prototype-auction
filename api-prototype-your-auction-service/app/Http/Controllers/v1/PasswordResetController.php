<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use App\Mail\ForgotPasswordMail;
use App\Mail\MessageMail;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Str;

class PasswordResetController extends Controller
{
    public function forgotPassword(Request $request)
    {
        try {

            $request->validate([
                'email' => 'required',
            ]);

            $token = Str::random(6);

            $data_for_password_reset = [
                'email' => $request->email,
                'token' => $token,
            ];

            $insert_token_for_password_reset = DB::table('password_resets')
                ->insert($data_for_password_reset);

            // view('forgot-password', ['token' => $token]);

            Mail::to($request->email)->send(new ForgotPasswordMail($token));

            // return "AAA";
            return response()->json([
                'status' => 1,
                'message' => "Successfully.",
                // 'data' => $request->email,
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => 'ERROR.',
                'data' => $e,
            ], 500);
        }
    }

    public function passwordReset(Request $request)
    {

        try {
            $request->validate([
                'email' => 'required',
                'password' => 'required',
                'token_for_password_reset' => 'required'
            ]);


            $check_token_and_email = DB::table('password_resets')
                ->select('*')
                ->where(
                    'token', '=', $request->token_for_password_reset, 'and',
                    'email', '=', $request->email
                )->first();

                // return $check_token_and_email;
            if ($check_token_and_email == true) {
                $password_hashed = Hash::make($request->password);

                $data_for_password_reset = [
                    'password' => $password_hashed,
                ];

                // return $request->email;

                $on_password_reset = DB::table('users')
                    ->where('email', '=', $request->email)
                    ->update($data_for_password_reset);

                $delete_token = DB::table('password_resets')
                    ->where('email', '=', $check_token_and_email->email)
                    ->delete();

                $topic = "แจ้งเตือน";
                $message = "เปลี่ยนรหัสผ่านสำเร็จแล้ว";

                Mail::to($request->email)->send(new MessageMail($topic, $message));

                return response()->json([
                    'status' => 1,
                    'message' => "Successfully.",
                    // 'data' => '',
                ], 201);
            } else {
                return response()->json([
                    'status' => 0,
                    'message' => 'ไม่มีคำร้องขอกู้คืนรหัสผ่าน',
                    // 'data' => ''
                ], 404);
            }
        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => 'message',
                'data' => $e,
            ], 500);
        }
        // return "sss";
    }
}
