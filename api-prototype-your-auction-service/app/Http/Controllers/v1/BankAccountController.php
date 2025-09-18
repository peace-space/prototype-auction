<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class BankAccountController extends Controller
{

    public function createBankAccount(Request $request)
    {
        try {

            $bank_account_data = $request->validate([
                'id_users' => 'required',
                'name_bank_account' => 'required',
                'name_account' => 'required',
                'bank_account_number' => 'required',
                'prompt_pay' => 'nullable'
            ]);
            // return $b;

            $on_save = DB::table('bank_accounts')->insert($bank_account_data);

            $return_data = DB::table('bank_accounts')
                                ->select('id_bank_accounts', 'name_bank_account', 'name_account',
                                        'bank_account_number', 'prompt_pay')
                                ->where('id_users', '=', $bank_account_data['id_users'])
                                ->first();

            return response()->json([
                'status' => 1,
                'message' => 'Successfully.',
                'data' => $return_data,
            ], 201);
        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => 'ERROR.',
                'data' => $e,
            ], 500);
        }
    }


    public function insertBankAccount(Request $request)
    {
        try {


            $bank_account_data = $request->validate([
                'id_users' => 'required',
                'email' => 'required',
                'password' => 'required',
                'name_bank_account' => 'nullable',
                'name_account' => 'nullable',
                'bank_account_number' => 'nullable',
                'prompt_pay' => 'nullable',
                // 'prompt_pay' => ['sometimes', 'nullable']
            ]);
            $login = DB::table('users')
                ->select(
                    'id_users',
                    'password'
                )
                ->where('email', $bank_account_data['email'])
                ->first();



            // return $login_data;


            // $token = auth()->attempt($login_data);
            // return $token;
            // return $login;

            if ($login == true && Hash::check($bank_account_data['password'], $login->password)) {
                $data_for_update = [
                    // 'name_bank_account' => $bank_account_data['name_bank_account'],
                    // 'name_account' => $bank_account_data['name_account'],
                    // 'bank_account_number' => $bank_account_data['bank_account_number'],
                ];
                // return "AA";
                try {
                    if ($bank_account_data['name_bank_account'] != null) {
                        $data_for_update['name_bank_account'] = $bank_account_data['name_bank_account'];
                    }

                    if ($bank_account_data['name_account'] != null) {
                        $data_for_update['name_account'] = $bank_account_data['name_account'];
                    }

                    if ($bank_account_data['bank_account_number'] != null) {
                        $data_for_update['bank_account_number'] = $bank_account_data['bank_account_number'];
                    }

                    if ($bank_account_data['prompt_pay'] != null) {
                        $data_for_update['prompt_pay'] = $bank_account_data['prompt_pay'];
                    } else {
                        $data_for_update['prompt_pay'] = null;
                    }
                } catch (Exception $e) {
                    $data_for_update['prompt_pay'] = null;
                }

                // return $data_for_update['prompt_pay'];
                // return $data_for_update;

                $on_update = DB::table('bank_accounts')
                    ->where('id_users', '=', $bank_account_data['id_users'])
                    ->update($data_for_update);

                return response()->json([
                    'status' => 1,
                    'message' => 'Successfully.',
                    'data' => $on_update,
                ], 201);
            } else {
                return response()->json([
                    'status' => 0,
                    'message' => 'Error.',
                    'data' => 'รหัสผ่านไม่ถูกต้องหรือไม่มีข้อมูลผู้ใช้งาน',
                ], 404);
            }
        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => 'ERROR.',
                'data' => $e,
            ], 500);
        }
    }

    public function editBankAccountAdmin(Request $request)
    {
        try {
            $bank_account_data = $request->validate([
                'id_users' => 'required',
                'name_bank_account' => 'nullable',
                'name_account' => 'nullable',
                'bank_account_number' => 'nullable',
                'prompt_pay' => 'nullable',
                // 'prompt_pay' => ['sometimes', 'nullable']
            ]);

            $data_for_update = [
                // 'name_bank_account' => $bank_account_data['name_bank_account'],
                // 'name_account' => $bank_account_data['name_account'],
                // 'bank_account_number' => $bank_account_data['bank_account_number'],
            ];
            // return $bank_account_data['id_users'] != "null";
            try {
                if ($bank_account_data['name_bank_account'] != null && $bank_account_data['name_bank_account'] != 'null') {
                    $data_for_update['name_bank_account'] = $bank_account_data['name_bank_account'];
                    // return $data_for_update['name_bank_account'];
                    $on_update = DB::table('bank_accounts')->where('id_users', '=', $bank_account_data['id_users'])
                            ->update(["name_bank_account"=>$data_for_update['name_bank_account']]);
                    // return "TT";
                } else {
                    $data_for_update['name_bank_account'] = null;
                }

                if ($bank_account_data['name_account'] != null && $bank_account_data['name_account'] != "null") {
                    $data_for_update['name_account'] = $bank_account_data['name_account'];
                    $on_update = DB::table('bank_accounts')->where('id_users', '=', $bank_account_data['id_users'])
                            ->update(["name_account" => $data_for_update['name_account']]);

                } else {
                    $data_for_update['name_account'] = null;
                }
                if ($bank_account_data['bank_account_number'] != null && $bank_account_data['bank_account_number'] != "null") {
                    $data_for_update['bank_account_number'] = $bank_account_data['bank_account_number'];
                    $on_update = DB::table('bank_accounts')->where('id_users', '=', $bank_account_data['id_users'])
                                    ->update(["bank_account_number" => $data_for_update['bank_account_number']]);
                } else {
                    $data_for_update['bank_account_number'] = null;
                }

                if ($bank_account_data['prompt_pay'] != null && $bank_account_data['prompt_pay'] != "null") {
                    $data_for_update['prompt_pay'] = $bank_account_data['prompt_pay'];
                    $on_update = DB::table('bank_accounts')->where('id_users', '=', $bank_account_data['id_users'])
                            ->update(["prompt_pay"=>$data_for_update['prompt_pay']]);
                } else {
                    $data_for_update['prompt_pay'] = null;
                }
            } catch (Exception $e) {
                return "ERROR".$e;
                $data_for_update['prompt_pay'] = null;
            }

            // return $data_for_update['prompt_pay'];
            // return $data_for_update;

            // $on_update = DB::table('bank_accounts')
            //     ->where('id_users', '=', $bank_account_data['id_users'])
            //     ->update(['updated_at' => Carbon::now("Asia/Bangkok")]);

            return response()->json([
                'status' => 1,
                'message' => 'Successfully.',
                // 'data' => $on_update,
            ], 201);
        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => 'ERROR.',
                'data' => $e,
            ], 500);
        }
    }
}
