<?php
    include_once 'koneksi.php';

    if(isset($_POST["id_pekerjaan"])){
        $id_pekerjaan = $_POST["id_pekerjaan"];
    }else return;

    $query = "DELETE FROM tb_pekerjaan WHERE id_pekerjaan ='$id_pekerjaan'";

    $execute = mysqli_query($db, $query);

    $arr = [];

    if($execute > 0){
        $arr['status'] = 200;
        $arr['error'] = false;
        $arr['message'] = "Data Delete Successfully";
    }else{
        $arr['status'] = 400;
        $arr['error'] = true;
        $arr['message'] = "Data Delete Failed!";
    }

    print(json_encode($arr));
?>