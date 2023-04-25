<?php
    include_once 'koneksi.php';

    $query = "SELECT * FROM tb_mahasiswa INNER JOIN tb_pekerjaan ON tb_mahasiswa.pekerjaan_id = tb_pekerjaan.kode_pekerjaan";

    $result = mysqli_query($db, $query);

    $arr = [];
    while($data = mysqli_fetch_array($result)){
        $arr[] = $data;
    }

    print(json_encode($arr));
?>