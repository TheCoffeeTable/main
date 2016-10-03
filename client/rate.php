<?php require_once("../libs/connection/PHPpdo.php");
$db = new DatabaseConnect();
$postdata = file_get_contents("php://input");
$request = json_decode($postdata);


	$db->query("CALL rater(?,?)");
	$db->bind(1,$request->itemno);
	$db->bind(2,$request->rate);
	$db->execute();	


?>