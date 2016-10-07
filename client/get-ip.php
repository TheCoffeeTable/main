<?php
	require_once("../libs/connection/PHPpdo.php");
	$db = new DatabaseConnect();
    $ip = $_SERVER['REMOTE_ADDR'];
	$db->query("SELECT * from tbl_tableno WHERE ip = ?");
    $db->bind(1,$ip);
	$x = $db->single();
    $r = $db->rowCount();
    if($r > 0){
        echo json_encode($x);
    }
    else{
        $db->query("INSERT into tbl_tableno(`ip`)VALUES(?)");
        $db->bind(1,$ip);
        $db->execute();

        $db->query("SELECT * from tbl_tableno WHERE ip = ?");
        $db->bind(1,$ip);
        $x = $db->single();
        echo json_encode($x);
    }
?>