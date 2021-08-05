<?php
	header('content-type:text/html; charset= utf-8');
	echo '过来的登录名是：'.$_POST['user'];
	echo '<br>';
	echo '传过来的密码是'.$_POST['pwd'];
?>
