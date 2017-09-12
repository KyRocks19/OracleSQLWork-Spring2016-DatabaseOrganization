<html>
  <head>
    <title>A BASIC HTML FORM</title>
    <?PHP
      $username = $_POST['username'];
      if($username){ 
        

        if ($username == "letmein") {
      
           print ("Welcome back, friend!");
      
        } else {
      
           print ("You're not a member of this site");
      
        }
      } else {

        $username ="";

      }
    ?>
  </head>
  <body>

    <FORM NAME ="form1" METHOD ="POST" ACTION = "basicform.php">

      <INPUT TYPE = "TEXT" VALUE ="<?PHP print $username ; ?>" NAME = "username">
      <INPUT TYPE = "Submit" Name = "Submit1" VALUE = "Login">
    <p>
      What is your Gender?
      <select name="formGender">
	<option value="NULL">Select...</option>
	<option value="M">Male</option>
	<option value="F">Female</option>
      </select>
    </p>
    </FORM>
    <?php
        $gender = $_POST['formGender'];
      if($gender === "NULL"){
      print("SOCIETY DEMANDS YOU CHOOSE, BITCH.");
      } ELSE {
      print($gender);
      }
    ?>
  </body>
</html>
