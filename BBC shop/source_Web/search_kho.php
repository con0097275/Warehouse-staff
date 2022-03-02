<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

require 'connect.php';

$TenSanPham=$_GET['Tensanpham'];

        
$sql_sp = "SELECT * FROM loaisanpham,thongtinsanpham"
            ." WHERE loaisanpham.Model=thongtinsanpham.Model and POSITION('$TenSanPham' IN TenSanPham)>0";
$result_sp=mysqli_query($conn,$sql_sp);

?>

<html>
    <head>
        <title>SIEU THI DIEN MAY</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <style>
        body{
            background-color: lightblue;
        }
        </style>
        <style> 
        input[type=text] {
            width: 130px;
            box-sizing: border-box;
            border: 2px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            background-color: white;
            background-image: url('https://www.freepnglogos.com/uploads/search-png/search-icon-clip-art-clkerm-vector-clip-art-online-22.png');
            background-position: 10px 10px; 
            background-repeat: no-repeat;
            padding: 12px 20px 12px 40px;
            transition: width 0.4s ease-in-out;
          }

          input[type=text]:focus {
            width: 100%;
          }
        </style>
    </head>
    <body>
    <div class="w3-sidebar w3-bar-block" style="width:25%;right:0">
        <h5 class="w3-bar-item">Infomation</h5>
        <a href="main.html" class="w3-bar-item w3-button">Home</a>
        <a href="select_TTnhapkho.php" class="w3-bar-item w3-button">Nhập Kho</a>
        <a href="select_thongtinsp.php" class="w3-bar-item w3-button">Kho Hàng</a>
        <a href="sanpham.php" class="w3-bar-item w3-button">Sản Phẩm</a>

      </div>
        <form action="search_kho.php" method="get"> 
            <div>
                <label>Tìm Kiếm Số lượng sản phẩm: </label>
                <input type="text" name="Tensanpham" placeholder="Tên Sản Phẩm...">
            </div>
            <button class="w3-button w3-dark-grey" type="submit"><i class="fa fa-search w3-margin-right"></i> Search</button>
        </form>
        <h1>Số Lượng Sản Phẩm Các Chi Nhánh</h1>

      <div class="bgimg w3-display-container w3-animate-opacity w3-text-white" style="margin-right:25%">
        
        <table class="w3-table-all">
            <thead>
                <tr class="w3-red">
                    <th>MaChiNhanh</th>
                    <th>Model</th>                   
                    <th>TenSanPham</th>
                    <th>Soluong</th>                   
                </tr>
            </thead>
            <tbody>
                <?php
                if (mysqli_num_rows($result_sp) > 0) {
                    while ($row=mysqli_fetch_assoc($result_sp)){
                        ?>
                        <tr>
                            <td><?php echo $row['MaChiNhanh']?></td>
                            <td><?php echo $row['Model']?></td>
                            <td><?php echo $row['TenSanPham']?></td>
                            <td><?php echo $row['Soluong']?></td>
<!--                            <td><a href="delete.php?Model=<?php echo $row['Model'];?>">Xóa</a></td>-->
                        </tr>    
                        <?php
                    }   
                }
                ?>
            </tbody>
        </table>
        <button class="w3-button w3-teal"><a href="main.html">Return</a></button>
      </div>
      </body>
</html>
    
    
