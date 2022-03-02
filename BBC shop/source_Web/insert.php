<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
require 'connect.php';
session_start(); 

$ID_NVNK=(int)$_SESSION['id_dangnhap'];
$Machinhanh=(int)$_POST['Machinhanh'];
$Model=$_POST['Model'];
$soLuong=(int)$_POST['soLuong'];

$sql_NVNK="SELECT * FROM nhanviennhapkho WHERE nhanviennhapkho.ID_NVNK=$ID_NVNK";
$result=mysqli_query($conn,$sql_NVNK);

if (mysqli_num_rows($result) > 0) {
  // output data of each row
  while($row = mysqli_fetch_assoc($result)) {
    $check= $row["Machinhanh"]==$Machinhanh;
  }
}

if (!$check){
    echo "NVNK thuoc chi nhanh nao chi duoc lam viec tren chi nhanh do";
} else {
    $sql="INSERT INTO `thongtinnhapkho` "
            ."(`ID_NVNK`,`Machinhanh`,`Model`,`NgayGio`,`soLuong`)"
            ."VALUES "
            ."($ID_NVNK,'$Machinhanh','$Model',CURRENT_TIMESTAMP(),$soLuong)";
    if (!mysqli_query($conn,$sql)) {
        die('Lỗi sql: '.mysqli_error($conn));
    }
    //check co ton tai san Model va Machinhanh trong KHO??
    $sql3="SELECT * FROM loaisanpham WHERE loaisanpham.MaChiNhanh=$Machinhanh AND loaisanpham.Model='$Model';";
    $result3=mysqli_query($conn,$sql3);
    $check_exist_sp=0;
    if (mysqli_num_rows($result3) > 0) {
        $check_exist_sp=1;
      }
      
      
    if ($check_exist_sp==1) {
        $sql2="UPDATE loaisanpham SET Soluong=soLuong+$soLuong "
                ."WHERE loaisanpham.MaChiNhanh=$Machinhanh AND loaisanpham.Model='$Model';";
        mysqli_query($conn,$sql2);
    } else {
        $sql4="INSERT INTO loaisanpham VALUES($Machinhanh,'$Model',$soLuong);";
        mysqli_query($conn,$sql4);
    }
         
    echo "Thêm thành công....";   
}

?>  
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <style>
        body{
            background-color: lightblue;
        }
        </style>
    </head>
    <body>
        <button class="w3-button w3-teal"><a href="select_TTnhapkho.php">Return</a></button>
    </body>
</html>

