{* $Header: /cvsroot/tikiwiki/tiki/templates/styles/musus/modules/mod-forums_most_read_topics.tpl,v 1.2 2004-01-09 15:29:32 musus Exp $ *}

{if $feature_forums eq 'y'}
{if $nonums eq 'y'}
{eval var="`$module_rows` {tr}Most read topics{/tr}" assign="tpl_module_title"}
{else}
{eval var="{tr}Most read topics{/tr}" assign="tpl_module_title"}
{/if}
{tikimodule title=$tpl_module_title name="forums_most_read_topics"}
  <table>
    {section name=ix loop=$modForumsMostReadTopics}
      <tr>
        {if $nonums != 'y'}<td class="module" valign="top">{$smarty.section.ix.index_next})</td>{/if}
        <td class="module">
          <a class="linkmodule" href="{$modForumsMostReadTopics[ix].href}">
            {$modForumsMostReadTopics[ix].name}
          </a>
        </td>
      </tr>
    {/section}
  </table>
{/tikimodule}
{/if}
