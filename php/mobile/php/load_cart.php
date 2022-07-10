<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}
include_once("dbconnect.php");
$user_email = $_POST['user_email'];
$sqlloadcart = "SELECT tbl_carts.cart_id, 
tbl_carts.subject_id, tbl_carts.cart_quantity, 
tbl_subjects.subject_name, tbl_subjects.subject_price 
FROM tbl_carts INNER JOIN tbl_subjects 
ON tbl_carts.subject_id = tbl_subjects.subject_id 
WHERE tbl_carts.user_email = '$user_email' 
AND tbl_carts.cart_status IS NULL";

$result = $conn->query($sqlloadcart);
$number_of_result = $result->num_rows;
if ($result->num_rows > 0) {
    $total_payable = 0;
    $carts["cart"] = array();
    while ($rows = $result->fetch_assoc()) {
        
        $cartlist = array();
        $cartlist['cart_id'] = $rows['cart_id'];
        $cartlist['subject_name'] = $rows['subject_name'];
        $subject_price = $rows['subject_price'];
        $cartlist['subject_price'] = number_format((float)$subject_price, 2, '.', '');
        $cartlist['cart_quantity'] = $rows['cart_quantity'];
        $cartlist['subject_id'] = $rows['subject_id'];
        $price = $rows['cart_quantity'] * $subject_price;
        $total_payable = $total_payable + $price;
        $cartlist['price_total'] = number_format((float)$price, 2, '.', ''); 
        array_push($carts["cart"],$cartlist);
    }
    $response = array('status' => 'success', 'data' => $carts, 'total' => $total_payable);
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