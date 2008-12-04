{* $Id$ *}
{popup_init src="lib/overlib.js"}

{title admpage="calendar"}
	{if $displayedcals|@count eq 1}
		{tr}Calendar{/tr}: {assign var=x value=$displayedcals[0]}{$infocals[$x].name}
	{else}
		{tr}Calendar{/tr}
	{/if}
{/title}

<div id="calscreen">

	<div id="configlinks" style="float:right;margin:5px;">
		{if $displayedcals|@count eq 1 and $user and $prefs.feature_user_watches eq 'y'}
			{if $user_watching eq 'y'}
				<a href="tiki-calendar.php?watch_event=calendar_changed&amp;watch_action=remove" class="icon">{icon _id='no_eye' alt="{tr}Stop Monitoring this Page{/tr}"}</a>
			{else}
				<a href="tiki-calendar.php?watch_event=calendar_changed&amp;watch_action=add" class="icon">{icon _id='eye' alt="{tr}Monitor this Page{/tr}"}</a>
			{/if}
		{/if}

		{if $tiki_p_admin_calendar eq 'y' or $tiki_p_admin eq 'y'}
			{if $displayedcals|@count eq 1}
				{button href="tiki-admin_calendars.php?calendarId=$displayedcals[0]" _text="{tr}Admin Calendar{/tr}"}
			{else}
				{button href="tiki-admin_calendars.php" _text="{tr}Admin Calendar{/tr}"}
			{/if}
		{/if}

		{if $tiki_p_add_events eq 'y'}
			{button href="tiki-calendar_edit_item.php" _text="{tr}Add Event{/tr}"}
		{/if}

		{if count($listcals) >= 1}
			{button href="#" _onclick="toggle('filtercal');" _text="{tr}Visible Calendars{/tr}"}

			{if count($thiscal)}
				{foreach item=k from=$listcals name=listc}
					{if $thiscal.$k}
						{assign var=thiscustombgcolor value=$infocals.$k.custombgcolor}
						{assign var=thiscustomfgcolor value=$infocals.$k.customfgcolor}
						{assign var=thisinfocalsname value=$infocals.$k.name}
						{button href="#" _style="background-color:#$thiscustombgcolor;color:#$thiscustomfgcolor" _onclick="toggle('filtercal');" _text="$thisinfocalsname"}
					{/if}
				{/foreach}
			{else}
				{button href="" _style="background-color:#fff;padding:0 4px;" _text="{tr}None{/tr}"}
			{/if}
		{/if}

		{if $viewlist eq 'list'}
			{button href="?viewlist=table" _text="{tr}Calendar View{/tr}"}
		{else}
			{button href="?viewlist=list" _text="{tr}List View{/tr}"}
		{/if}
	</div>

	<br />

	<div class="navbar" align="right">
		{if $user and $prefs.feature_user_watches eq 'y'}
			{if $category_watched eq 'y'}
				{tr}Watched by categories{/tr}:
				{section name=i loop=$watching_categories}
					{button href="tiki-browse_categories?parentId=$watching_categories[i].categId" _text=$watching_categories[i].name}
					&nbsp;
				{/section}
			{/if}	
		{/if}
	</div>

	{if count($listcals) >= 1}
		<form id="filtercal" method="get" action="{$myurl}" name="f" style="display:none;">
			<div class="caltitle">{tr}Group Calendars{/tr}</div>
			<div class="caltoggle">
				<input name="calswitch" id="calswitch" type="checkbox" onclick="switchCheckboxes(this.form,'calIds[]',this.checked);"/> 
				<label for="calswitch">{tr}Check / Uncheck All{/tr}</label>
			</div>
			{foreach item=k from=$listcals}
				<div class="calcheckbox">
					<input type="checkbox" name="calIds[]" value="{$k|escape}" id="groupcal_{$k}" {if $thiscal.$k}checked="checked"{/if} />
					<label for="groupcal_{$k}" class="calId{$k}">{$infocals.$k.name} (id #{$k})</label>
				</div>
			{/foreach}
			<div class="calinput">
				<input type="submit" name="refresh" value="{tr}Refresh{/tr}"/>
			</div>
		</form>
	{/if}

	{include file="tiki-calendar_nav.tpl"}

	{if $viewlist eq 'list'}
		{include file="tiki-calendar_listmode.tpl"'}
	{elseif $viewmode eq 'day'}
		{include file="tiki-calendar_daymode.tpl"}
	{else}
		{include file="tiki-calendar_calmode.tpl"}
	{/if}
</div>
