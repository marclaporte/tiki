{* $Id$ *}

{*
	parameters used in this template:

	* filegals_manager      : If value not empty, adds hidden input filegals_manager value=$filegals_manager

	* whatlabel             : Change form title. Default value (if $whatlabel empty) is "Find". If $whatlabel is not empty, the text presented is $whatlabel content
	* exact_match           : If set adds exact_match field
	* types                 : If not empty adds type dropdown whith types array values
	*		types_tag             : HTML element used to display types ('select' or 'checkbox'). Defaults to 'select'.
	*		find_type             : types selected value(s) - has to be a string for types_tag 'select' and an array for 'checkbox'
	* topics                : If not empty adds topic dropdown with topics array values
	* find_show_languages   : If value = 'y' adds lang dropdown with languages value dropdown
	*		find_lang             : lang dropdown selected value
	* find_show_categories  : If value = 'y' adds categories dropdown with categories array values
	* find_show_categories_multi  : If value = 'y' adds categories dropdown with categories array values with multi selector
	*		find_categId          : categories selected value
	* find_show_num_rows    : If value = 'y' adds maxRecords field. Value: maxRecords
	* find_show_date_range  : If value = 'y' adds date range to filter within
	* find_show_orphans		: If value = 'y' adds a checkbox orphan
	* find_show_sub	: If value = 'y' add a checkbox in all the tree
	* filters               : array( filter_field1 => array( option1_value => option1_text, ... ), filter_field2 => ... )
	*		filter_names          : array( filter_field1 => filter_field1_name, ... )
	*		filter_values         : array( filter_fieldX => filter_fieldX_selected_value, ... )
	* autocomplete						: name of the variable you want for autocomplete of the input field (only for <input type="text" ... >
	* find_other : If value != '', show an input box label with find_other
	* find_in :	 popup to eplain on what is the find
	*
	* Usage examples : {include file='find.tpl'}
	*                  {include file='find.tpl' find_show_languages='y' find_show_categories='y' find_show_num_rows='y'} 
*}

<div class="clearfix" data-role="collapsible" data-collapsed="false" data-theme="b" data-content-theme="b">
		<form method="post" action="{$smarty.server.PHP_SELF}" class="findtable">
		{if !empty($filegals_manager)}<input type="hidden" name="filegals_manager" value="{$filegals_manager|escape}">{/if}

		{query _type='form_input' maxRecords='NULL' type='NULL' types='NULL' find='NULL' topic='NULL' lang='NULL' exact_match='NULL' categId='NULL' cat_categories='NULL' filegals_manager='NULL' save='NULL' offset='NULL' searchlist='NULL' searchmap='NULL'}

	<label class="findtitle">
		{if empty($whatlabel)}
			<h3>{tr}Find{/tr}</h3>
		{else}
			<h3>{tr}{$whatlabel}{/tr}</h3>
		{/if}
		<input type="text" name="find" id="find" value="{$find|escape}">
		{if isset($autocomplete)}
			{jq}$("#find").tiki("autocomplete", "{{$autocomplete}}"){/jq}
		{/if}
	</label>
	{if isset($find_in)}{help url="#" desc="{tr}Find in:{/tr} {$find_in}"}{/if}

{if isset($exact_match) or 
 (!empty($find_show_sub) and $find_show_sub eq 'y') or
 (!empty($types) and ( !isset($types_tag) or $types_tag eq 'select' )) or
 !empty($topics) or
 ((isset($find_show_languages) && $find_show_languages eq 'y') and $prefs.feature_multilingual eq 'y') or
 (isset($find_show_date_range) && $find_show_date_range eq 'y') or 
 (((isset($find_show_categories) && $find_show_categories eq 'y') or (isset($find_show_categories_multi) && $find_show_categories_multi eq 'y')) and $prefs.feature_categories eq 'y' and !empty($categories)) or
 (!empty($types) and isset($types_tag) and $types_tag eq 'checkbox') or
 !empty($filters) or
 !empty($find_durations) or
 (!empty($show_find_orphans) and $show_find_orphans eq 'y') or
 !empty($find_other) or
 (isset($find_show_num_rows) && $find_show_num_rows eq 'y')  
 } {* mobile *}
	<div data-role="collapsible" data-collapsed="true" data-theme="b" data-content-theme="b"> {*mobile *}
		<h3>{tr}More search options{/tr}</h3> {*mobile *}
		<div data-role="controlgroup"> {*mobile *}
		{if isset($exact_match)}
			<label class="findexactmatch" for="findexactmatch" style="white-space: nowrap">
					{tr}Exact match{/tr}
				<input type="checkbox" name="exact_match" id="findexactmatch" {if $exact_match ne 'n'}checked="checked"{/if}>
			</label>
		{/if}
		
		{if !empty($find_show_sub) and $find_show_sub eq 'y'}
			<label class="findsub">
				{tr}and all the sub-objects{/tr}
				<input type="checkbox" name="find_sub" id="find_sub" {if !empty($find_sub) and $find_sub eq 'y'}checked="checked"{/if}>
			</label>
		{/if}
		
		{if !empty($types) and ( !isset($types_tag) or $types_tag eq 'select' )}
			<select name="type" class="findtypes">
				<option value='' {if $find_type eq ''}selected="selected"{/if}>{tr}any type{/tr}</option>
				{section name=t loop=$types}
					<option value="{$types[t].type|escape}" {if $find_type eq $types[t].type}selected="selected"{/if}>
						{$types[t].type|tr_if|escape}
					</option>
				{/section}
			</select>
		{/if}
		
		{if !empty($topics)}
			<select name="topic" class="findtopics">
				<option value='' {if $find_topic eq ''}selected="selected"{/if}>{tr}any topic{/tr}</option>
				{foreach $topics as $topic}
					<option value="{$topic.topicId|escape}" {if $find_topic eq $topic.topicId}selected="selected"{/if}>
						{$topic.name|tr_if|escape}
					</option>
				{/foreach}
			</select>
		{/if}
		
		{if (isset($find_show_languages) && $find_show_languages eq 'y') and $prefs.feature_multilingual eq 'y'}
			<span class="findlang">
				<select name="lang" class="in">
					<option value='' {if $find_lang eq ''}selected="selected"{/if}>{tr}any language{/tr}</option>
					{section name=ix loop=$languages}
						<option value="{$languages[ix].value|escape}" {if $find_lang eq $languages[ix].value}selected="selected"{/if}>
							{$languages[ix].name}
						</option>
					{/section}
				</select>
				{if isset($find_show_languages_excluded) and $find_show_languages_excluded eq 'y'}
				<label>{tr}not in{/tr}
					<select name="langOrphan" class="notin">
						<option value='' {if $find_langOrphan eq ''}selected="selected"{/if}></option>
						{section name=ix loop=$languages}
							<option value="{$languages[ix].value|escape}" {if $find_langOrphan eq $languages[ix].value}selected="selected"{/if}>
								{$languages[ix].name}
							</option>
						{/section}
					</select>
				</label>
				{/if}
			</span>
		{/if}
		
		{if isset($find_show_date_range) && $find_show_date_range eq 'y'}
			<div id="date_range_find">
				<span class="findDateFrom">
					{tr}From{/tr}
					{html_select_date time=$find_date_from prefix="find_from_" month_format="%m"}
				</span>
				<span class="findDateTo">
					{tr}to{/tr}
					{html_select_date time=$find_date_to prefix="find_to_" month_format="%m"}
				</span>
			</div>
		{/if}
		
		{if ((isset($find_show_categories) && $find_show_categories eq 'y') or (isset($find_show_categories_multi) && $find_show_categories_multi eq 'y')) and $prefs.feature_categories eq 'y' and !empty($categories)}
			<div class="category_find">
			{if $find_show_categories_multi eq 'n' || $findSelectedCategoriesNumber <= 1}
			<div id="category_singleselect_find">
				<select name="categId" class="findcateg">
					<option value='' {if $find_categId eq ''}selected="selected"{/if}>{tr}any category{/tr}</option>
					{foreach $categories as $identifier => $category}
						<option value="{$identifier}" {if $find_categId eq $identifier}selected="selected"{/if}>
							{$category.categpath|tr_if|escape}
						</option>
					{/foreach}
				</select>
				{if $prefs.javascript_enabled eq 'y' && $find_show_categories_multi eq 'y'}<a href="#" onclick="show('category_multiselect_find');hide('category_singleselect_find');javascript:document.getElementById('category_select_find_type').value='y';">{tr}Multiple select{/tr}</a>{/if}
				<input id="category_select_find_type" name="find_show_categories_multi" value="n" type="hidden">
			</div>
			{/if}
			<div id="category_multiselect_find" style="display: {if $find_show_categories_multi eq 'y' && $findSelectedCategoriesNumber > 1}block{else}none{/if};">
		  		<div class="multiselect"> 
		  			{if count($categories) gt 0}
						{$cat_tree}
						<div class="clearfix">
						{if $tiki_p_admin_categories eq 'y'}
		    				<div class="pull-right"><a href="tiki-admin_categories.php" class="link">{tr}Admin Categories{/tr} {icon _id='wrench'}</a></div>
						{/if}
						{select_all checkbox_names='cat_categories[]' label="{tr}Select/deselect all categories{/tr}"}
					{else}
						<div class="clearfix">
		 				{if $tiki_p_admin_categories eq 'y'}
		    				<div class="pull-right"><a href="tiki-admin_categories.php" class="link">{tr}Admin Categories{/tr} {icon _id='wrench'}</a></div>
		 				{/if}
		    			{tr}No categories defined{/tr}
		  			{/if}
					</div> {* end .clear *}
				</div> {* end #multiselect *}
			</div> {* end #category_multiselect_find *}
			</div>
		{/if}
		
		{if !empty($types) and isset($types_tag) and $types_tag eq 'checkbox'}
			<div class="findtypes">
				<ul>
					<li>
						{tr}in:{/tr}
					</li>
					{foreach key=key item=value from=$types}
						<li>
							<input type="checkbox" name="types[]" value="{$key|escape}" {if is_array($find_type) && in_array($key, $find_type)}checked="checked"{/if}> {tr}{$value}{/tr}
					</li>
				{/foreach}
				</ul>
			</div>
		{/if}
		
		{if !empty($filters)}
			<div class="findfilter">
				{foreach key=key item=item from=$filters}
					<span>
						{$filter_names.$key}{tr}:{/tr}
					</span>
					<select name="findfilter_{$key}">
						<option value='' {if $filter_values.$key eq ''}selected="selected"{/if}>--</option>
						{foreach key=key2 item=value from=$item}
							<option value="{$key2}"{if $filter_values.$key eq $key2} selected="selected"{/if}>{$value}</option>
						{/foreach}
					</select>
				{/foreach}
			</div>
		{/if}
		
		{if !empty($find_durations)}
			{foreach key=key item=duration from=$find_durations}
				<label class="find_duration">
				{tr}{$duration.label}{/tr}
				{html_select_duration prefix=$duration.prefix default=$duration.default default_unit=$duration.default_unit}
				</label>
			{/foreach}
		{/if}
		
		{if !empty($show_find_orphans) and $show_find_orphans eq 'y'}
			<label class="find_orphans" for="find_orphans">
				   {tr}Orphans{/tr}
				   <input type="checkbox" name="find_orphans" id="find_orphans" {if isset($find_orphans) and $find_orphans eq 'y'}checked="checked"{/if}>
			</label>
		{/if}
		
		{if !empty($find_other)}
			<label class="find_other" for="find_other">
				   {tr}{$find_other}{/tr}
				   <input type="text" name="find_other" id="find_other" value="{if !empty($find_other_val)}{$find_other_val|escape}{/if}">
			</label>
		{/if}
		
		{if isset($find_show_num_rows) && $find_show_num_rows eq 'y'}
			<label class="findnumrows" for="findnumrows">
					{tr}Number of displayed rows{/tr}
					<input type="text" name="maxRecords" id="findnumrows" value="{$maxRecords|escape}" size="3">
			</label>
		{/if}
		</div> {*mobile *}
	</div> {*mobile *}
{/if} {*mobile *}
<label class="findsubmit">
	<input type="submit" class="btn btn-default btn-sm" data-theme="a" name="search" value="{tr}Go{/tr}">
	{if !empty($find) or !empty($find_type) or !empty($find_topic) or !empty($find_lang) or !empty($find_langOrphan) or !empty($find_categId) or !empty($find_orphans) or !empty($find_other_val) or $maxRecords ne $prefs.maxRecords}
		{*  $find_date_from & $find_date_to get set usually *}
		<span class="button">
			<a data-role="button" data-inline="true" data-mini="true" href="{$smarty.server.PHP_SELF}?{query find='' type='' types='' topic='' lang='' langOrphan='' exact_match='' categId='' maxRecords=$prefs.maxRecords find_from_Month='' find_from_Day='' find_from_Year='' find_to_Month='' find_to_Day='' find_to_Year=''}" title="{tr}Clear Filter{/tr}">{tr}Clear Filter{/tr}</a>
		</span>
	{/if}
	{if (isset($gmapbuttons) && $gmapbuttons) and (isset($mapview) && $mapview)}
		<input class="btn btn-default" type="submit" name="searchlist" value="{tr}List View{/tr}">
		<input type="hidden" name="mapview" value="y">
	{elseif (isset($gmapbuttons) && $gmapbuttons)}
		<input type="submit" class="btn btn-default btn-sm" name="searchmap" value="{tr}Map View{/tr}">
		<input type="hidden" name="mapview" value="n">
	{/if}
</label>

</form>
</div>

