<?php

namespace App\Http\Controllers\v1;

use App\Events\UserDetailEvent;
use App\Events\UserListEvent;
use App\Http\Controllers\Controller;
use App\Models\v1\User;
// use App\Models\User;
use Exception;
use Illuminate\Database\Query\JoinClause;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;
use League\CommonMark\Extension\CommonMark\Node\Inline\Strong;
use Tymon\JWTAuth\Contracts\Providers\Auth;
// use Illuminate\Contracts\Auth\Authenticatable;

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
            // broadcast(new UserListEvent($users_data));

            event(new UserListEvent($users_data));

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

    public function oneIndex($id_users)
    {
        try {
            $user_data = DB::table('users')
                // ->select('id_users', 'first_name_users', 'last_name_users', 'phone', 'address', 'email', 'admin')
                ->select('*')
                // ->join('bank_accounts', function (JoinClause $join) {
                //     $join->on('bank_accounts.id_users', '=', 'users.id_users');
                // })
                ->where('users.id_users', '=', $id_users)
                ->first();
            // return "tsets";



            try {
                $bank_account = DB::table('bank_accounts')
                    ->select('*')
                    ->where('id_users', '=', $id_users)
                    ->first();
            } catch (Exception $e) {
                $bank_account = null;
            }

            event(new UserDetailEvent([
                "user_data" => $user_data,
                "bank_account" => $bank_account
            ]));

            return response()->json([
                "status" => 1,
                "message" => "Successfully.",
                "data" => [
                    'user_data' => $user_data,
                    "bank_account" => $bank_account
                    // 'bank_account' => ['data' => $bank_account]
                ]
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                "status" => 0,
                "message" => "Error.",
                "data" => $e
            ], 404);
        }
    }

    public function editUserProfile(Request $request)
    {
        try {
            // $user_data = [
            //     'id_users' => $request->id_users,
            //     'email' => $request->email,
            //     'password' => $request->password,
            //     'first_name_users' => $request->first_name_users,
            //     'last_name_users' => $request->last_name_users,
            //     'phone' => $request->phone,
            //     'email' => $request->email,
            //     'address' => $request->address,
            //     'image_profile' => $request->image_profile,
            // ];
            // return $request->id_users;
            // return "AAA";
            $user_data = $request->validate([
                'id_users' => ['required'],
                // 'email' => ['required'],
                // 'password' => ['required'],
                'first_name_users' => 'nullable',
                'last_name_users' => 'nullable',
                'phone' => 'nullable',
                'email' => 'nullable',
                'address' => 'nullable',
                'image_profile' => 'nullable',
                'new_password' => 'nullable'
            ]);
            // return "AA";
            // return $user_data['email'];

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
                ->where('email', '=', $user_data['email'])
                ->first();



            // return $verify_password;


            // $token = auth()->attempt($login_data);
            // return $token;
            // return $login;

            if ($verify_password == true && Hash::check($user_data['password'], $verify_password->password)) {
                if ($request->first_name_users != "" && $request->first_name_users != "null") {
                    $update_data = DB::table('users')
                        ->where('id_users', '=', $user_data['id_users'])
                        ->update(['first_name_users' => $user_data['first_name_users']]);
                }
                if ($request->last_name_users != "" && $request->last_name_users != "null") {
                    $update_data = DB::table('users')
                        ->where('id_users', '=', $user_data['id_users'])
                        ->update(['last_name_users' => $user_data['last_name_users']]);
                }


                if ($request->phone != "" && $request->phone != "null") {
                    $update_data = DB::table('users')
                        ->where('id_users', '=', $user_data['id_users'])
                        ->update(['phone' => $user_data['phone']]);
                }

                if ($request->email != "" && $request->email != "null") {
                    $update_data = DB::table('users')
                        ->where('id_users', '=', $user_data['id_users'])
                        ->update(['email' => $user_data['email']]);
                }

                if ($request->address != "" && $request->address != "null") {
                    $update_data = DB::table('users')
                        ->where('id_users', '=', $user_data['id_users'])
                        ->update(['address' => $user_data['address']]);
                }

                if ($request->image_profile != "") {
                    $old_path_image_profile = DB::table('users')
                        ->select("*")
                        ->where('id_users', '=', $user_data['id_users'])
                        ->first();
                    // return $old_path_image_profile->image_profile;
                    if ($old_path_image_profile->image_profile != '/storage/images/user-profile-image/profile-default-image.png') {
                        // return "AA";
                        try {
                            $local_path = public_path($old_path_image_profile->image_profile);
                            unlink($local_path);
                        } catch (Exception $e) {
                        }
                    }

                    if ($request->image_profile != "null") {
                        $image_name = Storage::disk('public')->put('images/user-profile-image', $user_data['image_profile']);
                        $path = Storage::url($image_name);
                        // return $path;
                    } else {
                        $path = "/storage/images/user-profile-image/profile-default-image.png";
                    }

                    $update_data = DB::table('users')
                        ->where('id_users', '=', $user_data['id_users'])
                        ->update(['image_profile' => $path]);
                }


                    if ($request->new_password != "" && $request->new_password != "null") {
                       $password_hashed = Hash::make($request->new_password);

                        $change_password = DB::table('users')
                                ->where('id_users', '=', $request->id_users)
                                ->update(['password' => $password_hashed]);
                    }

                $userController = new UserController();

                $userController->oneIndex($request->id_users);

                return response()->json([
                    'status' => 1,
                    'message' => "Successfully.",
                    // 'data' => $new_data[0]
                ], 200);
            } else {
                return response()->json([
                    'status' => 0,
                    'message' => 'ERRPR.',
                    'data' => 'ไม่มีข้อมูลผู้ใช้งาน'
                ], 404);
            }



            // $new_data = DB::table('users')
            // ->select('id_users', 'first_name_users', 'last_name_users', 'phone', 'address', 'email')
            // ->where('id_users', '=', $index)
            // ->get();

            // return $new_data[0];

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
            // return "TSET";
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
            // return $image;
            if ($image != null) {
                $image_name = Storage::disk('public')->put('images/user-profile-image', $image);
                $path = Storage::url($image_name);
                // return $path;
            } else {
                $path = "/storage/images/user-profile-image/profile-default-image.png";
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
            // return $data['image_profile'];

            // $user = db::table('users')
            //     ->insert($data);

            $user_data = User::create($data);

            if ($user_data) {
                $token = auth()->login($user_data);

                $bank_account = null;


                return response()->json([
                    'status' => 1,
                    'message' => "Successfully.",
                    'data' => [
                        'user_data' => $user_data,
                        'bank_account' => ['data' => $bank_account],
                    ],
                    'authorisation' => [
                        'token' => $token,
                        'type' => 'bearer'
                    ]
                ], 201);
            } else {
                return response()->json([
                    'status' => 0,
                    'message' => "Error.",
                    // 'data' => $data
                ], 500);
            }
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
                ->select(
                    'id_users',
                    'first_name_users',
                    'last_name_users',
                    'phone',
                    'address',
                    'email',
                    'admin_status',
                    'image_profile',
                    'password'
                )
                ->where('email', $email)
                ->first();



            // return $login_data;


            // $token = auth()->attempt($login_data);
            // return $token;
            // return $login;

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

                $login_data = [
                    'email' => $email,
                    'password' => $password,
                ];
                // return $login_data;
                $user_token_data = auth()->attempt($login_data);
                // return $user_token_data;
                if (!$user_token_data) {
                    return response()->json([
                        'status' => 0,
                        'message' => 'ไม่มีข้อมูลผู้ใช้งาน',
                        // 'data' => $data,
                    ], 404);
                }

                $user_data = auth()->user();


                try {
                    $bank_account = DB::table('bank_accounts')
                        ->select('*')
                        ->where('id_users', '=', $data['id_users'])
                        ->first();
                } catch (Exception $e) {
                    $bank_account = null;
                }
                // return $bank_account;
                return response()->json([
                    'status' => 1,
                    'message' => 'Successfully.',
                    'data' => [
                        'user_data' => $user_data,
                        'bank_account' => $bank_account,
                    ],
                    'authorisation' => [
                        'token' => $user_token_data,
                        'type' => 'bearer'
                    ]
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

    public function checkLogin()
    {
        try {
            $user_data = auth()->user();
            // return $user;
            if ($user_data) {
                try {
                    $bank_account = DB::table('bank_accounts')
                        ->select('*')
                        ->where('id_users', '=', $user_data->id_users)
                        ->first();
                } catch (Exception $e) {
                    $bank_account = null;
                }

                return response()->json([
                    "status" => 1,
                    "message" => "Successfully.",
                    "data" => [
                        'user_data' => $user_data,
                        'bank_account' => $bank_account
                    ]
                ], 200);
            } else {
                return response()->json([
                    'status' => 0,
                    'message' => 'ไม่มีข้อมูลผู้ใช้งาน',
                    // 'data' => '',
                ], 404);
            }
        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => 'Error.',
                'data' => $e,
            ], 500);
        }
        // return "test";
    }

    public function onLogout()
    {
        try {

            auth()->logout();

            return response()->json([
                'status' => 1,
                'message' => 'Successfully.',
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => 'Error.',
                'data' => $e,
            ]);
        }
    }

    public function verifyPassWord(Request $request)
    {
        try {
            $email = $request->email;
            $password = $request->password;
            // return $email;
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
                ->where('email', '=', $email)
                ->first();



            // return $verify_password;


            // $token = auth()->attempt($login_data);
            // return $token;
            // return $login;

            if ($verify_password == true && Hash::check($password, $verify_password->password)) {

                return response()->json([
                    'status' => 1,
                    'message' => 'Successfully.',
                    'data' => [
                        'password' => true
                    ],
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

    public function test(Request $request)
    {
        try {
            $user_data = [
                'id_users' => $request->id_users
            ];

            $old_path_image_profile = DB::table('users')
                ->select("*")
                ->where('id_users', '=', $user_data['id_users'])
                ->first();

            $path =  $old_path_image_profile->image_profile;

            // return $path;

            unlink(public_path($path));

            return response()->json([
                'status' => 1,
                'message' => "Successfully.",
                'data' => $old_path_image_profile,
                // 'test' => $select_path_image

            ], 200);

            return "TEST";
        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => 'ERROR.',
                'data' => $e
            ], 500);
        }
    }

    public function changePassWordUserAdmin(Request $request)
    {

    //
    //     return $password_hashed;
        try {
            $request->validate([
                "id_users" => "required",
                "password" => "required"
            ]);

            $password_hashed = Hash::make($request->password);

            $change_password = DB::table('users')
                                ->where('id_users', '=', $request->id_users)
                                ->update(['password' => $password_hashed]);
            return response()->json([
                'status' => 1,
                'message' => "Successfully.",
            ], 200);

        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => "Error",
                'data' => $e
            ], 500);
        }
    }

    public function changePassWordUser(Request $request)
    {
        $request->validate([
            'id_users' => 'required',
            'email' => 'required',
            'password' => 'required',
            'new_password' => 'required'
        ]);
            $id_users = $request->id_users;
            $email = $request->email;
            $password = $request->password;
            $new_password = $request->new_password;
            // return $email;
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
                ->where('email', '=', $email)
                ->first();



            // return $verify_password;


            // $token = auth()->attempt($login_data);
            // return $token;
            // return $login;

            if ($verify_password == true && Hash::check($password, $verify_password->password)) {
                $password_hashed = Hash::make($request->new_password);

                $change_password = DB::table('users')
                                ->where('id_users', '=', $request->id_users)
                                ->update(['password' => $password_hashed]);

                return response()->json([
                    'status' => 1,
                    'message' => 'Successfully.',
                    'data' => [
                        'password' => true
                    ],
                ], 200);
            } else {
                return response()->json([
                    'status' => 0,
                    'message' => 'ไม่มีข้อมูล'
                ], 500);
            }
    //     return $password_hashed;
        try {
            // $request->validate([
            //     "id_users" => "required",
            //     "password" => "required"
            // ]);



            return response()->json([
                'status' => 1,
                'message' => "Successfully.",
            ], 200);

        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => "Error",
                'data' => $e
            ], 500);
        }
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

