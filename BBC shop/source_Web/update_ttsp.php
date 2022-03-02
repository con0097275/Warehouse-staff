<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
require 'connect.php';
session_start(); 

$var_value = $_SESSION['id_dangnhap'];
echo $var_value;
?>