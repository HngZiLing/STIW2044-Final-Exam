<?php
if(!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");
$name = $_POST['user_name'];
$email = $_POST['user_email'];
$password = sha1($_POST['user_password']);
$phone = $_POST['user_phone'];
$address = $_POST['user_address'];
$encoded_string = $_POST['user_image'];

$sqlregister = "INSERT INTO table_user (user_name, user_email, user_password,
user_phone, user_address) VALUES('$name', '$email', '$password', '$phone', '$address')";

if($conn->query($sqlregister) === TRUE) {
    $response = array('status' => 'success', 'data' => null);
    $filename = mysqli_insert_id($conn);
    $decoded_string = base64_decode($encoded_string);
    $path = '../assets/images/users/'.$filename.'.jpg';
    $is_written = file_put_contents($path, $decoded_string);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray) {
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>