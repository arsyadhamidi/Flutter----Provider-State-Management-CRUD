<?php

    include_once 'koneksi.php';

    $nama_pekerjaan = $_POST['nama_pekerjaan'];
    $lama           = $_POST['lama'];


    $query = "INSERT INTO tb_pekerjaan(kode_pekerjaan, nama_pekerjaan,lama) VALUES ('1','$nama_pekerjaan','$lama')";

    $result = mysqli_query($db, $query);

    $arr = [];
    if($result > 0){
        $arr['status'] = 200;
        $arr['error'] = false;
        $arr['message'] = 'Add Pekerjaan Successfully!';
    }else{
        $arr['status'] = 400;
        $arr['error'] = false;
        $arr['message'] = 'Add Pekerjaan Failed!';
    }

    print(json_encode($arr));
?>