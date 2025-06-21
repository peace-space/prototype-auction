<?php

use App\Http\Controllers\v1\AuctionController;
use App\Http\Controllers\v1\UserController;
use App\Http\Controllers\v1\BidController;
use App\Http\Controllers\v1\ImageController;
use App\Http\Controllers\v1\ResultReportAuctionController;
use App\Models\ResultReportAuction;
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


Route::prefix('/v1')->group(function () {
    Route::get('/user', [UserController::class, 'index']);
    Route::get('/user/{index}', [UserController::class, 'oneIndex']);
    Route::post('/register', [UserController::class, 'register']);
    Route::post('/login', [UserController::class, 'login']);
    Route::post('/edit-user-profile/{index}', [UserController::class, 'editUserProfile']);
    Route::delete('/delete-user/{index}', [UserController::class, 'deleteUser']);
Route::post('/change-password', [UserController::class, 'changePassWord']);




    Route::get('/auction', [AuctionController::class, 'index']);
    Route::post('/create-product', [AuctionController::class, 'createProduct']);
    Route::get('/product-detail/{id_auctions}', [AuctionController::class, 'productDetail']);
    Route::get('/history-product/{id_users}', [AuctionController::class, 'historyProduct']);
    Route::post('/test', [AuctionController::class, 'test']);
    Route::post('/on-end-date-time', [AuctionController::class, 'onEndDateTime']);


    // Route::get('/test', [EmailController::class, 'index']);
    // Route::get('/image', [ImageController::class, 'index']);
    // Route::get('/image/{id_auctions}&{index}', [ImageController::class, 'oneImage']);
    Route::get('/get-image/{image_path}', [ImageController::class, 'getImage']);

    Route::get('/bids/{id_auctions}', [BidController::class, 'index']);
    Route::get('/high-bids/{id_auctions}', [BidController::class, 'highBids']);
    Route::post('/bidding', [BidController::class, 'bidding']);

    Route::get('/user-product/{id_user}', [AuctionController::class, 'userProduct']);
    Route::delete('/user-procuct-delete/{id_users}/{id_auctions}', [AuctionController::class, 'userProductDelete']);

    Route::get('/result-report-auction/{id_users}', [ResultReportAuctionController::class, 'resultReportAuction']);
    Route::post('/check-the-winners', [ResultReportAuctionController::class, 'checkTheWinners']);
    Route::post('/save-the-winners', [ResultReportAuctionController::class, 'saveTheWinnerAuctions']);
});
