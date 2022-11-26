<?php
$file_input = file_get_contents(__DIR__ . "/phpx.inp");
copy("phpx.inp", "script.php");
ob_start();
require(  __DIR__ . "/script.php");
unlink(__DIR__ . "/script.php");
$result = ob_get_contents();
ob_end_clean();
$fh = fopen( __DIR__ . "/phpx.out", "w");
fwrite($fh,  $result);
fclose($fh);
//unlink(__DIR__ . "/phpx.inp");
?>
