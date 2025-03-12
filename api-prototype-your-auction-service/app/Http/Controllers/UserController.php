<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $users_data = DB::table('users')
                    ->select('*')
                    ->get();

        return response()->json([
            'status' => 'ok',
            'message' => 'Successfully.',
            'data' => $users_data
        ]);
    }

    public function oneIndex($index) {
        $user_data = DB::table('users')
                        ->select('*')
                        ->where('id', '=', $index)
                        ->get();

        return response()->json([
            "status" => "1",
            "message" => "Successfully.",
            "data" => $user_data
        ]);
    }

    // public function editUserProfile(Request $request, $index){

    //     if ($request->name != ""){
    //         $update_data = DB::table('users')
    //                         ->where('id', '=', $index)
    //                         ->update(['name' => $request->name]);
    //     }
    //     if ($request->phone != ""){
    //         $update_data = DB::table('users')
    //                         ->where('id', '=', $index)
    //                         ->update(['phone' => $request->phone]);
    //     }
    //     if ($request->email != ""){
    //         $update_data = DB::table('users')
    //                         ->where('id', '=', $index)
    //                         ->update(['email' => $request->email]);
    //     }

    //     $new_data = DB::table('users')
    //                         ->select('*')
    //                         ->where('id', '=', $index)
    //                         ->get();

    //     return response()->json([
    //         "status" => "1",
    //         "message" => "Successfully.",
    //         "data" => $new_data
    //     ]);

    // }

    public function editUserProfile(Request $request, $index){
        $data = [
            "name" => $request->name,
            "phone" => $request->phone,
            "email" => $request->email
        ];

        if ($request->name != ""){
                    $update_data = DB::table('users')
                                    ->where('id', '=', $index)
                                    ->update(['name' => $request->name]);
                }
                if ($request->phone != ""){
                    $update_data = DB::table('users')
                                    ->where('id', '=', $index)
                                    ->update(['phone' => $request->phone]);
                }
                if ($request->email != ""){
                    $update_data = DB::table('users')
                                    ->where('id', '=', $index)
                                    ->update(['email' => $request->email]);
                }

            return    $new_data = DB::table('users')
                                    ->select('*')
                                    ->where('id', '=', $index)
                                    ->get();
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
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
