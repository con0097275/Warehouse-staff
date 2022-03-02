<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
require 'connect.php';

$Username=$_POST['Username'];
$Password=(int)$_POST['Password'];


$sql_checkNVNK = "SELECT * FROM nhanviennhapkho,nhanvien,taikhoan"
            ." WHERE nhanviennhapkho.ID_NVNK=nhanvien.ID_nhanvien AND nhanvien.ID_nhanvien=taikhoan.ID_taikhoan "
            ." AND tendangnhap='$Username' AND matkhau=$Password;";
$result=mysqli_query($conn,$sql_checkNVNK);
$check=0;

session_start(); 
$_SESSION['id_dangnhap'] =-10;
if (mysqli_num_rows($result) > 0) {
  while($row = mysqli_fetch_assoc($result)) {
      $check=1;     
      $_SESSION['id_dangnhap'] =(int)$row["ID_taikhoan"];
  }
}

if ($check) {
    header("Location:main.html");
} else {
    header("Location:form_dangnhap.html");
}


?>


