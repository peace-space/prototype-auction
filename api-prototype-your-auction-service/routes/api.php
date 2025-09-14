<?php

use App\Http\Controllers\v1\AuctionTypeController;
use App\Http\Controllers\v1\ChatController;
use App\Http\Controllers\v1\PasswordResetController;
use App\Http\Controllers\v1\BankAccountController;
use App\Http\Controllers\v1\BillAuctionController;
use App\Http\Controllers\v1\ResultAuctionController;
use App\Http\Controllers\v1\ProductController;
use App\Http\Controllers\v1\AuctionController;
use App\Http\Controllers\v1\UserController;
use App\Http\Controllers\v1\BidController;
use App\Http\Controllers\v1\ChatRoomController;
use App\Http\Controllers\v1\ImageController;
use App\Http\Controllers\v1\PrivateAuctionGroupController;
use App\Http\Controllers\v1\ProductTypeController;
use App\Http\Controllers\v1\ResultReportAuctionController;
use App\Models\ResultReportAuction;
use App\Models\v1\AuctionType;
use App\Models\v1\ProductType;
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
    Route::post('/edit-user-profile', [UserController::class, 'editUserProfile']);
    Route::delete('/delete-user/{index}', [UserController::class, 'deleteUser']);
    Route::post('/change-password-user-admin', [UserController::class, 'changePassWordUserAdmin']);
    Route::post('/change-password-user', [UserController::class, 'changePassWordUser']);

    // Password Reset
    Route::post('forgot-password', [PasswordResetController::class, 'forgotPassword']);
    Route::post('password-reset', [PasswordResetController::class, 'passwordReset']);
    // Route::post('test-send-email', [PasswordResetController::class, 'test']);

    // Bank Account -----------------------------------------------------------
    Route::post('/create-bank-account', [BankAccountController::class, 'createBankAccount']);
    Route::post('/insert-bank-account', [BankAccountController::class, 'insertBankAccount']);
    Route::post('/edit-bank-account-admin', [BankAccountController::class, 'editBankAccountAdmin']);

    // Route::post('/test-delete', [UserController::class, 'test']);

    // AuctionController -----------------------------------------------------------
    Route::get('/auction', [AuctionController::class, 'index']);
    Route::get('/auction-select-product-types/{id_product_types}', [AuctionController::class, 'auctionSelectTypes']);
    Route::post('/create-product', [AuctionController::class, 'createProduct']);
    Route::delete('/user-product-delete/{id_products}', [ProductController::class, 'userProductDelete']);
    // Route::get('/product-detail/{id_auctions}', [AuctionController::class, 'productDetail']);
    Route::get('/history-product/{id_users}', [AuctionController::class, 'historyProduct']);
    // Route::post('/on-end-date-time', [AuctionController::class, 'onEndDateTime']);
    // Route::get('/test', [AuctionController::class, 'test']);
    Route::get('/auction-list-admin', [AuctionController::class, 'auctionListAdmin']);
    Route::get('/auction-detail-admin/{id_auctions}', [AuctionController::class, 'auctionDetailAdmin']);

    // Auction Types
    Route::get('/auction-types', [AuctionTypeController::class, 'auctionTypes']);



    // ProductController -----------------------------------------------------------
    Route::get('/product-detail/{id_auctions}', [ProductController::class, 'productDetail']);
    Route::delete('/admin-product-delete/{id_products}', [ProductController::class, 'adminProductDelete']);
    Route::get('/product-types', [ProductTypeController::class, 'productTypes']);

    // Route::get('/test-product-controller', [ProductController::class, 'test']);

    // Email -----------------------------------------------------------
    // Route::get('/test', [EmailController::class, 'index']);


    //Image ------------------------------------------------------------
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
    Route::delete('/user-bid-delete/{id_bids}/{id_auctiobs}', [BidController::class, 'userBidDelete']);

    // My Auctions User Product -----------------------------------------------------------
    Route::get('/my-auctions/{id_user}', [AuctionController::class, 'myAuctions']);
    Route::get('/my-auction-detail/{id_user}', [AuctionController::class, 'myAuctionDetail']);
    Route::delete('/delete-my-auctions/{id_users}/{id_auctions}', [AuctionController::class, 'deleteMyAuctions']);

    // Result -----------------------------------------------------------
    Route::get('/result-report-auction/{id_users}', [ResultAuctionController::class, 'resultReportAuction']);
    Route::post('/check-the-winners', [ResultAuctionController::class, 'checkTheWinners']);
    Route::post('/save-the-winners', [ResultAuctionController::class, 'saveTheWinnerAuctions']);

    // Bill -----------------------------------------------------------
    Route::get('/bill-auction/{id_bill_auction}', [BillAuctionController::class, 'billAuction']);
    Route::post('/insert-receipt-bill-auction', [BillAuctionController::class, 'insertReceiptBillAuction']);
    Route::get('/my-auction-bill/{id_auctions}', [BillAuctionController::class, 'myAuctionBill']);
    Route::post('/confirm-verification', [BillAuctionController::class, 'confirmVerification']);


    //Chat Rooms -----------------------------------------------------------
    Route::get('/chat-rooms/{id_users_sender}/{id_products}', [ChatRoomController::class, 'chatRooms']);
    Route::post('/create-chat-rooms', [ChatRoomController::class, 'createChatRooms']);

    // Chat -----------------------------------------------------------
    Route::get('/chat/{id_chat_rooms}', [ChatController::class, 'chat']);
    Route::post('/send-message', [ChatController::class, 'sendMessage']);

    // Private Auction -----------------------------------------------------------
    Route::get('/private-auction-group/{id_users}', [PrivateAuctionGroupController::class, 'privateAuctionsGroup']);
    Route::get('/bidder-list/{id_auctions}', [PrivateAuctionGroupController::class, 'bidderList']);
    Route::post('/add-bidder', [PrivateAuctionGroupController::class, 'addBidder']);
    Route::post('/delete-bidder', [PrivateAuctionGroupController::class, 'deleteBidder']);
    Route::get('/private-auction-admin', [PrivateAuctionGroupController::class, 'privateAuctionAdmin']);
    Route::get('/private-auction-detail-admin', [PrivateAuctionGroupController::class, 'privateAuctionAdmin']);

});
