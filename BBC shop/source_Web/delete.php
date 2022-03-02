<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

require 'connect.php';
session_start(); 

$ID_NVNK=(int)$_SESSION['id_dangnhap'];
$Machinhanh=(int)$_GET['Machinhanh'];
$Model=$_GET['Model'];
$NgayGio=$_GET['NgayGio'];




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
    $sql="SELECT * FROM thongtinnhapkho WHERE thongtinnhapkho.ID_NVNK=$ID_NVNK AND thongtinnhapkho.Machinhanh=$Machinhanh AND thongtinnhapkho.Model='$Model' AND thongtinnhapkho.NgayGio='$NgayGio';";
    $result_deleted=mysqli_query($conn,$sql);
    if (mysqli_num_rows($result_deleted) > 0) {
        // output data of each row
        while($row = mysqli_fetch_assoc($result_deleted)) {
            $soluong_deleted= $row["soLuong"];
        }
    }
    
    $sql1="DELETE FROM thongtinnhapkho " 
            ."WHERE thongtinnhapkho.ID_NVNK=$ID_NVNK AND thongtinnhapkho.Machinhanh=$Machinhanh AND thongtinnhapkho.Model='$Model' AND thongtinnhapkho.NgayGio='$NgayGio';";
    mysqli_query($conn,$sql1);
    $sql2="UPDATE loaisanpham SET Soluong=soLuong-$soluong_deleted "
                ."WHERE loaisanpham.MaChiNhanh=$Machinhanh AND loaisanpham.Model='$Model';";
    mysqli_query($conn,$sql2);
    
    echo "Xoa thanh cong";
    header("Location:select_TTnhapkho.php");
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
