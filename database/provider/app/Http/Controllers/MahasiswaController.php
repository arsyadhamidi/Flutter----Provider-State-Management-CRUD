<?php

namespace App\Http\Controllers;

use App\Models\Mahasiswa;
use App\Models\Pekerjaan;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class MahasiswaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $mahasiswas = Mahasiswa::latest()->get();

        return response()->json([
            'status' => 200,
            'error' => false,
            'message' => "Successfully Displayed Data",
            'data' => $mahasiswas,
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
        $validator = Validator::make($request->all(), [
            'nama_mahasiswa'     => 'required',
            'nohp_mahasiswa'      => 'required',
            'alamat_mahasiswa'   => 'required',
            'pendidikan'   => 'required',
        ]);

        if ($validator->fails()) {
            $response = [
                "status" => 400,
                "error" => true,
                "messages" => $validator->errors()->first(),
            ];
        }else{

            $blog = Mahasiswa::create([
                'nama_mahasiswa' => $request->nama_mahasiswa,
                'nohp_mahasiswa' => $request->nohp_mahasiswa,
                'alamat_mahasiswa' => $request->alamat_mahasiswa,
                'pendidikan' => $request->pendidikan,
            ]);

            $firsts = Mahasiswa::latest()->first();

            $pekerjaans = json_decode($request->pekerjaan);

            foreach($pekerjaans as $data){

                $inserts = Pekerjaan::create([
                    'nama_pekerjaan' => $data->nama_pekerjaan,
                    'lama' => $data->lama,
                    'mahasiswa_id' => $firsts->id_mahasiswa,
                ]);
                
            }


            if($blog)
            {
                $response = [
                    "status" => 200,
                    "error" => false,
                    "messages" => "Data Saved Successfully!",
                ];
            }
            else{
                $response = [
                    "status" => 400,
                    "error" => true,
                    "messages" => "Data failed to save!",
                ];
            }

        }


        return response()->json($response);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Mahasiswa  $mahasiswa
     * @return \Illuminate\Http\Response
     */
    public function show(Mahasiswa $mahasiswa)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Mahasiswa  $mahasiswa
     * @return \Illuminate\Http\Response
     */
    public function edit(Mahasiswa $mahasiswa)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Mahasiswa  $mahasiswa
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'nama_mahasiswa'     => 'required',
            'nohp_mahasiswa'      => 'required',
            'alamat_mahasiswa'   => 'required',
            'pendidikan'   => 'required',
        ]);

        if ($validator->fails()) {
            $response = [
                "status" => 400,
                "error" => true,
                "messages" => $validator->errors()->first(),
            ];
        }else{

            $blog = Mahasiswa::where('id_mahasiswa', $request->id_mahasiswa)->update([
                'nama_mahasiswa' => $request->nama_mahasiswa,
                'nohp_mahasiswa' => $request->nohp_mahasiswa,
                'alamat_mahasiswa' => $request->alamat_mahasiswa,
                'pendidikan' => $request->pendidikan,
            ]);

            $firsts = Mahasiswa::latest()->first();

            $pekerjaans = json_decode($request->pekerjaan);

            $deleted = Pekerjaan::where('mahasiswa_id', $request->id_mahasiswa);
            $deleted->delete();

            foreach($pekerjaans as $data){

                $inserts = Pekerjaan::create([
                    'nama_pekerjaan' => $data->nama_pekerjaan,
                    'lama' => $data->lama,
                    'mahasiswa_id' => $firsts->id_mahasiswa,
                ]);
                
            }


            if($blog)
            {
                $response = [
                    "status" => 200,
                    "error" => false,
                    "messages" => "Data Saved Successfully!",
                ];
            }
            else{
                $response = [
                    "status" => 400,
                    "error" => true,
                    "messages" => "Data failed to save!",
                ];
            }

        }


        return response()->json($response);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Mahasiswa  $mahasiswa
     * @return \Illuminate\Http\Response
     */
    public function destroy(Mahasiswa $mahasiswa, Request $request)
    {
        $deletedMahasiswa = Mahasiswa::where('id_mahasiswa', $request->id_mahasiswa);
        $deletedMahasiswa->delete();

        $deletedPekerjaan = Pekerjaan::where('mahasiswa_id', $request->id_mahasiswa);
        $deletedPekerjaan->delete();

        if($deletedMahasiswa){
            $response = [
                "status" => 200,
                "error" => false,
                "messages" => "Data Delete Successfully!",
            ];
        }else{
            $response = [
                "status" => 400,
                "error" => true,
                "messages" => "Data Saved Failed!",
            ];
        }

        return response()->json($response);

    }
}
