{* $Id$ *}

{if $userwatch ne $user}
	{title help="User+Preferences"}{tr}User Preferences:{/tr} {$userwatch}{/title}
{else}
	{title help="User+Preferences"}{tr}User Preferences{/tr}{/title}
{/if}

{if $userwatch eq $user or $userwatch eq ""}
	{include file='tiki-mytiki_bar.tpl'}
{/if}

{if $tiki_p_admin_users eq 'y'}
	<div class="t_navbar btn-group form-group">
		{assign var=thisuser value=$userinfo.login}
		{button href="tiki-assignuser.php?assign_user=$thisuser" class="btn btn-default" _text="{tr}Assign Group{/tr}"}
		{button href="tiki-user_information.php?view_user=$thisuser" class="btn btn-default" _text="{tr}User Information{/tr}"}
	</div>
{/if}


{if $tikifeedback}
	<div class="simplebox highlight">
		{section name=n loop=$tikifeedback}
			<div>{$tikifeedback[n].mes}</div>
		{/section}
	</div>
{/if}

{tabset name="mytiki_user_preference"}

{if $prefs.feature_userPreferences eq 'y'}
	{tab name="{tr}Personal Information{/tr}"}
        <h2>{tr}Personal Information{/tr}</h2>
		<form role="form" action="tiki-user_preferences.php" method="post">
            <input type="hidden" name="view_user" value="{$userwatch|escape}">
            <div class="form-group">
                <label class="control-label" for="userIn">{tr}User{/tr}</label>
                <input class="form-control" disabled value="{$userinfo.login|escape}">
            </div>
            <div class="form-group">
                <label class="control-label" for="realName">{tr}Real Name{/tr}</label>
                <input class="form-control" type="text" name="realName" value="{$user_prefs.realName|escape}"
                        {if $prefs.auth_ldap_nameattr eq '' || $prefs.auth_method ne 'ldap'}{else}disabled{/if}>
            </div>
            <div class="form-group">
                <label class="control-label">{tr}Avatar{/tr}</label>
                <div class="col-md-12" style="margin-bottom:10px">
                    {if $prefs.user_use_gravatar eq 'y'}
                        <a class="link" href="http://www.gravatar.com" target="_blank">{tr}Pick user Avatar{/tr}</a>
                    {else}
                        <a class="link" target="_blank" href="tiki-pick_avatar.php{if $userwatch ne $user}?view_user={$userwatch}{/if}" class="link">{tr}Pick user Avatar{/tr}</a>
                    {/if}
                </div>
            </div>
            {if $prefs.feature_community_gender eq 'y'}
            <div class="form-group">
                <label class="control-label" for="gender">{tr}Gender{/tr}</label>
                <div class="col-md-12">
                    <label class="radio-inline">
                        <input type="radio" name="gender" value="Male" {if $user_prefs.gender eq 'Male'}checked="checked"{/if}> {tr}Male{/tr}
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="gender" value="Female" {if $user_prefs.gender eq 'Female'}checked="checked"{/if}> {tr}Female{/tr}
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="gender" value="Hidden" {if $user_prefs.gender eq 'Hidden'}checked="checked"{/if}> {tr}Hidden{/tr}
                    </label>
                </div>
            </div><table class="formcolor">
            {/if}
            <div class="form-group">
                <label class="control-label" for="country">{tr}Country{/tr}</label>
                {*{if isset($user_prefs.country) && $user_prefs.country != "None" && $user_prefs.country != "Other"}*}
                    {*{$userinfo.login|countryflag}*}
                {*{/if}*}
                <select name="country" id="country" class="form-control">
                    <option value="Other" {if $user_prefs.country eq "Other"}selected="selected"{/if}>
                        {tr}Other{/tr}
                    </option>
                    {foreach from=$flags item=flag key=fval}
                        {if $fval ne "Other"}
                            <option value="{$fval|escape}" {if $user_prefs.country eq $fval}selected="selected"{/if}>
                                {$flag|stringfix}
                            </option>
                        {/if}
                    {/foreach}
                </select>
            </div>
            <div class="form-group">
                <label class="control-label" for="location">{tr}Location{/tr}</label>
                <div class="map-container" style="height: 250px;" data-geo-center="{defaultmapcenter}" data-target-field="location">
                </div>
                <input type="hidden" name="location" value="{$location|escape}">
            </div>
            {if $prefs.feature_wiki eq 'y' and $prefs.feature_wiki_userpage eq 'y'}
                <div class="form-group">
                    <label class="control-label">{tr}Your Personal Wiki Page{/tr}</label>
                    <div class="col-md-12">
                        {if $userPageExists eq 'y'}
                            <a class="link" href="tiki-index.php?page={$prefs.feature_wiki_userpage_prefix}{$userinfo.login}" title="View">
                                {$prefs.feature_wiki_userpage_prefix}{$userinfo.login|escape}
                            </a>
                            (<a class="link" href="tiki-editpage.php?page={$prefs.feature_wiki_userpage_prefix}{$userinfo.login}">
                                {tr}Edit{/tr}
                            </a>)
                        {else}
                            {$prefs.feature_wiki_userpage_prefix}{$userinfo.login|escape}
                            (<a class="link" href="tiki-editpage.php?page={$prefs.feature_wiki_userpage_prefix}{$userinfo.login}">
                            {tr}Create{/tr}
                        </a>)
                        {/if}
                    </div>
                </div>
            {/if}
            {if $prefs.userTracker eq 'y' && $usertrackerId}
            <div class="form-group">
                <div class="col-md-12">
                    {if $tiki_p_admin eq 'y' and !empty($userwatch) and $userwatch neq $user}
                        <label class="control-label">{tr}User's personal tracker information{/tr}</label>
                        <div class="col-md-12">
                            <a class="link" href="tiki-view_tracker_item.php?trackerId={$usertrackerId}&user={$userwatch|escape:url}&view=+user">
                                {tr}View extra information{/tr}
                            </a>
                        </div>
                    {else}
                        <label class="control-label">{tr}Your personal tracker information{/tr}</label>
                        <div class="col-md-12">
                            <a class="link" href="tiki-view_tracker_item.php?view=+user">
                                {tr}View extra information{/tr}
                            </a>
                        </div>
                    {/if}
                </div>
            </div>
            {/if}
            {* Custom fields *}
            {section name=ir loop=$customfields}
                {if $customfields[ir].show}
                    <label>{$customfields[ir].label}:
                    <input type="{$customfields[ir].type}" name="{$customfields[ir].prefName}"
                           value="{$customfields[ir].value}" size="{$customfields[ir].size}"></label>
                {/if}
            {/section}
            <div class="form-group">
                <label class="control-label" for="user_information">{tr}User Information{/tr}</label>
                <select class="form-control" id="user_information" name="user_information">
                    <option value='private' {if $user_prefs.user_information eq 'private'}selected="selected"{/if}>
                        {tr}Private{/tr}
                    </option>
                    <option value='public' {if $user_prefs.user_information eq 'public'}selected="selected"{/if}>
                        {tr}Public{/tr}
                    </option>
                </select>
            </div>
            <div class="form-group">
                <label class="control-label">Last login</label>
                <p class="form-control-static">{$userinfo.lastLogin|tiki_long_datetime}</p>
            </div>

            <input type="submit" class="btn btn-primary" name="new_prefs" value="Save changes">
	{/tab}
	{tab name="{tr}Preferences{/tr}"}
        <h2>{tr}Preferences{/tr}</h2>

		<h3>{tr}General settings{/tr}</h3>

        <div class="form-group">
            <label class="control-label" for="email_isPublic">{tr}Is email public? (uses scrambling to prevent spam){/tr}</label>
            {if $userinfo.email}
                <select id="email_isPublic" name="email_isPublic" class="form-control">
                    {section name=ix loop=$scramblingMethods}
                        <option value="{$scramblingMethods[ix]|escape}" {if $user_prefs.email_isPublic eq $scramblingMethods[ix]}selected="selected"{/if}>
                            {$scramblingEmails[ix]}
                        </option>
                    {/section}
                </select>
            {else}
                <p class="form-control-static">{tr}Unavailable - please set your email below{/tr}</p>
            {/if}
        </div>
        <div class="form-group">
            <label class="control-label" for="mailCharset">{tr}Does your mail reader need a special charset?{/tr}</label>
            <select id="mailCharset" name="mailCharset" class="form-control">
                {section name=ix loop=$mailCharsets}
                    <option value="{$mailCharsets[ix]|escape}" {if $user_prefs.mailCharset eq $mailCharsets[ix]}selected="selected"{/if}>
                        {$mailCharsets[ix]}
                    </option>
                {/section}
            </select>
        </div>
        {if $prefs.change_theme eq 'y' && empty($group_style)}
        <div class="form-group">
            <label class="control-label" for="myStyle">Theme</label>
            <select id="myStyle" name="myStyle" class="form-control">
                <option value="" {*style="font-style:italic;border-bottom:1px dashed #666;"*}>
                    {tr}Site default{/tr}
                </option>
                {section name=ix loop=$styles}
                    {if count($prefs.available_styles) == 0 || empty($prefs.available_styles[0]) || in_array($styles[ix], $prefs.available_styles)}
                        <option value="{$styles[ix]|escape}" {if $user_prefs.theme eq $styles[ix]}selected="selected"{/if}>
                            {$styles[ix]}
                        </option>
                    {/if}
                {/section}
            </select>
            {if $prefs.feature_editcss eq 'y' and $tiki_p_create_css eq 'y'}
                <a href="tiki-edit_css.php" class="link" title="{tr}Edit CSS{/tr}">{tr}Edit CSS{/tr}</a>
            {/if}
        </div>
        {/if}
        {if $prefs.change_language eq 'y'}
        <div class="form-group">
            <label class="control-label" for="language">{tr}Preferred Language{/tr}</label>
            <select id="language" name="language" class="form-control">
                {section name=ix loop=$languages}
                    <option value="{$languages[ix].value|escape}" {if $user_prefs.language eq $languages[ix].value}selected="selected"{/if}>
                        {$languages[ix].name}
                    </option>
                {/section}
                <option value='' {if !$user_prefs.language}selected="selected"{/if}>
                    {tr}Site default{/tr}
                </option>
            </select>
        </div>
        {/if}
        {if $prefs.feature_multilingual eq 'y'}
            {if $user_prefs.read_language}
                <div id="read-lang-div" class="form-group">
            {else}
                <a href="javascript:void(0)" onclick="document.getElementById('read-lang-div').style.display='block';this.style.display='none';">
                    {tr}Can you read more languages?{/tr}
                </a>
                <br/>
                <div id="read-lang-div" style="display: none" class="form-group">
            {/if}
            <label class="control-label" for="language">{tr}Other languages you can read (select from the dropdown to add to the field below){/tr}</label>
            <select class="form-control" id="language" name="_blank" onchange="document.getElementById('read-language-input').value+=' '+this.options[this.selectedIndex].value+' '">
                <option value="">{tr}Select language...{/tr}</option>
                {section name=ix loop=$languages}
                    <option value="{$languages[ix].value|escape}">
                        {$languages[ix].name}
                    </option>
                {/section}
            </select>

            <label for="read-language-input"><input class="form-control" id="read-language-input" type="text" name="read_language" value="{$user_prefs.read_language}"></label>
            </div>
        {/if}
        <div class="form-group">
            <label class="control-label" for="userbreadCrumb">{tr}Number of visited pages to remember{/tr}</label>
            <select id="userbreadCrumb" name="userbreadCrumb" class="form-control">
                <option value="1" {if $user_prefs.userbreadCrumb eq 1}selected="selected"{/if}>1</option>
                <option value="2" {if $user_prefs.userbreadCrumb eq 2}selected="selected"{/if}>2</option>
                <option value="3" {if $user_prefs.userbreadCrumb eq 3}selected="selected"{/if}>3</option>
                <option value="4" {if $user_prefs.userbreadCrumb eq 4}selected="selected"{/if}>4</option>
                <option value="5" {if $user_prefs.userbreadCrumb eq 5}selected="selected"{/if}>5</option>
                <option value="10" {if $user_prefs.userbreadCrumb eq 10}selected="selected"{/if}>10</option>
            </select>
        </div>
        <div class="form-group">
            <label class="control-label" for="display_timezone">Displayed timezone</label>
            <select name="display_timezone" class="form-control" id="display_timezone"{if $warning_site_timezone_set eq 'y'} disabled{/if}>
                <option value="" style="font-style:italic;">
                    {tr}Detect user time zone if browser allows, otherwise site default{/tr}
                </option>
                <option value="Site" style="font-style:italic;border-bottom:1px dashed #666;"
                        {if isset($user_prefs.display_timezone) and $user_prefs.display_timezone eq 'Site'} selected="selected"{/if}>
                    {tr}Site default{/tr}
                </option>
                {foreach key=tz item=tzinfo from=$timezones}
                    {math equation="floor(x / (3600000))" x=$tzinfo.offset assign=offset}
                    {math equation="(x - (y*3600000)) / 60000" y=$offset x=$tzinfo.offset assign=offset_min format="%02d"}
                    <option value="{$tz|escape}"{if isset($user_prefs.display_timezone) and $user_prefs.display_timezone eq $tz} selected="selected"{/if}>
                        {$tz|escape} (UTC{if $offset >= 0}+{/if}{$offset}h{if $offset_min gt 0}{$offset_min}{/if})
                    </option>
                {/foreach}
            </select>
            {if $warning_site_timezone_set eq 'y'}
                <br/><strong>{tr}Warning:{/tr}</strong> <i>{tr _0=$display_timezone}Site timezone <strong>%0</strong> is enforced and overrides user preferences{/tr}</i>
            {/if}
        </div>

        <div class="checkbox">
            <label>
                {tr}Use 12-hour clock in time selectors{/tr} <input type="checkbox" name="display_12hr_clock" {if $user_prefs.display_12hr_clock eq 'y'}checked="checked"{/if}>
            </label>
        </div>

        {if 1 eq 1 || $prefs.feature_community_mouseover eq 'y'}
        <div class="checkbox">
            <label>
                <input type="checkbox" name="show_mouseover_user_info" {if $show_mouseover_user_info eq 'y'}checked="checked"{/if}> {tr}Display info tooltip on mouseover for every user who allows his/her information to be public{/tr}
            </label>
        </div>
        {/if}

		{if $prefs.feature_wiki eq 'y'}
            <div class="checkbox">
                <label>
                    {tr}Use double-click to edit pages{/tr}<input type="checkbox" name="user_dbl" {if $user_prefs.user_dbl eq 'y'}checked="checked"{/if}>
                </label>
            </div>
		{/if}

		{if $prefs.feature_messages eq 'y' and $tiki_p_messages eq 'y'}

            <h4>{tr}User Messages{/tr}</h4>
            <div class="form-group">
                <label class="input-control" for="mess_maxRecords">{tr}Messages per page{/tr}</label>
                <select id="mess_maxRecords" name="mess_maxRecords" class="form-control">
                    <option value="2" {if $user_prefs.mess_maxRecords eq 2}selected="selected"{/if}>2</option>
                    <option value="5" {if $user_prefs.mess_maxRecords eq 5}selected="selected"{/if}>5</option>
                    <option value="10" {if empty($user_prefs.mess_maxRecords) or $user_prefs.mess_maxRecords eq 10}selected="selected"{/if}>10</option>
                    <option value="20" {if $user_prefs.mess_maxRecords eq 20}selected="selected"{/if}>20</option>
                    <option value="30" {if $user_prefs.mess_maxRecords eq 30}selected="selected"{/if}>30</option>
                    <option value="40" {if $user_prefs.mess_maxRecords eq 40}selected="selected"{/if}>40</option>
                    <option value="50" {if $user_prefs.mess_maxRecords eq 50}selected="selected"{/if}>50</option>
                </select>
			</div>
            {if 1 eq 1 || $prefs.allowmsg_is_optional eq 'y'}
                <div class="checkbox">
                    <label>
                        {tr}Allow messages from other users{/tr}<input type="checkbox" name="allowMsgs" {if $user_prefs.allowMsgs eq 'y'}checked="checked"{/if}>
                    </label>
                </div>
			{/if}
            <div class="checkbox">
                <label>
                    {tr}Notify sender when reading his mail{/tr}<input type="checkbox" name="mess_sendReadStatus" {if $user_prefs.mess_sendReadStatus eq 'y'}checked="checked"{/if}>
                </label>
            </div>
            <div class="form-group">
                <label class="input-control" for="minPrio">{tr}Send me an email for messages with priority equal or greater than:{/tr}</label>
                <select class="form-control" id="minPrio" name="minPrio">
                    <option value="1" {if $user_prefs.minPrio eq 1}selected="selected"{/if}>1 -{tr}Lowest{/tr}-</option>
                    <option value="2" {if $user_prefs.minPrio eq 2}selected="selected"{/if}>2 -{tr}Low{/tr}-</option>
                    <option value="3" {if $user_prefs.minPrio eq 3}selected="selected"{/if}>3 -{tr}Normal{/tr}-</option>
                    <option value="4" {if $user_prefs.minPrio eq 4}selected="selected"{/if}>4 -{tr}High{/tr}-</option>
                    <option value="5" {if $user_prefs.minPrio eq 5}selected="selected"{/if}>5 -{tr}Very High{/tr}-</option>
                    <option value="6" {if $user_prefs.minPrio eq 6}selected="selected"{/if}>{tr}none{/tr}</option>
                </select>
            </div>
            <div class="form-group">
                <label class="input-control" for="mess_archiveAfter" >{tr}Auto-archive read messages after x days{/tr}</label>
                <select id="mess_archiveAfter" name="mess_archiveAfter" class="form-control">
                    <option value="0" {if $user_prefs.mess_archiveAfter eq 0}selected="selected"{/if}>{tr}never{/tr}</option>
                    <option value="1" {if $user_prefs.mess_archiveAfter eq 1}selected="selected"{/if}>1</option>
                    <option value="2" {if $user_prefs.mess_archiveAfter eq 2}selected="selected"{/if}>2</option>
                    <option value="5" {if $user_prefs.mess_archiveAfter eq 5}selected="selected"{/if}>5</option>
                    <option value="10" {if $user_prefs.mess_archiveAfter eq 10}selected="selected"{/if}>10</option>
                    <option value="20" {if $user_prefs.mess_archiveAfter eq 20}selected="selected"{/if}>20</option>
                    <option value="30" {if $user_prefs.mess_archiveAfter eq 30}selected="selected"{/if}>30</option>
                    <option value="40" {if $user_prefs.mess_archiveAfter eq 40}selected="selected"{/if}>40</option>
                    <option value="50" {if $user_prefs.mess_archiveAfter eq 50}selected="selected"{/if}>50</option>
                    <option value="60" {if $user_prefs.mess_archiveAfter eq 60}selected="selected"{/if}>60</option>
                </select>
            </div>
		{/if}

		{if $prefs.feature_tasks eq 'y' and $tiki_p_tasks eq 'y'}

            <h4>{tr}User Tasks{/tr}</h4>
            <div class="form-group">
                <label class="input-control" for="tasks_maxRecords">{tr}Tasks per page{/tr}</label>
                <select class="form-control" id="tasks_maxRecords" name="tasks_maxRecords">
                    <option value="2" {if $user_prefs.tasks_maxRecords eq 2}selected="selected"{/if}>2</option>
                    <option value="5" {if $user_prefs.tasks_maxRecords eq 5}selected="selected"{/if}>5</option>
                    <option value="10" {if $user_prefs.tasks_maxRecords eq 10}selected="selected"{/if}>10</option>
                    <option value="20" {if $user_prefs.tasks_maxRecords eq 20}selected="selected"{/if}>20</option>
                    <option value="30" {if $user_prefs.tasks_maxRecords eq 30}selected="selected"{/if}>30</option>
                    <option value="40" {if $user_prefs.tasks_maxRecords eq 40}selected="selected"{/if}>40</option>
                    <option value="50" {if $user_prefs.tasks_maxRecords eq 50}selected="selected"{/if}>50</option>
                </select>
            </div>
		{/if}

        <h4>{tr}My Tiki{/tr}</h4>

		{if $prefs.feature_wiki eq 'y'}
            <div class="checkbox">
                <label>
                    {tr}My pages{/tr}<input type="checkbox" name="mytiki_pages" {if $user_prefs.mytiki_pages eq 'y'}checked="checked"{/if}>
                </label>
            </div>
		{/if}

		{if $prefs.feature_blogs eq 'y'}
            <div class="checkbox">
                <label>
                    {tr}My blogs{/tr}<input type="checkbox" name="mytiki_blogs" {if $user_prefs.mytiki_blogs eq 'y'}checked="checked"{/if}>
                </label>
            </div>
		{/if}

		{if $prefs.feature_galleries eq 'y'}
            <div class="checkbox">
                <label>
                    {tr}My galleries{/tr}<input type="checkbox" name="mytiki_gals" {if $user_prefs.mytiki_gals eq 'y'}checked="checked"{/if}>
                </label>
            </div>
		{/if}

		{if $prefs.feature_messages eq 'y'and $tiki_p_messages eq 'y'}
            <div class="checkbox">
                <label>
                    {tr}My messages{/tr}<input type="checkbox" name="mytiki_msgs" {if $user_prefs.mytiki_msgs eq 'y'}checked="checked"{/if}>
                </label>
            </div>
		{/if}

		{if $prefs.feature_tasks eq 'y' and $tiki_p_tasks eq 'y'}
            <div class="checkbox">
                <label>
                    {tr}My tasks{/tr}<input type="checkbox" name="mytiki_tasks" {if $user_prefs.mytiki_tasks eq 'y'}checked="checked"{/if}>
                </label>
            </div>
		{/if}

		{if $prefs.feature_forums eq 'y' and $tiki_p_forum_read eq 'y'}
            <div class="checkbox">
                <label>
                    {tr}My forum topics{/tr}<<input type="checkbox" name="mytiki_forum_topics" {if $user_prefs.mytiki_forum_topics eq 'y'}checked="checked"{/if}>
                </label>
            </div>
            <div class="checkbox">
                <label>
                    {tr}My forum replies{/tr}<input type="checkbox" name="mytiki_forum_replies" {if $user_prefs.mytiki_forum_replies eq 'y'}checked="checked"{/if}>
                </label>
            </div>
		{/if}

		{if $prefs.feature_trackers eq 'y'}
            <div class="checkbox">
                <label>
                    {tr}My user items{/tr}<input type="checkbox" name="mytiki_items" {if $user_prefs.mytiki_items eq 'y'}checked="checked"{/if}>
                </label>
            </div>
		{/if}

		{if $prefs.feature_articles eq 'y'}
            <div class="checkbox">
                <label>
                    {tr}My Articles{/tr}<input type="checkbox" name="mytiki_articles" {if $user_prefs.mytiki_articles eq 'y'}checked="checked"{/if}>
                </label>
            </div>
        {/if}

		{if $prefs.feature_userlevels eq 'y'}
            <div class="form-group">
                <label class="control-label" for="mylevel">{tr}My level{/tr}</label>
                <select class="form-control" name="mylevel" id="mylevel">
                    {foreach key=levn item=lev from=$prefs.userlevels}
                        <option value="{$levn}"{if $user_prefs.mylevel eq $levn} selected="selected"{/if}>{$lev}</option>
                    {/foreach}
                </select>
            </div>
		{/if}
<br>
<div class="form-group">
    {tr}Reset remark boxes visibility{/tr}&nbsp;&nbsp;
    {button _text='{tr}Reset{/tr}' _onclick="if (confirm('{tr}This will reset the visibility of all the tips, notices and warning remarks boxes you have closed.{/tr}')) {ldelim}deleteCookie('rbox');{rdelim}return false;"}
</div>

        <div><input type="submit" class="btn btn-primary" name="new_prefs" value="{tr}Save changes{/tr}"></div>

		</form>
	{/tab}
{/if}

{if $prefs.change_password neq 'n' or ! ($prefs.login_is_email eq 'y' and $userinfo.login neq 'admin')}
	{tab name="{tr}Account Information{/tr}"}
        <h2>{tr}Account Information{/tr}</h2>
		<form action="tiki-user_preferences.php" method="post" class="form-horizontal">
			<input type="hidden" name="view_user" value="{$userwatch|escape}">

				{if $prefs.auth_method neq 'cas' || ($prefs.cas_skip_admin eq 'y' && $user eq 'admin')}
					{if $prefs.change_password neq 'n' and ($prefs.login_is_email ne 'y' or $userinfo.login eq 'admin')}
						<div class="form-group">
							<div>{tr}Leave "New password" and "Confirm new password" fields blank to keep current password{/tr}</div>
                        </div>
					{/if}
				{/if}

				{if $prefs.login_is_email eq 'y' and $userinfo.login neq 'admin'}
					<input type="hidden" name="email" value="{$userinfo.email|escape}">
				{else}
                    <div class="form-group">
						<label class="col-md-4 control-label" for="email">{tr}Email address:{/tr}</label>
                        <div class="col-md-8">
    						<input type="text" class="form-control" name="email" id="email" value="{$userinfo.email|escape}">
                        </div>
					</div>
				{/if}

				{if $prefs.auth_method neq 'cas' || ($prefs.cas_skip_admin eq 'y' && $user eq 'admin')}
					{if $prefs.change_password neq 'n'}
                        <div class="form-group">
                            <label class="col-md-4 control-label" for="pass1">{tr}New password:{/tr}</label>
                            <div class="col-md-8">
    							<input class="form-control" type="password" name="pass1" id="pass1">
                            </div>
						</div>
                        <div class="form-group">
							<label class="col-md-4 control-label" for="pass2">{tr}Confirm new password:{/tr}</label>
                            <div class="col-md-8">
    							<input  class="form-control" type="password" name="pass2" id="pass2">
                            </div>
						</div>
					{/if}

					{if $tiki_p_admin ne 'y' or $userwatch eq $user}
                        <div class="form-group">
							<label class="col-md-4 control-label" for="pass">{tr}Current password (required):{/tr}</label>
                            <div class="col-md-8">
    							<input class="form-control" type="password" name="pass" id="pass">
                            </div>
						</div>
					{/if}
				{/if}

				<div class="text-center">
					<input type="submit" class="btn btn-primary btn-sm" name="chgadmin" value="{tr}Save changes{/tr}">
				</div>
		</form>
	{/tab}
{/if}

{if $tiki_p_delete_account eq 'y' and $userinfo.login neq 'admin'}
	{tab name="{tr}Account Deletion{/tr}"}
        <h2>{tr}Account Deletion{/tr}</h2>
		<form action="tiki-user_preferences.php" method="post"
			  onsubmit='return confirm("{tr _0=$userwatch|escape}Are you really sure you want to delete the account %0?{/tr}");'>
			{if !empty($userwatch)}<input type="hidden" name="view_user" value="{$userwatch|escape}">{/if}
			<div class="form-inline">
                <div class="form-group">
					<label for="deleteaccountconfirm">{tr}Check this box if you really want to delete the account{/tr}</label>
                    <input type='checkbox' name='deleteaccountconfirm' id="deleteaccountconfirm" value='1'>

                </div>
				<div class="form-group">
					<input type="submit" class="btn btn-danger btn-sm" name="deleteaccount" value="{if !empty($userwatch)}{tr}Delete the account:{/tr} {$userwatch|escape}{else}{tr}Delete my account{/tr}{/if}">
                </div>
            </div>
		</form>
	{/tab}
{/if}

{/tabset}
