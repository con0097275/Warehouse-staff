<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
require 'connect.php';
$sql = "Select * from thongtinsanpham";
$result=mysqli_query($conn,$sql);

?>

<html>
    <head>
        <title>SIEU THI DIEN MAY</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
       <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <style>
        body{
            background-color: lightblue;
        }
        h1{
            margin: auto;          
        }
        input[type=text], select {
            width: 100%;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
          }

          input[type=submit] {
            width: 100%;
            background-color: #4CAF50;
            color: white;
            padding: 14px 20px;
            margin: 8px 0;
            border: none;
            border-radius: 4px;
            cursor: pointer;
          }

          input[type=submit]:hover {
            background-color: #45a049;
          }
        </style>
    </head>
    <body>
    <div class="w3-sidebar w3-bar-block" style="width:25%;right:0;top:0">
        <h5 class="w3-bar-item">Infomation</h5>
        <a href="main.html" class="w3-bar-item w3-button">Home</a>
        <a href="select_TTnhapkho.php" class="w3-bar-item w3-button">Nhập Kho</a>
        <a href="select_thongtinsp.php" class="w3-bar-item w3-button">Kho Hàng</a>
        <a href="sanpham.php" class="w3-bar-item w3-button">Sản Phẩm</a>
     
    </div>
     

        <h2 style="color:black;">Thông Tin Sản Phẩm:</h2>
                
        <div class="bgimg w3-display-container w3-animate-opacity w3-text-white" style="margin-right:25%">
<!--        <h2 style="color:black;">Thông Tin Sản Phẩm:</h2>-->
        <table class="w3-table-all">
            <thead>
                <tr class="w3-green">
                    <th>Model</th>
                    <th>Tên Sản Phẩm</th>
                    <th>Loại</th>                   
                    <th>TenNSX</th>
                    <th>Giá Tiền</th> 
                    <th>xuất sứ</th>
                    <th>Năm ra mắt</th>
                    <th>TG bảo hành</th>
                    <th>Màu sắc</th>
                    <th><button class="w3-button w3-teal"><a href="themthongtinsanpham.php">Thêm</button></th>
                </tr>
            </thead>
            <tbody>
                <?php
                if (mysqli_num_rows($result) > 0) {
                    while ($row=mysqli_fetch_assoc($result)){
                        ?>
                        <tr>
                            <td><?php echo $row['Model']?></td>
                            <td><?php echo $row['TenSanPham']?></td>
                            <td><?php echo $row['TenDanhMuc']?></td>
                            <td><?php echo $row['TenNSX']?></td>
                            <td><?php echo $row['giaTien']?></td>
                            <td><?php echo $row['xuatSu']?></td>
                            <td><?php echo $row['namRaMat']?></td>
                            <td><?php echo $row['ThoiGianBaoHanh']?></td>
                            <td><?php echo $row['MauSac']?></td>
                            <td><a href="suathongtinsanpham.php?model=<?php echo $row['Model'];?>"><i class="material-icons">create</i>sửa</td>                                                                                                                                                                                                                                                                                                                      
                        </tr>    
                        <?php
                    }   
                }
                ?>
            </tbody>
        </table>
        <p id="demo"></p>
        <button class="w3-button w3-teal"><a href="main.html">Return</a></button>
        </div>
  </body>



</html>












