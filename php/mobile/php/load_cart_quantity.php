<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");
$userEmail = $_POST['userEmail'];
$sqlgetqty = "SELECT * FROM tbl_carts WHERE user_email = '$userEmail' and cart_status IS NULL";
$result = $conn->query($sqlgetqty);
$number_of_result = $result->num_rows;
$cartTotal = 0;
while($row = $result->fetch_assoc()) {
    $cartTotal = $row['cart_quantity'] + $cartTotal;
}
$mycart = array();
$mycart['cartTotal'] =$cartTotal;
$response = array('status' => 'success', 'data' => $mycart);
sendJsonResponse($response);

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>