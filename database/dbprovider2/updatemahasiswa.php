<?php

	include_once 'koneksi.php';

	$id_mahasiswa	= $_POST['id_mahasiswa'];
	$nama           = $_POST['nama'];
    $nohp           = $_POST['nohp'];
    $alamat         = $_POST['alamat'];
    $pendidikan     = $_POST['pendidikan'];

    $query = "UPDATE tb_mahasiswa SET nama='$nama', nohp='$nohp', alamat='$alamat', pendidikan='$pendidikan' WHERE id_mahasiswa='$id_mahasiswa'";

    $result = mysqli_query($db, $query);

    $arr = [];

    if($result > 0){
    	$arr['status'] 	= 200;
    	$arr['error'] 	= false;
    	$arr['message'] = 'Update Data Mahasiswa Successfully!'; 
    }else{
    	$arr['status'] 	= 400;
    	$arr['error'] 	= true;
    	$arr['message'] = 'Update Data Mahasiswa Failed!'; 
    }

    print(json_encode($arr));
?>