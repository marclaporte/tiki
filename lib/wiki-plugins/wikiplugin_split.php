<?php
/**
 * \file
 * $Header: /cvsroot/tikiwiki/tiki/lib/wiki-plugins/wikiplugin_split.php,v 1.24 2005-11-01 17:30:11 sylvieg Exp $
 * 
 * \brief {SPLIT} wiki plugin implementation
 * Usage:
 *
 *  {SPLIT(joincols=>[y|n|0|1],fixedsize=>[y|n|0|1],colsize=>size1|size2|...,first=>[col|line])}
 *
 * If `joincols' eq true (yes) 'colspan' attribute will be generated if column missed.
 * If `fixedsize' eq true (yes) 'width' attribute will be generated for TDs.
 * Both paramaters have default value 'y'
 * first='col': r1c1---r2c1---r3c1@@@r1c2---r2c2 (the editorial way)
 * first='line' (default): r1c1---r1c2@@@r2c1---r2c2 (the html table way)
 */

function wikiplugin_split_help() {
	return tra("Split a page into rows and columns").":<br />~np~{SPLIT(joincols=>[y|n|0|1],fixedsize=>[y|n|0|1],colsize=>size1|size2|...,first=>[col|line])}".tra("row1col1")."---".tra("row1col2")."@@@".tra("row2col1")."---".tra("row2col2")."{SPLIT}~/np~";
}

/*
 * \note This plugin should carefuly change text it have to parse
 *       because some of wiki syntaxes are sensitive for
 *       start of new line ('\n' character - e.g. lists and headers)... such
 *       user lines must stay with the same layout when applying
 *       this plugin to render them properly after...
 */
function wikiplugin_split($data, $params) {
	global $tikilib;
	global $replacement;

    // Remove first <ENTER> if exists...
    // it may be here if present after {SPLIT()} in original text
	if (substr($data, 0, 2) == "\r\n") $data = substr($data, 2);
	
	extract ($params,EXTR_SKIP);
   $fixedsize = (!isset($fixedsize) || $fixedsize == 'y' || $fixedsize == 1 ? true : false);
   $joincols  = (!isset($joincols)  || $joincols  == 'y' || $joincols  == 1 ? true : false);
   // Split data by rows and cells

	$sections = preg_split("/@@@+/", $data);
   $rows = array();
   $maxcols = 0;
   foreach ($sections as $i)
   {
   	// split by --- but not by ----
	//	$rows[] = preg_split("/([^\-]---[^\-]|^---[^\-]|[^\-]---$|^---$)+/", $i);
	//	not to eat the character close to - and to split on --- and not ----
		$rows[] = preg_split("/(?<!-)---(?!-)/", $i);
      $maxcols = max($maxcols, count(end($rows)));
   }

   // Is there split sections present?
   // Do not touch anything if no... even don't generate <table>
   if (count($rows) <= 1 && count($rows[0]) <= 1)
      return $data;

	$columnSize = floor(100 / $maxcols);
	
	// if the user specify row size in %


	if (isset($colsize)) {
	   $fixedsize=true;
		$tdsize= explode("|", $colsize);
		$tdtotal=0;
		for ($i=0;$i<$maxcols;$i++) {
		  if (!isset($tdsize[$i])) {
		    $tdsize[$i]=0;
		  }
		  $tdtotal+=$tdsize[$i];
		}
		for ($i=0;$i<$maxcols;$i++) {
		  $tdsize[$i]=floor($tdsize[$i]/$tdtotal*100);
		}		
	} else {
		$tdsize=array_fill(0,$maxcols,$columnSize);	
	}
	
	$result = '<table border="0" cellpadding="0" cellspacing="0" '.($fixedsize ? ' width="100%"' : '').'>';

    // Attention: Dont forget to remove leading empty line in section ...
    //            it should remain from previous '---' line...
    // Attention: origianl text must be placed between \n's!!!
    if (!isset($first) || $first != 'col') {
       foreach ($rows as $r) {
          $result .= "<tr>";
          $idx = 1;
          foreach ($r as $i) {
				// Remove first <ENTER> if exists
             if (substr($i, 0, 2) == "\r\n") $i = substr($i, 2);
            // Generate colspan for last element if needed
            $colspan = ((count($r) == $idx) && (($maxcols - $idx) > 0) ? ' colspan="'.($maxcols - $idx + 1).'"' : '');
            $idx++;
            // Add cell to table
    		   $result .= '<td valign="top"'.($fixedsize ? ' width="'.$tdsize[$idx-2].'%"' : '').$colspan.'>'
				// Insert "\n" at data begin (so start-of-line-sensitive syntaxes will be parsed OK)
				."\n"
				// now prepend any carriage return and newline char with br
				.preg_replace("/\\r\\n/", "<br />\r\n", $i)
                     . '</td>';
         }
        
         $result .= "</tr>";
       }
   } else {
       $result .= '<tr>';
       foreach ($rows as $r) {
          $idx = 0;
          $result .= '<td valign="top" '.($fixedsize ? ' width="'.$tdsize[$idx].'%"' : '').'>';
          foreach ($r as $i) {
                if (substr($i, 0, 2) == "\r\n")
                     $i = substr($i, 2);
                $result .= '<div class="split">'.preg_replace("/\\r\\n/", "<br />\r\n", $i).'</div>';
          }
          $result .= '</td>';
       }
       $result .= '</tr>';
   }
    // Close HTML table (no \n at end!)
	$result .= "</table>";

	return $result;
}

?>
