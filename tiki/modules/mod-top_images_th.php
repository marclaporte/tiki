<?php

//this script may only be included - so its better to die if called directly.
if (strpos($_SERVER["SCRIPT_NAME"],basename(__FILE__)) !== false) {
  header("location: index.php");
}

include_once ("lib/imagegals/imagegallib.php");

$ranking = $imagegallib->list_images(0, $module_rows, 'hits_desc', '');
$smarty->assign('modTopImages', $ranking["data"]);

?>
