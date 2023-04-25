<?php

    include_once 'koneksi.php';

    $nama           = $_POST['nama'];
    $nohp           = $_POST['nohp'];
    $alamat         = $_POST['alamat'];
    $pendidikan     = $_POST['pendidikan'];


    $query = "INSERT INTO tb_mahasiswa(nama,nohp,alamat,pendidikan,pekerjaan_id) VALUES ('$nama','$nohp','$alamat','$pendidikan','1')";

    $result = mysqli_query($db, $query);

    $arr = [];

    if($result > 0){
        $arr['status']  = 200;
        $arr['error']   = false;
        $arr['message'] = 'Add Mahasiswa Successfully!'; 
    }else{
        $arr['status']  = 400;
        $arr['error']   = true;
        $arr['message'] = 'Add Mahasiswa Failed!'; 
    }


    print(json_encode($arr));
?>