<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
require 'connect.php';

$ID_NVNK=(int)$_GET['ID_NVNK'];

$sql = "select * FROM nhanviennhapkho,chinhanh"
        ." WHERE nhanviennhapkho.ID_NVNK=$ID_NVNK and nhanviennhapkho.Machinhanh=chinhanh.MaChiNhanh;";
$result=mysqli_query($conn,$sql);
if (!$result) {
    die('Error'.mysqli_error($conn));
}

$info_user= mysqli_fetch_assoc($result);
//print_r($info_user);
?>


<html>
    <head>
        <title>SIEU THI DIEN MAY</title>
        <meta charset="UTF-8">
<!--        <meta name="viewport" content="width=device-width, initial-scale=1.0">-->
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <style>
        body{
            background-color: lightblue;
        }
        </style>
    </head>
    
    <body>
        <h1>INFORMATION FOR STAFF WITH ID: <span style="color: red"><?php echo $info_user['ID_NVNK'] ?></h1>
        <table class="w3-table-all">          
            <tbody>
                <tr>
                    <td class="w3-black">userID</td>
                    <td><?php echo $info_user['ID_NVNK']?></td>
                </tr>
                <tr>
                    <td class="w3-black">Typing speed</td>
                    <td><?php echo $info_user['tocdogophim']?></td>
                </tr>
                <tr>
                    <td class="w3-black">Branch's Name</td>
                    <td><?php echo $info_user['TenChiNhanh']?></td>
                </tr>
            </tbody>
        </table>
        <button class="w3-button w3-teal"><a href="select_TTnhapKho.php">Return</a></button>
    </body>
</html>
