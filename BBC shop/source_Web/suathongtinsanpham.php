<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
require 'connect.php';
   
?>
<?php
    if(isset($_GET["model"])) {
        $model=$_GET["model"];        
    } 
   //echo $model = $_GET['model'];
?>
<?php
    
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $Ml=$_POST['Model'];
        $TenSanPham=$_POST['TenSanPham'];
        $TenDanhMuc=$_POST['TenDanhMuc'];
        $TenNSX=$_POST['TenNSX'];
        $giaTien=(int)$_POST['giaTien'];
        $xuatSu=$_POST['xuatSu'];
        $namRaMat=(int)$_POST['namRaMat'];
        $ThoiGianBaoHanh=$_POST['ThoiGianBaoHanh'];
        $MauSac=$_POST['MauSac'];
        
       
        if ($Ml!="" && $TenSanPham!="" &&$TenDanhMuc!="" && $TenNSX!="" &&$giaTien &&$xuatSu!="" && $namRaMat && $ThoiGianBaoHanh!="" && $MauSac!="" ) {
            $sql="UPDATE thongtinsanpham SET Model='$Ml', TenSanPham='$TenSanPham',TenDanhMuc='$TenDanhMuc',TenNSX='$TenNSX',giaTien=$giaTien,xuatSu='$xuatSu',namRaMat=$namRaMat,ThoiGianBaoHanh='$ThoiGianBaoHanh',MauSac='$MauSac' WHERE Model='$Ml'";
            $qr=mysqli_query($conn,$sql);
            header("Location:sanpham.php");
        } 
                          
    }
    
?>


<?php
        $sql="SELECT * FROM thongtinsanpham WHERE model='$model'";
        $qr=mysqli_query($conn,$sql);
        $rows=mysqli_fetch_array($qr);
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
    <div class="w3-sidebar w3-bar-block" style="width:25%;right:0">
        <h5 class="w3-bar-item">Infomation</h5>
        <a href="main.html" class="w3-bar-item w3-button">Home</a>
        <a href="select_TTnhapkho.php" class="w3-bar-item w3-button">Nh???p Kho</a>
        <a href="select_thongtinsp.php" class="w3-bar-item w3-button">Kho H??ng</a>
        <a href="sanpham.php" class="w3-bar-item w3-button">S???n Ph???m</a>
     
    </div>
        <!--Ph???n n??y ch??? mang minh t??nh ch???t minh h???a-->
        <h2>S???a th??ng tin s???n ph???m c?? MODEL : <?php echo $rows['Model']?></h2>
        <div style="margin-right:25%;border-radius: 5px;background-color: #f2f2f2;padding: 20px;">
            
            <form action="<?php echo $_SERVER['PHP_SELF'];?>" method="post">
            <div class="w3-row-padding" style="margin:0 -16px;">
                <div class="w3-half w3-margin-bottom">
                  <label for="fname">Model</label>
                  <input type="text" id="fname" name="Model" value="<?php echo $rows['Model']?>">
                </div>
                <div class="w3-half">   
                  <label for="lname">T??n s???n ph???m</label>
                  <input type="text" id="lname" name="TenSanPham" value="<?php echo $rows['TenSanPham']?>">
                </div>             
            </div>  
              <div class="w3-row-padding" style="margin:0 -16px;">
                <div class="w3-half w3-margin-bottom">
                  <label for="fname">Lo???i</label>
                  <input type="text" id="fname" name="TenDanhMuc" value="<?php echo $rows['TenDanhMuc']?>">
                </div>
                 <div class="w3-half">   
                  <label for="lname">T??n NSX</label>
                  <input type="text" id="lname" name="TenNSX" value="<?php echo $rows['TenNSX']?>">
                </div>
            </div>  
              <div class="w3-row-padding" style="margin:0 -16px;">
                <div class="w3-half w3-margin-bottom">
                  <label for="fname">Gi?? Ti???n</label>
                  <input type="text" id="fname" name="giaTien" value="<?php echo $rows['giaTien']?>">
                </div>
                 <div class="w3-half">   
                  <label for="lname">Xu???t x???</label>
                  <input type="text" id="lname" name="xuatSu" value="<?php echo $rows['xuatSu']?>">
                </div>
            </div>  
              <div class="w3-row-padding" style="margin:0 -16px;">
                <div class="w3-half w3-margin-bottom">
                  <label for="fname">N??m ra m???t</label>
                  <input type="text" id="fname" name="namRaMat" value="<?php echo $rows['namRaMat']?>">
                </div>
                 <div class="w3-half">   
                  <label for="lname">Th???i gian b???o h??nh</label>
                  <input type="text" id="lname" name="ThoiGianBaoHanh" value="<?php echo $rows['ThoiGianBaoHanh']?>">
                </div>
            </div>  
                <label for="lname">M??u s???c</label>
                  <input type="text" id="lname" name="MauSac" value="<?php echo $rows['MauSac']?>">

              <input type="submit" value="X??c nh???n">
            </form>
        </div>
                  
                  
        
        
    </body>  
</html>

