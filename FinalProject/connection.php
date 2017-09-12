<?php
  $db = "(DESCRIPTION=(ADDRESS_LIST = (ADDRESS = (PROTOCOL = TCP)(HOST = fourier.cs.iit.edu)(PORT = 1521)))(CONNECT_DATA=(SID=orcl)))" ;
  $conn = oci_connect("username", "password", $db);
  
  if(!$conn){
    $m = oci_error();
    echo $m['message'], "\n";
    echo "Failed to connect to database";
    exit;
  }else{
    echo "SUCCESS";
  }    
  $stdid = oci_parse($conn, "SELECT * FROM STUDENT");
  oci_execute($stdid);

  while(($row = oci_fetch_array($stdid))!=false){
    echo $row['STUDENT_ID'];
  }

$username = $_POST['username'];

if ($username == "letmein") {

print ("Welcome back, friend!");

}
else {

print ("You're not a member of this site");

}
?>
