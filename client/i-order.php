<?php require_once("../libs/connection/PHPpdo.php");
$db = new DatabaseConnect();
$postdata = file_get_contents("php://input");
$request = json_decode($postdata);

foreach($request as $r)
{
	$db->query("INSERT into tbl_orders(`TableNo`,`productNo`,`name`,`qty`,`price`)VALUES(?,?,?,?,?)");
	$db->bind(1,$r->tblno);
	$db->bind(2,$r->itemno);
	$db->bind(3,$r->name);
	$db->bind(4,$r->qty);
	$db->bind(5,$r->price);
	$db->execute();	
}


?>