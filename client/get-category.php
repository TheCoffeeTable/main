<?php
	require_once("../libs/connection/PHPpdo.php");
	$db = new DatabaseConnect();
	$db->query("CALL `get-categories`");
	$x = $db->resultset();
	$js = json_encode($x);
	echo $js;
?>