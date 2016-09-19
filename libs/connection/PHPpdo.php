<?php
//ganito pag gamit nyan
//require_once("PHPpdo.php");
//$db = new DatabaseConnect();
//-------select query--------
//$db->query("SELECT statement mo sa database");
//$singleResult = $db->single(); -- eto pang single result na query
//$multiResult = $db->resultset(); -- eto pang multiple result ng query
//$NumberofRows = $db->rowCount(); -- eto number ng row na affected sa query mo

//-------CREATE,UPDATE,DELETE----------
//$db->query("UPDATE tblsomething set FIELD1 = ?,FIELD2 = ? WHERE FIELD 1 = ? LIMIT 1");
//db->bind(1,"Value ng field1/first question mark"); -- binding lang yan nung first question mark (NOTE: kung ilan ung question mark mo sa SQL statement dapat ganun din bind mo.)
//db->bind(2,"Value ng field2/second question mark");
//db->bind(3,"Value ng field1/third question mark");
//$db->execute(); -- para maexecute mo ung CUD SQL query mo. yang nasa taas preparation lng ng query mo.

//-------OUTPUT ng MULTIPLE RESULT ng SELECT query mo---------
//foreach($multiResult as $x){
//    echo $x['fieldname']; -- yang fieldname palitan mo ng field name na gusto mong maioutput ng result. Kung madaming fieldname edi dapat madaming echo $x['fieldname']; ilalagay mo.
//}    



class DatabaseConnect{
    // hostname 
    private $host      = 'localhost';
    // username
    private $user      = 'root';
    //password
    private $pass      = '';
    //database name
    private $dbname    = 'the_coffee_table';//name ng database mo type dito, type na a
    //port
    private $port      = '3306';
 
    private $dbh;
    private $error;

 	private $stmt;

public function __construct(){

        // Set DSN
        $dsn = 'mysql:host='.$this->host.';dbname='.$this->dbname.';port='.$this->port.';charset=utf8';
        // Set options
        $options = array(
            PDO::ATTR_PERSISTENT    => true,
            PDO::ATTR_ERRMODE       => PDO::ERRMODE_EXCEPTION
        );
        // Create a new PDO instance
        try{
            $this->dbh = new PDO($dsn, $this->user, $this->pass, $options);
        }
        // Catch any errors
        catch(PDOException $e){
            $this->error = $e->getMessage();
        }
    }

public function query($query){
        $this->stmt = $this->dbh->prepare($query);
    }

public function execute(){
        return $this->stmt->execute();
    }

public function bind($param, $value, $type = null){
    if (is_null($type)) {
        switch (true) {
            case is_int($value):
                $type = PDO::PARAM_INT;
                break;
            case is_bool($value):
                $type = PDO::PARAM_BOOL;
                break;
            case is_null($value):
                $type = PDO::PARAM_NULL;
                break;
            default:
                $type = PDO::PARAM_STR;
        }
    }
    $this->stmt->bindValue($param, $value, $type);
	}

public function resultset(){
	    $this->execute();
	    return $this->stmt->fetchAll(PDO::FETCH_ASSOC);
	}

public function single(){
        $this->execute();
        return $this->stmt->fetch(PDO::FETCH_ASSOC);
	}

public function fetch(){
        $this->execute();
        return $this->stmt->fetch();
}

public function rowCount(){
        return $this->stmt->rowCount();
	}

public function lastInsertId(){
        return $this->dbh->lastInsertId();
	}


public function beginTransaction(){
	    return $this->dbh->beginTransaction();
	}

public function endTransaction(){
	    return $this->dbh->commit();
	}

public function cancelTransaction(){
	    return $this->dbh->rollBack();
	}

public function debugDumpParams(){
    return $this->stmt->debugDumpParams();
    }

public function close(){
    try{
        $this->dbh=null;
    }
    catch(PDOException $e){
        echo "Cannot terminate database session.";
    }
}
}
?>


