{* $Header: /cvsroot/tikiwiki/tiki/templates/styles/musus/modules/mod-search_wiki_page.tpl,v 1.1 2004-01-07 04:31:24 musus Exp $ *}

{tikimodule title="{tr}Search Wiki PageName{/tr}" name="search_box"}
  <form class="forms" method="post" action="tiki-listpages.php">
    <input name="find" size="14" type="text" accesskey="s" value="{$find}"/>
    <input type="submit" class="wikiaction" name="search" value="{tr}go{/tr}"/> 
  </form>
{/tikimodule}
