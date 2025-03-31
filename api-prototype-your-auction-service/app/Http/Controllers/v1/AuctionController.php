<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Database\Query\JoinClause;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\Storage;

class AuctionController extends Controller
{
    public function index() {
        try{

            $test = DB::table('auctions')
                    ->select('auctions.id_auctions', 'auctions.name_product', 'images.image_path')
                    ->join('images', 'auctions.id_auctions', '=', 'images.id_auctions')
                    ->where('images.id_auctions', '=', 5)
                    ->get();

            return response()->json([
                'status' => 1,
                'message' => "Successfully.",
                'data' => $test
            ], 200);

        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => 'Error.',
                'data' => $e
            ], 500);
        }
    }

    public function productDetail($id_auctions) {
        try{

            $test = DB::table('auctions')
                    ->select('auctions.id_auctions', 'auctions.name_product', 'images.image_path')
                    ->join('images', 'auctions.id_auctions', '=', 'images.id_auctions')
                    ->where('images.id_auctions', '=', $id_auctions)
                    ->get();

            return response()->json([
                'status' => 1,
                'message' => "Successfully.",
                'data' => $test
            ], 200);

        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => 'Error.',
                'data' => $e
            ], 500);
        }

    }

    public function addImageForProduct() {
        // Schema::table('auctions', function($table){
        //     $table->string('test');
        // });
    }

    public function deleteImageForProduct() {
        // Schema::table('auctions', function($table){
        //     $table->dropColumn('test');
        // });
    }

    public function createProduct(Request $request) {
        try {
            $request->validate([
                'image' => 'required | image | mimes:png, jpg, jpeh, webp'
            ]);

            $image_name = Storage::disk('public')->put('images/product-images', $request->image);

            $path = Storage::url($image_name);

            $data = [
                'id_users' => 8,
                'name_product' => 'gg',
                'detail_product' => 'bmw',
                'shipping_cost' => 10,
                'start_price' => 10,
                'start_date_time' => "2015-09-11 03:23:17",
                'end_date_time' => "1992-05-09 00:48:10",
            ];

            DB::table('auctions')
                    ->insert($data);

            // $max = DB::raw('MAX(created_at) as last_time');
            $max = DB::table('auctions')
                            ->select(DB::raw('MAX(created_at) as last_time'))
                            ->where('id_users', '=', $data['id_users'])
                            ->get();

            $last_time = $max[0];

            // return $last_time->last_time;
            $last_time_data = DB::table('auctions')
                                    ->select('id_auctions', 'name_product', )
                                    ->where('created_at', '=', $last_time->last_time)
                                    ->get();


            $id_auctions_last_time = $last_time_data->first();
            // return $id_auctions_last_time->id_auctions;

            $image_model = [
                'id_auctions' => $id_auctions_last_time->id_auctions,
                'image_path' => $path
            ];

            DB::table('images')
                    ->insert($image_model);

            $reaction = DB::table('auctions')
                        ->select('auctions.id_auctions', 'auctions.name_product', 'images.image_path')
                        ->join('images', 'auctions.id_auctions', '=', 'images.id_auctions')
                        ->where('images.id_auctions', '=', $id_auctions_last_time->id_auctions)
                        ->get();

            return response()->json([
                'status' => 1,
                'message' => "Successfully.",
                'data' => $reaction
            ], 201);

        } catch (Exception $e) {
            return response()->json([
                'status' => 1,
                'message' => "Successfully.",
                'data' => $e
            ]);
        }
    }


}
