<?php

use App\Http\Controllers\v1\BillAuctionController;
use App\Http\Controllers\v1\ResultAuctionController;
use App\Http\Controllers\v1\ProductController;
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
    Route::get('/check-login', [UserController::class, 'checkLogin']);
    Route::get('logout', [UserController::class, 'onLogout']);
    Route::post('/edit-user-profile/{index}', [UserController::class, 'editUserProfile']);
    Route::delete('/delete-user/{index}', [UserController::class, 'deleteUser']);
    Route::post('/change-password', [UserController::class, 'changePassWord']);



    // AuctionController -----------------------------------------------------------
    Route::get('/auction', [AuctionController::class, 'index']);
    Route::post('/create-product', [AuctionController::class, 'createProduct']);
    // Route::get('/product-detail/{id_auctions}', [AuctionController::class, 'productDetail']);
    Route::get('/history-product/{id_users}', [AuctionController::class, 'historyProduct']);
    Route::get('/test', [AuctionController::class, 'test']);
    Route::post('/on-end-date-time', [AuctionController::class, 'onEndDateTime']);

    // ProductController -----------------------------------------------------------
    Route::get('/product-detail/{id_auctions}', [ProductController::class, 'productDetail']);
    // Route::get('/test-product-controller', [ProductController::class, 'test']);

    // Email -----------------------------------------------------------
    // Route::get('/test', [EmailController::class, 'index']);
    // Route::get('/image', [ImageController::class, 'index']);
    // Route::get('/image/{id_auctions}&{index}', [ImageController::class, 'oneImage']);
    Route::get('/get-image/{storage}/{images}/{user_profile_image}/{image_path}', [ImageController::class, 'getImage']);
    Route::get('/get-image-profile/{storage}/{images}/{user_profile_image}/{image_path}', [ImageController::class, 'getImageProfile']);
    // Route::get('/test-image/{storage}/{images}/{user_profile_image}', [ImageController::class, 'test']);
    // Route::get('/get-image-profile/{storage}/{images}/{user-profile-image}', [ImageController::class, 'getImageProfile']);

    // Bid -----------------------------------------------------------
    Route::get('/bids/{id_auctions}', [BidController::class, 'index']);
    Route::get('/high-bids/{id_auctions}', [BidController::class, 'highBids']);
    Route::post('/bidding', [BidController::class, 'bidding']);

    // Auctions User Product -----------------------------------------------------------
    Route::get('/my-auctions/{id_user}', [AuctionController::class, 'myAuctions']);
    Route::delete('/user-procuct-delete/{id_users}/{id_auctions}', [AuctionController::class, 'userProductDelete']);

    // Result -----------------------------------------------------------
    Route::get('/result-report-auction/{id_users}', [ResultAuctionController::class, 'resultReportAuction']);
    Route::post('/check-the-winners', [ResultAuctionController::class, 'checkTheWinners']);
    Route::post('/save-the-winners', [ResultAuctionController::class, 'saveTheWinnerAuctions']);

    // Bill -----------------------------------------------------------
    Route::get('/bill-auction/{id_bill_auction}', [BillAuctionController::class, 'billAuction']);
    Route::post('/insert-receipt-bill-auction', [BillAuctionController::class, 'insertReceiptBillAuction']);
});
