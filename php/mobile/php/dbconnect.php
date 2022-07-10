<?php
$servername = "localhost";
$username = "hngzilin_admin";
$password = "a212stiw2044mp";
$dbname = "hngzilin_mytutordb";

$conn = new mysqli($servername, $username, $password, $dbname);
if($conn -> connect_error) {
    die("Connection failed: " .$conn->connect_error);
}
?>