<?php

use App\Http\Controllers\AuctionController;
use App\Http\Controllers\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
// });

Route::get('/user', [UserController::class, 'index']);
Route::get('/user/{index}', [UserController::class, 'oneIndex']);
Route::post('/register', [UserController::class, 'register']);
Route::post('/login', [UserController::class, 'login']);
Route::post('/edit-user-profile/{index}', [UserController::class, 'editUserProfile']);
Route::delete('/delete-user/{index}', [UserController::class, 'deleteUser']);
Route::post('/change-password', [UserController::class, 'changePassWord']);

Route::get('/auction', [AuctionController::class, 'index']);


