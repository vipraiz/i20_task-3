<?php
$host = 'localhost';
$db = 'i20_task3';
$username = 'root';
$password = '';
$charset = 'utf8';

$dsn = "mysql:host=$host;dbname=$db;charset=$charset";
$opt = [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES => false,
];

$pdo = new PDO($dsn, $username, $password, $opt);

$productsPerPage = 12;

CONST INTMAXSIZE = 0x7FFFFFFF;
