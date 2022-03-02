<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

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
    header("Location:select_TTnhapkho.php");
} else {
    $sql1="DELETE FROM thongtinnhapkho " 
            ."WHERE thongtinnhapkho.ID_NVNK=$ID_NVNK AND thongtinnhapkho.Machinhanh=$Machinhanh AND thongtinnhapkho.Model='$Model' AND thongtinnhapkho.NgayGio='$NgayGio';";
    mysqli_query($conn,$sql1);
}


