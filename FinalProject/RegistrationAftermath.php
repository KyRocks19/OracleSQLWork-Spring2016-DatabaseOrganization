<!DOCTYPE html>
<html>
	<head>
		<title>Registration</title>
		<link rel="stylesheet" href="registrationstyle.css">
	</head>
	<body>
		<div id="main_container">
			<div id="header">
				<div id = "iltech_logo">
				Illinois Tech OA
				</div>	 
			</div>
			<div id="body_section">
				<p>Welcome to IIT! Nice to meet you here!</p>
				<div id="right">
					<div id ="form">
					  <?php
					    $fname = $_POST['firstname'];
					    $mname = $_POST['midname'];
					    $lname = $_POST['lastname'];
					    $email = $_POST['email'];
					    $DYear = $_POST['DegreeYear'];
					    $DSem = $_POST['DegreeSemester'];
					    $DType = $_POST['DegreeType'];
					    $DStatus = $_POST['DegreeStatus'];
					    $Jobs = $_POST['Jobs'];
					    $db = "(DESCRIPTION=(ADDRESS_LIST = (ADDRESS = (PROTOCOL = TCP)(HOST = fourier.cs.iit.edu)(PORT = 1521)))(CONNECT_DATA=(SID=orcl)))" ;
  					    $conn = oci_connect("actual_username", "actual_password", $db);
					    if(!$conn){
					      $m = oci_error();
					      echo $m['message'], "\n";
					      echo "Failed to connect to database";
					      exit;
					    }else{
					      echo "<p>SUCCESS</p>";
					    }
					    $stdid = oci_parse($conn, "INSERT INTO Student VALUES (1000, $fname, $lname, $email, $DYear, $DSem, NULL, $DStatus, NULL, $Jobs);");
					    oci_execute($stdid);
					    ?>
						<p>You entered the following information:</p>
						<p><?php print($fname." ".$mname." ".$lname);?></p>
						<p><?php print($email);?></p>
						<p><?php print($DSem." ".$DYear);?></p>
						<p><?php print($DType);?></p>
						<p><?php print($DStatus);?></p>
						<p><?php print($Jobs);?></p>
						<p>Is this correct?</p>
						<table>
						<td>
						<form NAME ="incorrect" METHOD ="POST" ACTION = "Registration">
						<input type="Submit" name="SubmitIncorrect" value="Go Back">
						</form>
						</td>
						<td>
						<form NAME ='correct' METHOD ='POST'>
						<input type='button' name='SubmitCorrect' value='Yes'>
						</form>
						<?php
						if($_POST)
						if(isset($_POST['SubmitCorrect'])) 
						{ 
						    echo "hey"; 
						} 
						?>
						</td>
						</table>
					</div>
				</div>
			</div>
		</div>
	</body>
	</html>
