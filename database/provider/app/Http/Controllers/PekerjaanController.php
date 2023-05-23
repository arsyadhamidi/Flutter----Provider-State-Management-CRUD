<?php

namespace App\Http\Controllers;

use App\Models\Pekerjaan;
use Illuminate\Http\Request;

class PekerjaanController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $pekerjaans = Pekerjaan::where('mahasiswa_id', $request->id_mahasiswa)->get();

        return response()->json([
            'status' => 200,
            'error' => false,
            'message' => "Successfully Displayed Data",
            'data' => $pekerjaans,
        ]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'nama_pekerjaan' => 'required',
            'lama' => 'required',
        ]);

        $inserts = Pekerjaan::create($validated);

        if($inserts){
            $response = [
                "status" => 200,
                "error" => false,
                "message" => "Data Save Successfully",
                "data" => $validated,
            ];
        }else{
            $response = [
                "status" => 400,
                "error" => true,
                "message" => "Data Save Failed!",
            ];
        }

        return response()->json($response);

    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Pekerjaan  $pekerjaan
     * @return \Illuminate\Http\Response
     */
    public function show(Pekerjaan $pekerjaan)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Pekerjaan  $pekerjaan
     * @return \Illuminate\Http\Response
     */
    public function edit(Pekerjaan $pekerjaan)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Pekerjaan  $pekerjaan
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Pekerjaan $pekerjaan)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Pekerjaan  $pekerjaan
     * @return \Illuminate\Http\Response
     */
    public function destroy(Pekerjaan $pekerjaan, Request $request)
    {
        $deletePekerjaan = Pekerjaan::where('id_pekerjaan', $request->id_pekerjaan);
        $deletePekerjaan->delete();

        if($deletePekerjaan){
            $response = [
                "status" => 200,
                "error" => false,
                "messages" => "Data Delete Successfully!",
            ];
        }else{
            $response = [
                "status" => 400,
                "error" => false,
                "messages" => "Data Delete Failed!",
            ];
        }

        return response()->json($response);
    }
}
