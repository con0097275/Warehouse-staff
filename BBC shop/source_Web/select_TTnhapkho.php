<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
require 'connect.php';


$sql = "Select * from thongtinnhapkho";
$result=mysqli_query($conn,$sql);
session_start(); 
$id_dangnhap = (int)$_SESSION['id_dangnhap'];

?>

<html>
    <head>
        <title>SIEU THI DIEN MAY</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
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
    <!-- bar  -->
    <div class="w3-sidebar w3-bar-block" style="width:25%;right:0;top:0">
        <h5 class="w3-bar-item">Infomation</h5>
        <a href="main.html" class="w3-bar-item w3-button">Home</a>
        <a href="select_TTnhapkho.php" class="w3-bar-item w3-button">Nhập Kho</a>
        <a href="select_thongtinsp.php" class="w3-bar-item w3-button">Kho Hàng</a>
        <a href="sanpham.php" class="w3-bar-item w3-button">Sản Phẩm</a>
     </div>

    <!-- content-->
        <div class="bgimg w3-display-container w3-animate-opacity w3-text-white" style="margin-right:25%">       
        <h2 style="color:black;">Work with Staff's ID: <?php echo $id_dangnhap ?></h2>
        
        <div class=" w3-padding w3-col l6 m8 "  >
        
    <div class="w3-container w3-red">
      <h2><i class="fa fa-bed w3-margin-right"></i>Nhập Kho</h2>
    </div>
    <div class="w3-container w3-white w3-padding-16">
      <form action="insert.php" method="post" >
        <div class="w3-row-padding" style="margin:0 -16px;">
          <div class="w3-half w3-margin-bottom">
            <label><i class="fa fa-calendar-o"></i> Mã chi nhánh</label>
            <input class="w3-input w3-border" type="text" placeholder="Mã chi nhánh" name="Machinhanh" required>
          </div>
          <div class="w3-half">
            <label><i class="fa fa-calendar-o"></i> Model</label>
            <input class="w3-input w3-border" type="text" placeholder="Model" name="Model" required>
          </div>
        </div>
        <div class="w3-row-padding" style="margin:0 -16px;">
          <div class="w3-half w3-margin-bottom">
            <label> Số lượng</label>
            <input class="w3-input w3-border" type="number" value="1" name="soLuong" required>
          </div>
          <div class="w3-half">
<!--            <label>ID Nhân viên</label>
            <input class="w3-input w3-border" type="number" value="" name="ID_NVNK" placeholder="ID...." required>-->
          </div>
        </div>
        <button class="w3-button w3-dark-grey" type="submit"><i class="fa fa-search w3-margin-right"></i> Submit</button>
      </form>
    </div>
    </div>
        
<!--        //TABLE ThongTinNhapKho-->
        <table class="w3-table-all">
            <thead>
                <tr class="w3-green">
                    <th>ID_NVNK</th>
                    <th>Mã chi nhánh</th>                   
                    <th>Model</th>
                    <th>Ngày Giờ</th>
                    <th>Số lượng</th>  
                    <th>Thông tin nhân viên</th>
                </tr>
            </thead>
            <tbody>
                <?php
                if (mysqli_num_rows($result) > 0) {
                    while ($row=mysqli_fetch_assoc($result)){
                        ?>
                        <tr>
                            <td><?php echo $row['ID_NVNK']?></td>
                            <td><?php echo $row['Machinhanh']?></td>
                            <td><?php echo $row['Model']?></td>
                            <td><?php echo $row['NgayGio']?></td>
                            <td><?php echo $row['soLuong']?></td>
                            <td><button class="w3-button w3-white w3-border w3-round-large"><a href="info.php?ID_NVNK=<?php echo $row['ID_NVNK'];?>">Thông tin</a></button></td>
                            
                            <td><button class="w3-button w3-white w3-border w3-round-large"><a href="delete.php?Machinhanh=<?php echo $row['Machinhanh'];?>&Model=<?php echo $row['Model'];?>&NgayGio=<?php echo $row['NgayGio'];?>">Xóa</a></button></td>
                                                                                                                                                                                                                                                                            
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


