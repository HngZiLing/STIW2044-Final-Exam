<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");
$subjectId = $_POST['subjectId'];
$userEmail = $_POST['userEmail'];
$cartqty = "1";
$cartTotal = 0;

$sqlcheckqty = "SELECT * FROM tbl_subjects where subject_id = '$subjectId'";
$resultqty = $conn->query($sqlcheckqty);
$num_of_qty = $resultqty->num_rows;

if ($num_of_qty>1){
    $response = array('status' => 'failed', 'data' => null);
	sendJsonResponse($response);
	return;
}

$sqlinsert = "SELECT * FROM tbl_carts WHERE user_email = '$userEmail' AND subject_id = '$subjectId' AND cart_status IS NULL";
$result = $conn->query($sqlinsert);
$number_of_result = $result->num_rows;

if ($number_of_result > 0) {
    while($row = $result->fetch_assoc()) {
	    $cartqty = $row['cart_quantity'];
	}
	$updatecart = "UPDATE `tbl_carts` SET `cart_quantity`= '$cartqty' WHERE user_email = '$userEmail' AND subject_id = '$subjectId' AND cart_status IS NULL";
	$conn->query($updatecart);
} 
else 
{
    $addcart = "INSERT INTO `tbl_carts`(`user_email`, `subject_id`, `cart_quantity`) VALUES ('$userEmail','$subjectId','$cartqty')";
    if ($conn->query($addcart) === TRUE) {

	}else{
	    $response = array('status' => 'failed', 'data' => null);
		sendJsonResponse($response);
		return;
    }
}

$sqlgetqty = "SELECT * FROM tbl_carts WHERE user_email = '$userEmail' AND cart_status IS NULL";
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