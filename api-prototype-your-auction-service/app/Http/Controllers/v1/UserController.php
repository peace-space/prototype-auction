<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use App\Models\User;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {
            // return "Test";
            $users_data = DB::table('users')
                    ->select('*')
                    ->get();

            return response()->json([
                'status' => 1,
                'message' => 'Successfully.',
                'data' => $users_data
            ]);
        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => 'Error.',
                'data' => $e
            ]);
        }
    }

    public function oneIndex($index)
    {
        try{
            $user_data = DB::table('users')
                        ->select('id_users', 'name', 'phone', 'address', 'email', 'admin')
                        ->where('id_users', '=', $index)
                        ->get();

            return response()->json([
                "status" => 1,
                "message" => "Successfully.",
                "data" => $user_data[0]
            ]);
        } catch (Exception $e) {
            return response()->json([
                "status" => 0,
                "message" => "Error.",
                "data" => $e
            ]);
        }
    }

    public function editUserProfile(Request $request, $index)
    {
        try {
            if ($request->name != "") {
                $update_data = DB::table('users')
                    ->where('id_users', '=', $index)
                    ->update(['name' => $request->name]);
            }
            if ($request->phone != "") {
                $update_data = DB::table('users')
                    ->where('id_users', '=', $index)
                    ->update(['phone' => $request->phone]);
            }
            if ($request->email != "") {
                $update_data = DB::table('users')
                    ->where('id_users', '=', $index)
                    ->update(['email' => $request->email]);
            }
            if ($request->address != "") {
                $update_data = DB::table('users')
                    ->where('id_users', '=', $index)
                    ->update(['address' => $request->address]);
            }

            $new_data = DB::table('users')
                ->select('id_users', 'name', 'phone', 'address', 'email')
                ->where('id_users', '=', $index)
                ->get();

                // return $new_data[0];

            return response()->json([
                'status' => 1,
                'message' => "Successfully.",
                'data' => $new_data[0]
            ], 200);

        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => "Error",
                'data' => $e
            ], 500);
        }
    }


    public function deleteUser($id)
    {
        try {
            $delete_user = DB::table('users')
            ->where('id_users', '=', $id)
            ->delete();

            if ($delete_user) {
                return response()->json([
                    'status' => 1,
                    'message' => "Successfully."
                ], 200);
            } else {
                return response()->json([
                    'status' => 0,
                    'message' => "ไม่มีบัญชีผู้ใช้งานในฐานข้อมูล"
                ], 500);
            }
        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => "Error.",
                'data' => $e
            ], 500);
        }
    }

    public function register(Request $request)
    {
        try {
            // $request->validate([
            //     'image_profile' => 'nullable | required | image | mimes:png, jpg, jpeh, webp'
            // ]);
            $first_name_users = $request->first_name_users;
            $last_name_users = $request->last_name_users;
            $email = $request->email;
            $phone = $request->phone;
            $password = $request->password;
            $address = $request->address;
            $image = $request->image_profile;

            $password_hashed = Hash::make($password);

            if ($image != "") {
                $image_name = Storage::disk('public')->put('images/user-profile-image', $image);
                $path = Storage::url($image_name);
            } else {
                $path = "/storage/images/user-profile-image/default-image.png";
            }


            $data = [
                "first_name_users" => $first_name_users,
                "last_name_users" => $last_name_users,
                "phone" => $phone,
                "email" => $email,
                "password" => $password_hashed,
                "address" => $address,
                "image_profile" => $path
            ];

            $user = db::table('users')
                ->insert($data);

            return response()->json([
                'status' => 1,
                'message' => "Successfully.",
                // 'data' => $data
            ], 201);
        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => "Error",
                'data' => $e
            ], 500);
        }
    }

    public function login(Request $request)
    {
        try {
            $email = $request->email;
            $password = $request->password;

            $login = DB::table('users')
                        ->select('id_users', 'first_name_users',
                                    'last_name_users', 'phone',
                                    'address', 'email',
                                    'admin_status', 'image_profile', 'password')
                        ->where('email', $email)
                        ->first();

            if ($login == true && Hash::check($password, $login->password)) {
                $data = [
                    'id_users' => $login->id_users,
                    'first_name_users' => $login->first_name_users,
                    'last_name_users' => $login->last_name_users,
                    'phone' => $login->phone,
                    'address' => $login->address,
                    'email' => $login->email,
                    'admin_status' => $login->admin_status,
                    'image_profile' => $login->image_profile,
                ];

                return response()->json([
                    'status' => '1',
                    'message' => 'Successfully.',
                    'data' => $data
                ], 200);

            } else {
                return response()->json([
                    'status' => 0,
                    'message' => 'ไม่มีข้อมูล'
                ], 500);
            }
        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => "เกิดข้อผิดพลาด",
                'data' => $e
            ], 500);
        }
    }

    public function changePassWord(Request $request){
        return $request;
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(User $user)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(User $user)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, User $user)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(User $user)
    {
        //
    }
}
