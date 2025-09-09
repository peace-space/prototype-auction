<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ProductTypeController extends Controller
{
    public function productTypes() {
        try {

            $product_types = DB::table('product_types')
                                ->select('id_product_types', 'product_type_text')
                                ->get();

            return response()->json([
                'status' => 1,
                'message' => "Successfully",
                'data' => $product_types
            ], 200);

        } catch (Exception $e) {
            return response()->json([
                'status' => 0,
                'message' => 'Error',
                'data' => 'data'
            ], 500);
        }
    }
}
