<?php
if(!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");
$email = $_POST['userEmail'];
$password = sha1($_POST['userPassword']);
$sqllogin = "SELECT * FROM table_user WHERE user_email = '$email' AND user_password = '$password'";
$result = $conn->query($sqllogin);
$numrow = $result->num_rows;

if($numrow > 0) {
    while ($row = $result->fetch_assoc()) {
        $user['userId'] = $row['user_id'];
        $user['userName'] = $row['user_name'];
        $user['userEmail'] = $row['user_email'];
        $user['userPassword'] = $row['user_password'];
        $user['userPhone'] = $row['user_phone'];
        $user['userAddress'] = $row['user_address'];
    }
    $sqlgetqty = "SELECT * FROM tbl_carts WHERE user_email = '$email' AND cart_status IS NULL";
    $result = $conn->query($sqlgetqty);
    $number_of_result = $result->num_rows;
    $cartTotal = 0;
    while($row = $result->fetch_assoc()) {
        $cartTotal = $row['cart_quantity'] + $cartTotal;
    }
    $mycart = array();
    $user['userCart'] =$cartTotal;

    $response = array('status' => 'success', 'data' => $user);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>