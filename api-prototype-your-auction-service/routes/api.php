<?php

use App\Http\Controllers\v1\AuctionController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\v1\BidController;
use App\Http\Controllers\v1\EmailController;
use App\Http\Controllers\v1\ImageController;
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


Route::prefix('/v1')->group(function () {
    Route::get('/auction', [AuctionController::class, 'index']);
    Route::post('/create-product', [AuctionController::class, 'createProduct']);
    Route::get('/product-detail/{id_auctions}', [AuctionController::class, 'productDetail']);
    Route::get('/test', [AuctionController::class, 'test']);

    // Route::get('/test', [EmailController::class, 'index']);
    Route::get('/image', [ImageController::class, 'index']);
    Route::get('/image/{id_auctions}&{index}', [ImageController::class, 'oneImage']);

    Route::get('/high-bids/{id}', [BidController::class, 'highBids']);
});
