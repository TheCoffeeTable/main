<?php require_once("../libs/connection/PHPpdo.php");
$db = new DatabaseConnect();
$postdata = file_get_contents("php://input");
$request = json_decode($postdata);

foreach($request as $r)
{
	$db->query("rater(?,?)");
	$db->bind(1,$r->itemno);
	$db->bind(2,$r->rate);
	$db->execute();	
}


?>