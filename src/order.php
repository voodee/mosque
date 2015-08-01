<?php
  header('Content-Type: text/html; charset=utf-8');
  require 'PHPMailerAutoload.php';
  
  function cleanupentries($entry) {
  	$entry = trim($entry);
  	$entry = stripslashes($entry);
  	$entry = htmlspecialchars($entry);
  	return $entry;
  }
  
  $f_name = cleanupentries($_POST["name"]);
  $f_tel = cleanupentries($_POST["tel"]);
  $f_email = cleanupentries($_POST["email"]);
  $f_desc = cleanupentries($_POST["desc"]);
  $f_type = cleanupentries($_POST["type"]);
  $from_ip = $_SERVER['REMOTE_ADDR'];
  $from_browser = $_SERVER['HTTP_USER_AGENT'];
  
  
  $mail = new PHPMailer;
  $mail->CharSet = 'utf-8';

  $mail->isSMTP();                                      // Set mailer to use SMTP
  $mail->Host = 'localhost';  // Specify main and backup SMTP servers
  $mail->SMTPAuth = true;                               // Enable SMTP authentication
  $mail->Username = 'noreply@мобильнаямечеть.рф';       // SMTP username
  $mail->Password = '293D158E';                         // SMTP password
  $mail->SMTPSecure = 'tls';                            // Enable TLS encryption, `ssl` also accepted
  $mail->Port = 587;     
  //$mail->SMTPDebug = 3;                               // Enable verbose debug output
  // TCP port to connect to
  
  $mail->From = 'lp@halalguide.me';
  $mail->FromName = 'Robot';
  $mail->addAddress('halalguiderussia@gmail.com'); 
  $mail->AddBCC('eedoov@gmail.com');  
  
  
  $mail->Subject = "Заявка ЛП МобильнаяМечеть";
  $mail->Body    ="Это пиьсмо создано " . date('d-m-Y H:i:s') . 
    "\n\nИмя: " . $f_name . 
    "\nТелефон: " . $f_tel . 
    "\nE-mail: " . $f_email . 
    "\nТип намаза: " . $f_type . 
    "\nКомментарий: " . $f_desc . 
    "\n\n\nИнформация для системного администратора:\n" . $from_ip . "\n" . $from_browser;
  
  
  if (!$f_tel) {
  	echo "не введён телефон!";
  } else if (!$f_name){
  	echo "не введено имя!";
  } else {
    if(!$mail->send()) {
        echo 'Ошибка: ' . $mail->ErrorInfo;
    } else {
      echo true;
    }
  }
  exit;
?>