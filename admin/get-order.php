<?php require_once("../libs/connection/PHPpdo.php");
$db = new DatabaseConnect();
$postdata = file_get_contents("php://input");
$request = json_decode($postdata);
$db->query("CALL `orders`(?)");
$db->bind(1,$request->item);
$x = $db->resultset();
echo json_encode($x);

?>