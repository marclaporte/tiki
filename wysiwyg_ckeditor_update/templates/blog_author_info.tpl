{* $Id$ *}
<div class="author_info">
	{if $use_author eq 'y' || $add_date eq 'y'}
		{tr}Published {/tr}
	{/if}
	{if $use_author eq 'y'}
		{tr}by{/tr} {$listpages[ix].user|userlink} 
	{/if}
	{if $add_date eq 'y'}
		{tr}on{/tr} {$listpages[ix].created|tiki_short_date}
	{/if}
	{if $show_avatar eq 'y'}
		{$listpages[ix].avatar}
	{/if}
</div>
