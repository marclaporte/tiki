{* $Id$ *}
{title help="Theme+Control"}{tr}Theme Control Center: Objects{/tr}{/title}

{remarksbox type="notice" title="{tr}Notice{/tr}"}
<b>{tr}Theme is selected as follows:{/tr}</b><br>
1. {tr}If a theme is assigned to the individual object that theme is used.{/tr}<br>
2. {tr}If not then if a theme is assigned to the object's category that theme is used{/tr}<br>
3. {tr}If not then a theme for the section is used{/tr}<br>
4. {tr}If none of the above was selected the user theme is used{/tr}<br>
5. {tr}Finally if the user didn't select a theme the default theme is used{/tr}
{/remarksbox}

<div class="t_navbar btn-group form-group">
	{button href="tiki-theme_control.php" class="btn btn-default" _text="{tr}Control by Categories{/tr}"}
	{button href="tiki-theme_control_sections.php" class="btn btn-default" _text="{tr}Control by Sections{/tr}"}
</div>

<h2>{tr}Assign themes to objects{/tr}</h2>
<form id='objform' action="tiki-theme_control_objects.php" method="post">
	<select name="type" onchange="javascript:document.getElementById('objform').submit();">
		{section name=ix loop=$objectypes}
			<option value="{$objectypes[ix]|escape}" {if $type eq $objectypes[ix]}selected="selected"{/if}>{$objectypes[ix]}</option>
		{/section}
	</select>
<!--<input type="submit" class="btn btn-default btn-sm" name="settype" value="{tr}Set{/tr}">-->
	<table class="formcolor">
		<tr>
			<td colspan="3">{tr}Object{/tr}</td>
        </tr>
		<tr>
			<td colspan="3">
				<select name="objdata">
					{section name=ix loop=$objects}
						<option value="{$objects[ix].objId|escape}|{$objects[ix].objName}" {if $a_object eq $objects[ix].objId|cat:'|'|cat:$objects[ix].objName}selected="selected"{/if}>{$objects[ix].objName}</option>
					{/section}
				</select>
			</td> 
        </tr>
        <tr>           
			<td>{tr}Theme{/tr}</td>
			<td>{tr}Option{/tr}</td>
			<td>&nbsp;</td>
		</tr>
        <tr>
			<td>
				<select name="theme" onchange="this.form.submit();">
					{section name=ix loop=$styles}
						<option value="{$styles[ix]|escape}" {if $a_style eq $styles[ix]}selected="selected"{/if}>{$styles[ix]}</option>
					{/section}
				</select>
			</td>
			<td>
				<select name="theme-option">
					<option value="">{tr}None{/tr}</option>
					{section name=ix loop=$style_options}
						<option value="{$style_options[ix]|escape}">{$style_options[ix]}</option>
					{/section}
				</select>
			</td>
			<td>
				<input type="submit" class="btn btn-default btn-sm" name="assign" value="{tr}Assign{/tr}">
			</td>
		</tr>
	</table>
</form> 

<h2>{tr}Assigned objects{/tr}</h2>

{include file='find.tpl'}

<form action="tiki-theme_control_objects.php" method="post">
	<input type="hidden" name="type" value="{$type|escape}">
    <div class="table-responsive">
    <div class="themeobj-table">
	<table class="table normal">
		<tr>
			<th><input type="submit" class="btn btn-default btn-sm" name="delete" value="{tr}Del{/tr}"></th>
			<th>
				<a href="tiki-theme_control_objects.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'type_desc'}type_asc{else}type_desc{/if}">
					{tr}Type{/tr}
				</a>
			</th>
			<th>
				<a href="tiki-theme_control_objects.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'name_desc'}name_asc{else}name_desc{/if}">
					{tr}Name{/tr}
				</a>
			</th>
			<th>
				<a href="tiki-theme_control_objects.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'theme_desc'}theme_asc{else}theme_desc{/if}">
					{tr}Theme{/tr}</a>
			</th>
		</tr>

		{section name=user loop=$channels}
			<tr>
				<td class="checkbox-cell">
					<input type="checkbox" name="obj[{$channels[user].objId}]">
				</td>
				<td class="text">{$channels[user].type}</td>
				<td class="text">{$channels[user].name}</td>
				<td class="text">{$channels[user].theme}</td>
			</tr>
		{/section}
	</table>
    </div>
    </div>
</form>

{pagination_links cant=$cant_pages step=$prefs.maxRecords offset=$offset}{/pagination_links} 
