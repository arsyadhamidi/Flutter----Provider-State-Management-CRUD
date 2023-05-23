<?php

use Illuminate\Http\Request;
use App\Http\Controllers\MahasiswaController;
use App\Http\Controllers\PekerjaanController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});


Route::get('/get-mahasiswa', [MahasiswaController::class, 'index']);
Route::post('/get-pekerjaan', [PekerjaanController::class, 'index']);
Route::post('/add-mahasiswa', [MahasiswaController::class, 'store']);
Route::post('/add-pekerjaan', [PekerjaanController::class, 'store']);
Route::post('/update-pekerjaan', [MahasiswaController::class, 'update']);
Route::post('/delete-mahasiswa', [MahasiswaController::class, 'destroy']);