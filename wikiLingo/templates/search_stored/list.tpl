{extends 'layout_view.tpl'}

{block name="title"}
	{title url=$url}{$title|escape}{/title}
{/block}

{block name="content"}
{if $queryId}
	{if $description}
		<div class="well">{$description}</div>
	{/if}
	{$results}

	<h2>{tr}Other Queries{/tr}</h2>
{/if}
<table class="table">
	<thead>
		<tr>
			<th>{tr}Query{/tr}</th>
			<th>{tr}Last Modification{/tr}</th>
			<th>{tr}Actions{/tr}</th>
		</tr>
	</thead>
	<tbody>
		{foreach $queries as $q}
			<tr{if $q.queryId eq $queryId} class="active"{/if}>
				<td>
					<a href="{service controller=search_stored action=list queryId=$q.queryId}">{$q.label|escape}</a>
					<span class="label {$priorities[$q.priority].class|escape}">{$priorities[$q.priority].label|escape}</span>
				</td>
				<td>
					{if $q.lastModif}
						{$q.lastModif|tiki_short_datetime}
					{else}
						{tr}Never{/tr}
					{/if}
				</td>
				<td>
					<a class="btn btn-default btn-xs" href="{service controller=search_stored action=edit queryId=$q.queryId modal=true}" data-toggle="modal" data-target="#bootstrap-modal">{glyph name=edit} {tr}Edit{/tr}</a>
					<a class="btn btn-danger btn-xs" href="{service controller=search_stored action=delete queryId=$q.queryId modal=true}" data-toggle="modal" data-target="#bootstrap-modal">{glyph name=trash} {tr}Delete{/tr}</a>
				</td>
			</tr>
		{foreachelse}
			<tr>
				<td>
					{tr}No stored queries!{/tr}
				</td>
				<td>{tr}Never{/tr}</td>
				<td>&nbsp;</td>
			</tr>
		{/foreach}
	</tbody>
</table>

<h2>{tr}My Watch List{/tr}</h2>
{wikiplugin _name=list}
{literal}
	{filter relation={/literal}{$user}{literal} objecttype=user qualifier=tiki.watchlist.contains.invert}
	{ALTERNATE()}^{/literal}{tr}Watch List is empty.{/tr}{literal}^{ALTERNATE}
	{sort mode=modification_date_desc}
	{OUTPUT(template=table paginate=1)}
		{column label="{/literal}{tr}Title{/tr}{literal}" field="title_link" mode=raw}
		{column label="{/literal}{tr}Last Modification{/tr}{literal}" field="date"}
	{OUTPUT}

	{FORMAT(name="title_link")}{display name=title format=objectlink}{FORMAT}
	{FORMAT(name="date")}{display name=modification_date format=datetime}{FORMAT}
{/literal}
{/wikiplugin}
{/block}
