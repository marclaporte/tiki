{* $Id$ *}

{tikimodule error=$module_params.error title=$tpl_module_title name="directory_top_sites" flip=$module_params.flip decorations=$module_params.decorations nobox=$module_params.nobox notitle=$module_params.notitle}
 {if $nonums != 'y'}<ol>{else}<ul>{/if}
    {section name=ix loop=$modTopdirSites}
        <li>
		<a class="linkmodule" href="tiki-directory_redirect.php?siteId={$modTopdirSites[ix].siteId}" {if $prefs.directory_open_links eq 'n'}target="_new"{/if}>
            {$modTopdirSites[ix].name|escape}
          </a>
      </li>
    {/section}
 {if $nonums != 'y'}</ol>{else}</ul>{/if}
{/tikimodule}