{* $Id$ *}

{title help=Webmail admpage=webmail}{tr}Webmail{/tr}{/title}

{* include file='tiki-mytiki_bar.tpl' *}
<br /><br />

<table width="100%" border=0>
	<tr>
		<td>
			{self_link _icon='img/webmail/mailbox.gif' locSection='mailbox' _width='48' _height='48' _noauto='y'}{tr}Mailbox{/tr}{/self_link}
			<br />
			{self_link locSection='mailbox' _noauto='y'}{tr}Mailbox{/tr}{/self_link}
		</td>
		<td>
			{self_link _icon='img/webmail/compose.gif' locSection='compose' _width='48' _height='48' _noauto='y'}{tr}Compose{/tr}{/self_link}
			<br />
			{self_link locSection='compose' _noauto='y'}{tr}Compose{/tr}{/self_link}
		</td>
		<td>
			{self_link _icon='img/webmail/contact.gif' locSection='contacts' _width='48' _height='48' _noauto='y'}{tr}Contacts{/tr}{/self_link}
			<br />
			{self_link locSection='contacts' _noauto='y'}{tr}Contacts{/tr}{/self_link}
		</td>
		<td width="50%">
		</td>
		<td>
			{self_link _icon='img/webmail/settings.gif' locSection='settings' _width='48' _height='48' _noauto='y'}{tr}Settings{/tr}{/self_link}
			<br />
			{self_link locSection='settings' _noauto='y'}{tr}Settings{/tr}{/self_link}
		</td>
	</tr>
</table>

{if !empty($conmsg)}
	{remarksbox type='warning' title='{tr}Error{/tr}'}{$conmsg}{/remarksbox}
{/if}

<hr/>

{if $locSection eq 'settings'}
	{if $tiki_p_admin_personal_webmail eq 'y' or $tiki_p_admin_group_webmail eq 'y'}

		{if $tiki_p_admin_personal_webmail eq 'y' or $tiki_p_admin_group_webmail eq 'y'}
			<h2>{if $accountId eq 0}{tr}Add a new{/tr}{else}{tr}Edit this{/tr}{/if} {tr} mail account{/tr} {icon _id='add' id='addAccountIcon'}</h2>
			<div id="settingsFormDiv"{if $accountId eq 0 and count($accounts) != 0}style="display:none"{/if}>
				<form action="tiki-webmail.php" method="post" name="settings">
					<input type="hidden" name="accountId" value="{$accountId|escape}" />
					<input type="hidden" name="locSection" value="settings" />
					<table class="normal">
						<tr>
							<td class="formcolor">{tr}Account name{/tr}</td>
							<td class="formcolor">
								<input type="text" name="account" value="{$info.account|escape}" />
							</td>
							<td class="formcolor"></td>
							<td class="formcolor"></td>
						</tr>
						<tr><td class="formcolor" colspan="4">
							<hr />
							<h3>{tr}Incoming servers (used in this order){/tr}</h3>
						</td></tr>
						<tr>
							<td class="formcolor">{tr}IMAP server{/tr}</td>
							<td class="formcolor">
								<input type="text" name="imap" value="{$info.imap|escape}" />
							</td>
							<td rowspan="2" class="formcolor" valign="middle">{tr}Port{/tr}</td>
							<td rowspan="2" class="formcolor" valign="middle">
								<input type="text" name="port" size="7" value="{$info.port}" />
							</td>
						</tr>
						<tr>
							<td class="formcolor">{tr}Mbox filepath{/tr}</td>
							<td class="formcolor">
								<input type="text" name="mbox" value="{$info.mbox|escape}" />
							</td>
						</tr>
						<tr>
							<td class="formcolor">{tr}Maildir mail directory{/tr}</td>
							<td class="formcolor">
								<input type="text" name="maildir" value="{$info.maildir|escape}" />
							</td>
							<td rowspan="2" class="formcolor" valign="middle">{tr}Use SSL{/tr}</td>
							<td rowspan="2" class="formcolor" valign="middle">
								<input type="checkbox" name="useSSL" value="y" {if $info.useSSL eq 'y'}checked="checked"{/if} />
							</td>
						</tr>
						<tr>
							<td class="formcolor">{tr}POP server{/tr}</td>
							<td class="formcolor">
								<input type="text" name="pop" value="{$info.pop|escape}" />
							</td>
						</tr>
						<tr><td class="formcolor" colspan="4">
							<hr />
							<h3>{tr}Outgoing server{/tr}</h3>
						</td></tr>
						<tr>
							<td class="formcolor">{tr}SMTP server{/tr}</td>
							<td class="formcolor">
								<input type="text" name="smtp" value="{$info.smtp|escape}" />
							</td>
							<td class="formcolor">{tr}Port{/tr}</td>
							<td class="formcolor">
								<input type="text" name="smtpPort" size="7" value="{$info.smtpPort}" />
							</td>
						</tr>
						<tr>
							<td class="formcolor">{tr}SMTP requires authentication{/tr}</td>
							<td colspan="3" class="formcolor">
								{tr}Yes{/tr}<input type="radio" name="useAuth" value="y" {if $info.useAuth eq 'y'}checked="checked"{/if} />
								{tr}No{/tr}<input type="radio" name="useAuth" value="n" {if $info.useAuth eq 'n'}checked="checked"{/if} />
							</td>
						</tr>
						<tr><td class="formcolor" colspan="4">
							<hr />
							<h3>{tr}Account details{/tr}</h3>
						</td></tr>
						<tr>
							<td class="formcolor">{tr}Username{/tr}</td>
							<td colspan="3" class="formcolor">
								<input type="text" name="username" value="{$info.username|escape}" />
							</td>
						</tr>
						<tr>
							<td class="formcolor">{tr}Password{/tr}</td>
							<td colspan="3" class="formcolor">
								<input type="password" name="pass" value="{$info.pass|escape}" />
							</td>
						</tr>
						<tr>
							<td class="formcolor">{tr}Messages per page{/tr}</td>
							<td colspan="3" class="formcolor">
								<input type="text" name="msgs" size="4" value="{$info.msgs|escape}" />
							</td>
						</tr>
	
						{if ($tiki_p_admin_group_webmail eq 'y' and $tiki_p_admin_personal_webmail eq 'y') or $tiki_p_admin eq 'y'}
							<tr>
								<td class="formcolor">{tr}Group (shared mail inbox) or private{/tr}</td>
								<td colspan="3" class="formcolor">
									{tr}Group{/tr}<input type="radio" name="flagsPublic" value="y" {if $info.flagsPublic eq 'y'}checked="checked"{/if} /> {tr}Private{/tr}<input type="radio" name="flagsPublic" value="n" {if $info.flagsPublic eq 'n'}checked="checked"{/if} />
								</td>
							</tr>
						{else}
							<tr>
								<td></td>
								<td>
									<input type="hidden" name="flagsPublic" {if $tiki_p_admin_group_webmail eq 'y'}value="y"{else} value="n"{/if}>
									{if $tiki_p_admin_group_webmail eq 'y'}
										{tr}This will be a group mail account.{/tr}{else}{tr}This will be a personal mail account.{/tr}
									{/if}
								</td>
							</tr>
						{/if}
	
						<tr>
							<td class="formcolor">{tr}Auto-refresh page time{/tr}</td>
							<td colspan="3" class="formcolor">
								<input type="text" name="autoRefresh" size="4" value="{$info.autoRefresh|escape}" /> seconds (0 = no auto refresh)
							</td>
						</tr>
						<tr>
							<td class="formcolor">&nbsp;</td>
							<td colspan="3" class="formcolor">
								<input type="submit" name="new_acc" value="{if $accountId eq ''}{tr}Add{/tr}{else}{tr}Update{/tr}{/if}" />
								<input type="submit" name="cancel_acc" value="{tr}Clear{/tr}" />
							</td>
						</tr>
					</table>
				</form>
			</div>
		{/if}
	{else}
		{tr}You do not have the correct permissions to Add or Edit a webmail account. <BR />Please contact your administrator and ask for "admin_personal_webmail" or "admin_group_webmail" permission.{/tr}
	{/if}

	{if count($accounts) != 0}
		<h2>{tr}Personal e-mail accounts{/tr}</h2>
		<table class="normal">
			<tr>
				<th>{tr}Active{/tr}</th>
				<th>{tr}Account{/tr}</th>
				<th>{tr}Active{/tr}</th>
				<th>{tr}POP server{/tr}</th>
				<th>{tr}Username{/tr}</th>
				<th>{tr}Action{/tr}</th>
			</tr>
			{cycle values="odd,even" print=false}
			{section name=ix loop=$accounts}
				<tr>
					<td class="{cycle advance=false}">
						{if $accounts[ix].current ne 'y' and $accounts[ix].accountId ne $mailCurrentAccount}
							{self_link _icon='star_grey' locSection='settings' current=$accounts[ix].accountId _noauto='y'}{tr}Activate{/tr}{/self_link}
						{else}
							{icon _id='star' alt="{tr}This is the active account.{/tr}"}
						{/if}
					</td>
					<td class="{cycle advance=false}">
						{if $accounts[ix].current ne 'y' and $accounts[ix].accountId ne $mailCurrentAccount}
							{self_link locSection='settings' current=$accounts[ix].accountId _noauto='y'}{$accounts[ix].account class='link' _title='{tr}Activate{/tr}'}{/self_link}{* TODO make_title work? *}
						{else}
							<strong>{$accounts[ix].account}</strong>
						{/if}
					</td>
					<td class="{cycle advance=false}">
						{if $accounts[ix].current eq 'y'}{tr}Yes{/tr}{else}{tr}No{/tr}{/if}
					</td>
					<td class="{cycle advance=false}">
						{if !empty($accounts[ix].imap)}{tr}IMAP{/tr}: {$accounts[ix].imap} ({$accounts[ix].port})
						{elseif !empty($accounts[ix].mbox)}{tr}Mbox{/tr}: {$accounts[ix].mbox}
						{elseif !empty($accounts[ix].maildir)}{tr}Maildir{/tr}: {$accounts[ix].maildir}
						{elseif !empty($accounts[ix].pop)}{tr}POP3{/tr}: {$accounts[ix].pop} ({$accounts[ix].port}){/if}
					</td>
					<td class="{cycle advance=false}">
						{$accounts[ix].username}
					</td>
					<td class="{cycle}">
						{self_link _icon='cross' locSection=settings remove=$accounts[ix].accountId _noauto='y'}{tr}Delete{/tr}{/self_link}
						{self_link _icon='page_edit' locSection='settings' accountId=$accounts[ix].accountId _noauto='y'}{tr}Edit{/tr}{/self_link}
						{if $accounts[ix].current ne 'y' and $accounts[ix].accountId ne $mailCurrentAccount}
							{self_link _icon='accept' locSection='settings' current=$accounts[ix].accountId _noauto='y'}{tr}Activate{/tr}{/self_link}
						{/if}
					</td>
				</tr>
			{sectionelse}
				<tr>
					<td colspan="5" class="odd">{tr}No records found.{/tr}</td>
				</tr>
			{/section}
		</table>
	{/if}
	
	{if $tiki_p_use_group_webmail eq 'y'}
		{if count($pubAccounts) != 0}
			<h2>{tr}Group e-mail accounts{/tr}</h2>
			<table class="normal">
				<tr>
					<th>{tr}Active{/tr}</th>
					<th>{tr}Account{/tr}</th>
					<th>{tr}Active{/tr}</th>
					<th>{tr}POP server{/tr}</th>
					<th>{tr}Username{/tr}</th>
					<th>{tr}Action{/tr}</th>
				</tr>
				{cycle values="odd,even" print=false}
				{section name=ixp loop=$pubAccounts}
					<tr>
						<td class="{cycle advance=false}">
							{if $pubAccounts[ixp].current ne 'y' and $pubAccounts[ixp].accountId ne $mailCurrentAccount}
								{self_link _icon='star_grey' locSection='settings' current=$pubAccounts[ixp].accountId _noauto='y'}{tr}Activate{/tr}{/self_link}
							{else}
								{icon _id='star' alt="{tr}This is the active account.{/tr}"}
							{/if}
						</td>
						<td class="{cycle advance=false}">
							{if $pubAccounts[ixp].current ne 'y' and $pubAccounts[ixp].accountId ne $mailCurrentAccount}
								{self_link locSection='settings' current=$pubAccounts[ixp].accountId _noauto='y'}{$pubAccounts[ixp].account class='link' _title='{tr}Activate{/tr}'}{/self_link}{* TODO make self_link _title work when no icon? *}
							{else}
								<strong>{$pubAccounts[ixp].account}</strong>
							{/if}
						</td>
						<td class="{cycle advance=false}">{if $pubAccounts[ixp].current eq 'y'}{tr}Yes{/tr}{else}{tr}No{/tr}{/if}</td>
						<td class="{cycle advance=false}">
							{if !empty($pubAccounts[ixp].imap)}{tr}IMAP{/tr}: {$pubAccounts[ixp].imap} ({$pubAccounts[ixp].port})
							{elseif !empty($pubAccounts[ixp].mbox)}{tr}Mbox{/tr}: {$pubAccounts[ixp].mbox}
							{elseif !empty($pubAccounts[ixp].maildir)}{tr}Maildir{/tr}: {$pubAccounts[ixp].maildir}
							{elseif !empty($pubAccounts[ixp].pop)}{tr}POP3{/tr}: {$pubAccounts[ixp].pop} ({$pubAccounts[ixp].port}){/if}
						</td>
						<td class="{cycle advance=false}">{$pubAccounts[ixp].username}</td>
						<td class="{cycle}">
							{if $tiki_p_admin_group_webmail eq 'y'or $tiki_p_admin eq 'y'}
								{self_link _icon='cross' locSection=settings remove=$pubAccounts[ixp].accountId _noauto='y'}{tr}Delete{/tr}{/self_link}
								{self_link _icon='page_edit' locSection='settings' accountId=$pubAccounts[ixp].accountId _noauto='y'}{tr}Edit{/tr}{/self_link}
							{/if}
							{if $pubAccounts[ixp].current ne 'y' and $pubAccounts[ixp].accountId ne $mailCurrentAccount}
								{self_link _icon='accept' locSection='settings' current=$pubAccounts[ixp].accountId _noauto='y'}{tr}Activate{/tr}{/self_link}
							{/if}
						</td>
					</tr>
				{sectionelse}
					<tr>
						<td colspan="5" class="odd">{tr}No records found.{/tr}</td>
					</tr>
				{/section}
			</table>
		{/if}
	{/if}
{/if}


{if $locSection eq 'mailbox'}
	<table width="100%">
		<tr>
			<td>
				<a class="link" href="tiki-webmail.php?locSection=mailbox">{tr}Show All{/tr}</a> | <a class="link" href="tiki-webmail.php?locSection=mailbox&amp;filter=unread">{tr}Show Unread{/tr}</a> | <a class="link" href="tiki-webmail.php?locSection=mailbox&amp;filter=flagged">{tr}Show Flagged{/tr}</a> | {if $autoRefresh != 0}<a class="link" href="tiki-webmail.php?locSection=mailbox&refresh_mail=1">{tr}Refresh now{/tr}</a> Auto refresh set for every {$autoRefresh} seconds.{else}<a class="link" href="tiki-webmail.php?locSection=mailbox">{tr}Refresh{/tr}</a>{/if}
			</td>
			<td align="right" style="text-align:right">
				{if $flagsPublic eq 'y'}
					{tr}Group messages{/tr}
				{else}
					{tr}Messages{/tr}
				{/if}
				{$showstart} to {$showend} {tr}of{/tr} {$total}
				{if $first}
					| <a class="link" href="tiki-webmail.php?locSection=mailbox&amp;start={$first}{if $filter}&amp;filter={$filter}{/if}">{tr}First{/tr}</a>
				{/if}
				{if $prevstart}
					| <a class="link" href="tiki-webmail.php?locSection=mailbox&amp;start={$prevstart}{if $filter}&amp;filter={$filter}{/if}">{tr}Prev{/tr}</a>
				{/if}
				{if $nextstart}
					| <a class="link" href="tiki-webmail.php?locSection=mailbox&start={$nextstart}{if $filter}&amp;filter={$filter}{/if}">{tr}Next{/tr}</a>
				{/if}
				{if $last}
					| <a class="link" href="tiki-webmail.php?locSection=mailbox&amp;start={$last}{if $filter}&amp;filter={$filter}{/if}">{tr}Last{/tr}</a>
				{/if}
			</td>
		</tr>
	</table>
	<br />
	<form action="tiki-webmail.php" method="post" name="mailb">
		<input type="hidden" name="quickFlag" value="" />
		<input type="hidden" name="quickFlagMsg" value="" />
		<input type="hidden" name="locSection" value="mailbox" />
		<input type="submit" name="delete" value="{tr}Delete{/tr}" />
		<input type="hidden" name="start" value="{$start|escape}" />
		<select name="action">
			<option value="flag">{tr}Mark as flagged{/tr}</option>
			<option value="unflag">{tr}Mark as unflagged{/tr}</option>
			<option value="read">{tr}Mark as read{/tr}</option>
			<option value="unread">{tr}Mark as unread{/tr}</option>
		</select>
		<input type="submit" name="operate" value="{tr}Mark{/tr}" />
		<br />
		<br />
		<table class="normal webmail_list">
			<tr>
				<th>{select_all checkbox_names='msg[]'}</th>
				<th>&nbsp;</th>
				<th>{tr}Sender{/tr}</th>
				<th>{tr}Subject{/tr}</th>
				<th>{tr}Date{/tr}</th>
				<th>{tr}Size{/tr}</th>
			</tr>
			{section name=ix loop=$list}
				{if $list[ix].isRead eq 'y'}
					{assign var=class value="webmail_read"}
				{else}
					{assign var=class value=""}
				{/if}
				<tr>
					<td class="{$class}">
						<input type="checkbox" name="msg[]" value="{$list[ix].msgid}" />
						<input type="hidden" name="realmsg[{$list[ix].msgid}]" value="{$list[ix].realmsgid|escape}" />
					</td>
					<td class="{$class}">
						{if $list[ix].isFlagged eq 'y'}
							<a href="javascript: submit_form('{$list[ix].realmsgid|escape}','n')"><img src="img/webmail/flagged.gif" alt='{tr}Flagged{/tr}'></a>
						{else}
							{if $prefs.webmail_quick_flags eq 'y'}
								<a href="javascript: submit_form('{$list[ix].realmsgid|escape}','y')"><img src="img/webmail/unflagged.gif" alt='{tr}unFlagged{/tr}'></a>
							{/if}
						{/if}
						{if $list[ix].isReplied eq 'y'}
							<img src="img/webmail/replied.gif" alt='{tr}Replied{/tr}'/>
						{/if}
					</td>
					<td class="{$class}">{$list[ix].sender.name}</td>
					<td class="{$class}">
						<a class="link" href="tiki-webmail.php?locSection=read&amp;msgid={$list[ix].msgid}">{$list[ix].subject}</a>
						{if $list[ix].has_attachment}<img src="img/webmail/clip.gif" alt='{tr}Clip{/tr}'/>{/if}
					</td>
					<td class="{$class}">{$list[ix].timestamp|tiki_short_datetime}</td>
					<td align="right" class="{$class}">{$list[ix].size|kbsize}</td>
				</tr>
			{/section}
		</table>
	</form>
{/if}

{if $locSection eq 'read'}
	{if $prev}{self_link locSection='read' msgid=$prev _noauto='y'}{tr}Prev{/tr}{/self_link} |{/if}
	{if $next}{self_link locSection='read' msgid=$next _noauto='y'}{tr}Next{/tr}{/self_link} |{/if}
	{self_link locSection=mailbox _noauto='y'}{tr}Back To Mailbox{/tr}{/self_link} |
	{if $fullheaders eq 'n'}
		{self_link locSection='read' msgid=$msgid fullheaders='1' msgid=$next _noauto='y'}{tr}Full Headers{/tr}{/self_link}
	{else}
		{self_link locSection='read' msgid=$msgid msgid=$next _noauto='y'}{tr}Normal Headers{/tr}{/self_link}
	{/if}
	<table>
		<tr>
			<td>
				<form method="post" action="tiki-webmail.php">
					<input type="submit" name="delete_one" value="{tr}Delete{/tr}" />
					{if $next}
						<input type="hidden" name="locSection" value="read" />
						<input type="hidden" name="msgid" value="{$next|escape}" />
					{else}
						<input type="hidden" name="locSection" value="mailbox" />
					{/if}
					<input type="hidden" name="msgdel" value="{$msgid|escape}" />
				</form>
			</td>
			<td>
				<form method="post" action="tiki-webmail.php">
					<input type="hidden" name="locSection" value="compose" />
					<input type="submit" name="reply" value="{tr}Reply{/tr}" />
					<input type="hidden" name="realmsgid" value="{$realmsgid|escape}" />
					<input type="hidden" name="to" value="{$headers.replyto|escape}" />
					<input type="hidden" name="subject" value="Re:{$headers.subject}" />
					<input type="hidden" name="body" value="{$plainbody|escape}" />
				</form>
			</td>
			<td>
				<form method="post" action="tiki-webmail.php">
					<input type="hidden" name="locSection" value="compose" />
					<input type="submit" name="replyall" value="{tr}Reply To All{/tr}" />
					<input type="hidden" name="to" value="{$headers.replyto|escape}" />
					<input type="hidden" name="realmsgid" value="{$realmsgid|escape}" />
					<input type="hidden" name="cc" value="{$headers.replycc|escape}" />
					<input type="hidden" name="subject" value="Re:{$headers.subject}" />
					<input type="hidden" name="body" value="{$plainbody|escape}" />
				</form>
			</td>
			<td>
				<form method="post" action="tiki-webmail.php">
					<input type="submit" name="reply" value="{tr}Forward{/tr}" />
					<input type="hidden" name="locSection" value="compose" />
					<input type="hidden" name="to" value="" />
					<input type="hidden" name="cc" value="" />
					<input type="hidden" name="subject" value="Fw:{$headers.subject}" />
					<input type="hidden" name="body" value="{$plainbody|escape}" />
				</form>
			</td>
		</tr>
	</table>

	<table class="webmail_message_headers">
		{if $fullheaders eq 'n'}
			<tr>
				<th><strong>{tr}Subject{/tr}</strong></td>
				<td><strong>{$headers.subject|escape}</strong></td>
			</tr>
			<tr>
				<th>{tr}From{/tr}</td>
				<td>{$headers.from|escape}</td>
			</tr>
			<tr>
				<th>{tr}To{/tr}</td>
				<td>{$headers.to|escape}</td>
			</tr>
			{if $headers.cc}
				<tr>
					<td>{tr}Cc{/tr}</td>
					<td>{$headers.cc|escape}</td>
				</tr>
			{/if}
			<tr>
				<th>{tr}Date{/tr}</td>
				<td>{$headers.timestamp|tiki_short_datetime}</td>
			</tr>
		{/if}
		{if $fullheaders eq 'y'}
			{foreach key=key item=item from=$headers}
				<tr>
					<th>{$key}</td>
					<td>
						{if is_array($item)}
							{foreach from=$item item=part}
								{$part}
								<br />
							{/foreach}
						{else}
							{$item}
						{/if}
					</td>
				</tr>
			{/foreach}
		{/if}
	</table>

	{section name=ix loop=$bodies}
		{assign var='wmid' value='webmail_message_'|cat:$msgid|cat:'_'|cat:$smarty.section.ix.index}
		{assign var='wmopen' value='y'}
		{if $bodies[ix].contentType eq 'text/plain'}
			{if count($bodies) gt 1}
				{assign var='wmopen' value='n'}
			{/if}
			{assign var='wmclass' value='webmail_message webmail_mono'}
		{else}
			{if $bodies[ix].contentType neq 'text/html'}
				{assign var='wmopen' value='n'}
			{/if}
			{assign var='wmclass' value='webmail_message'}
		{/if}
		<div>
			{button _flip_id=$wmid _text='{tr}Part{/tr}: '|cat:$bodies[ix].contentType _auto_args='*' _flip_default_open=$wmopen}{/button}
		</div>
		<div id="{$wmid}" class="{$wmclass}" {if $wmopen eq 'n'}style="display:none"{/if}>
{$bodies[ix].body}
		</div>
	{/section}
	<div>
		{button _flip_id='webmail_message_source_'|cat:$msgid _text='{tr}Source{/tr}: ' _auto_args='*' _flip_default_open='y'}{/button}
	</div>
	<div id="webmail_message_source_{$msgid}" class="$wmclass" style="display:none">
{$allbodies|nl2br}
	</div>

	{section name=ix loop=$attachs}
		<div class="simplebox">
			<a class="link" href="tiki-webmail_download_attachment.php?locSection=read&amp;msgid={$msgid}&amp;getpart={$attachs[ix].part}">{$attachs[ix].name|iconify}{$attachs[ix].name}</a>
		</div>
	{/section}
{/if}

{if $locSection eq 'contacts'}
	<h2>{if $contactId eq 0}{tr}Add a new{/tr}{else}{tr}Edit this{/tr}{/if} {tr} contact{/tr} {icon _id='add' id='addContactIcon'}</h2>
	<div id="contactsFormDiv"{if $contactId eq 0 and count($channels) != 0}style="display:none"{/if}>
		<form action="tiki-webmail.php" method="post" name="contacts">
			<input type="hidden" name="locSection" value="contacts" />
			<input type="hidden" name="contactId" value="{$contactId|escape}" />
			<table class="normal">
				<tr class="formcolor">
					<td>{tr}First Name{/tr}:</td>
					<td>
						<input type="text" maxlength="80" size="20" name="firstName" value="{$info.firstName|escape}" />
					</td>
				</tr>
				<tr class="formcolor">
					<td>{tr}Last Name{/tr}:</td>
					<td>
						<input type="text" maxlength="80" size="20" name="lastName" value="{$info.lastName|escape}" />
					</td>
				</tr>
				<tr class="formcolor">
					<td>{tr}Email{/tr}:</td>
					<td>
						<input type="text" maxlength="80" size="20" name="email" value="{$info.email|escape}" />
					</td>
				</tr>
				<tr class="formcolor">
					<td>{tr}Nickname{/tr}:</td>
					<td>
						<input type="text" maxlength="80" size="20" name="nickname" value="{$info.nickname|escape}" />
					</td>
				</tr>
				<tr class="formcolor">
					<td>{tr}Groups{/tr}:</td>
					<td>
						{if !empty($listgroups)}
							{foreach item=gr from=$listgroups}
								<div class="registergroup">
									 <input type="checkbox"
									 		id="gr_{$gr|escape}"
									 		{if in_array($gr,$info.groups)}checked="checked"{/if}
									 		{if $user neq $info.user and $tiki_p_admin neq 'y' and $tiki_p_admin_group_webmail neq 'y'}
										 		name="dummy[]"
									 			value="dummy"
									 			disabled
									 		{else}
										 		name="groups[]"
									 			value="{$gr|escape}"
									 		{/if}
									 	/> 
									 <label for="gr_{$gr}">
									 	{$gr}
									</label>
								</div>
							{/foreach}
						{/if}
						{if !empty($other_groups)}
							{tr}Other groups: {/tr}
							{foreach item=ogr from=$other_groups}
								<em>{$ogr}</em>&nbsp;
								<input type="hidden" name="groups[]" value="{$ogr|escape}" />
							{/foreach}
						{/if}
						<input type="hidden" name="user" value="{$info.user|escape}" />
					</td>
				</tr>
				<tr class="formcolor">
					<td colspan="2">
						<input type="submit" name="save" value="{tr}Save{/tr}" />
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<h2>{tr}Contacts{/tr}</h2>
	{include file='find.tpl'}

		{initials_filter_links}

		<table class="normal">
			<tr>
				<th>
					<a href="tiki-webmail.php?locSection=contacts&amp;offset={$offset}&amp;sort_mode={if $sort_mode eq 'firstName_desc'}firstName_asc{else}firstName_desc{/if}">{tr}First Name{/tr}</a>
				</th>
				<th>
					<a href="tiki-webmail.php?locSection=contacts&amp;offset={$offset}&amp;sort_mode={if $sort_mode eq 'lastName_desc'}lastName_asc{else}lastName_desc{/if}">{tr}Last Name{/tr}</a>
				</th>
				<th>
					<a href="tiki-webmail.php?locSection=contacts&amp;offset={$offset}&amp;sort_mode={if $sort_mode eq 'email_desc'}email_asc{else}email_desc{/if}">{tr}Email{/tr}</a>
				</th>
				<th>
					<a href="tiki-webmail.php?locSection=contacts&amp;offset={$offset}&amp;sort_mode={if $sort_mode eq 'nickname_desc'}nickname_asc{else}nickname_desc{/if}">{tr}Nickname{/tr}</a>
				</th>
				<th>
					{tr}Groups{/tr}
				</th>
				<th>&nbsp;</th>
			</tr>
			{cycle values="odd,even" print=false}
			{section name=user loop=$channels}
				<tr>
					<td class="{cycle advance=false}">{$channels[user].firstName}</td>
					<td class="{cycle advance=false}">{$channels[user].lastName}</td>
					<td class="{cycle advance=false}">
						<a class="link" href="tiki-webmail.php?locSection=contacts&amp;offset={$offset}&amp;sort_mode={$sort_mode}&amp;find={$find}&amp;contactId={$channels[user].contactId}">{$channels[user].email|escape}</a>
					</td>
					<td class="{cycle advance=false}">{$channels[user].nickname}</td>
					<td class="{cycle advance=false}">{','|implode:$channels[user].groups}</td>
					<td class="{cycle}">
						{self_link _icon='page_edit' locSection='contacts' contactId=$channels[user].contactId}{* offset=$offset sort_mode=$sort_mode _noauto='y'*}{tr}Edit{/tr}{/self_link}
						{self_link _icon='cross' locSection='contacts' remove=$channels[user].contactId}{* offset=$offset sort_mode=$sort_mode find=$find _noauto='y'*}{tr}Delete{/tr}{/self_link}
					</td>
				</tr>
			{/section}
		</table>
		
		<div class="mini">
			{if $prev_offset >= 0}
				[<a class="prevnext" href="tiki-webmail.php?locSection=contacts&amp;find={$find}&amp;offset={$prev_offset}&amp;sort_mode={$sort_mode}">{tr}Prev{/tr}</a>]
				&nbsp;
			{/if}
			{tr}Page{/tr}: {$actual_page}/{$cant_pages}
			{if $next_offset >= 0}
				&nbsp;[<a class="prevnext" href="tiki-webmail.php?locSection=contacts&amp;find={$find}&amp;offset={$next_offset}&amp;sort_mode={$sort_mode}">{tr}Next{/tr}</a>]
			{/if}
			{if $prefs.direct_pagination eq 'y'}
				<br />
				{section loop=$cant_pages name=foo}
					{assign var=selector_offset value=$smarty.section.foo.index|times:$prefs.maxRecords}
					<a class="prevnext" href="tiki-webmail.php?locSection=contacts&amp;find={$find}&amp;offset={$selector_offset}&amp;sort_mode={$sort_mode}">{$smarty.section.foo.index_next}</a>
					&nbsp;
				{/section}
			{/if}
		</div>
{/if}

{if $locSection eq 'compose'}
	{if $attaching eq 'n'}
		{if $sent eq 'n'}
			<form action="tiki-webmail.php" method="post">
				<input type="hidden" name="locSection" value="compose" />
				<input type="hidden" name="attach1" value="{$attach1|escape}" />
				<input type="hidden" name="attach2" value="{$attach2|escape}" />
				<input type="hidden" name="attach3" value="{$attach3|escape}" />
				<input type="hidden" name="attach1file" value="{$attach1file|escape}" />
				<input type="hidden" name="attach2file" value="{$attach2file|escape}" />
				<input type="hidden" name="attach3file" value="{$attach3file|escape}" />
				<input type="hidden" name="attach1type" value="{$attach1type|escape}" />
				<input type="hidden" name="attach2type" value="{$attach2type|escape}" />
				<input type="hidden" name="attach3type" value="{$attach3type|escape}" />
				<input type="submit" name="send" value="{tr}Send{/tr}" />
				<table >
					<tr class="formcolor">
						<td>
							<a title="{tr}Select from address book{/tr}" class="link" href="#" onclick="javascript:window.open('tiki-webmail_contacts.php?element=to','','menubar=no,width=452,height=550');">{tr}To{/tr}</a>:
						</td>
						<td colspan="3">
							<input size="69" type="text" id="to" name="to" value="{$to|escape}" />
						</td>
					</tr>
					<tr class="formcolor">
						<td>
							<a title="{tr}Select from address book{/tr}" class="link" href="#" onclick="javascript:window.open('tiki-webmail_contacts.php?element=cc','','menubar=no,width=452,height=550');">{tr}CC{/tr}</a>:
						</td>
						<td>
							<input id="cc" type="text" name="cc" value="{$cc|escape}" /></td>
						<td>
							<a title="{tr}Select from address book{/tr}" class="link" href="#" onclick="javascript:window.open('tiki-webmail_contacts.php?element=bcc','','menubar=no,width=452,height=550');">{tr}BCC{/tr}</a>:
						</td>
						<td>
							<input type="text" name="bcc" value="{$bcc}" id="bcc" />
						</td>
					</tr>
					<tr class="formcolor">
						<td>{tr}Subject{/tr}</td>
						<td colspan="3">
							<input size="69" type="text" name="subject" value="{$subject|escape}" />
						</td>
					</tr>
					<tr class="formcolor">
						<td>{tr}Attachments{/tr}</td>
						<td colspan="3">
							{if $attach1}
								({$attach1})
							{/if}
							{if $attach2}
								({$attach2})
							{/if}
							{if $attach3}
								({$attach3})
							{/if}
							<input type="submit" name="attach" value="{tr}Add{/tr}" />
						</td>
					</tr>
					<tr>
					<tr class="formcolor">
						<td>&nbsp;</td>
						<td colspan="3">
							<textarea name="body" cols="60" rows="30">{$body}</textarea>
						</td>
					</tr>
					<tr class="formcolor">
						<td>{tr}Use HTML mail{/tr}</td>
						<td colspan="3">
							<input type="checkbox" name="useHTML" />
						</td>
					</tr>
				</table>
			</form>
		{else}
			{$msg}
			<br /><br />
			{if $notcon eq 'y'}
				{tr}The following addresses are not in your address book{/tr}
				<br /><br />
				<form action="tiki-webmail.php" method="post">
					<table class="normal">
						<tr>
							<th>&nbsp;</th>
							<th>{tr}Email{/tr}</th>
							<th>{tr}First Name{/tr}</th>
							<th>{tr}Last Name{/tr}</th>
							<th>{tr}Nickname{/tr}</th>
						</tr>
						{section name=ix loop=$not_contacts}
							<tr>
								<td>
									<input type="checkbox" name="add[{$smarty.section.ix.index}]" />
									<input type="hidden" name="addemail[{$smarty.section.ix.index}]" value="{$not_contacts[ix]|escape}" />
								</td>
								<td>{$not_contacts[ix]}</td>
								<td>
									<input type="text" name="addFirstName[{$smarty.section.ix.index}]" />
								</td>
								<td>
									<input type="text" name="addLastName[{$smarty.section.ix.index}]" />
								</td>
								<td>
									<input type="text" name="addNickname[{$smarty.section.ix.index}]" />
								</td>
							</tr>
						{/section}
						<tr>
							<td>&nbsp;</td>
							<td>
								<input type="submit" name="add_contacts" value="{tr}Add Contacts{/tr}" />
							</td>
						</tr>
					</table>
				</form>
			{/if}
		{/if}
	{else}
		<form enctype="multipart/form-data" action="tiki-webmail.php" method="post">
			<input type="hidden" name="locSection" value="compose" />
			<input type="hidden" name="to" value="{$to|escape}" />
			<input type="hidden" name="cc" value="{$cc|escape}" />
			<input type="hidden" name="bcc" value="{$bcc|escape}" />
			<input type="hidden" name="subject" value="{$subject|escape}" />
			<input type="hidden" name="body" value="{$body|escape}" />
			<input type="hidden" name="attach1" value="{$attach1|escape}" />
			<input type="hidden" name="attach2" value="{$attach2|escape}" />
			<input type="hidden" name="attach3" value="{$attach3|escape}" />
			<input type="hidden" name="attach1file" value="{$attach1file|escape}" />
			<input type="hidden" name="attach2file" value="{$attach2file|escape}" />
			<input type="hidden" name="attach3file" value="{$attach3file|escape}" />
			<input type="hidden" name="attach1type" value="{$attach1type|escape}" />
			<input type="hidden" name="attach2type" value="{$attach2type|escape}" />
			<input type="hidden" name="attach3type" value="{$attach3type|escape}" />
			<table class="normal">
				{if $attach1}
					<tr class="formcolor">
						<td>{tr}Attachment 1{/tr}</td>
						<td>{$attach1} <input type="submit" name="remove_attach1" value="{tr}Remove{/tr}" /></td>
					</tr>
				{else}
					<tr class="formcolor">
						<td>{tr}Attachment 1{/tr}</td>
						<td>
							<input type="hidden" name="MAX_FILE_SIZE" value="1500000" />
							<input name="userfile1" type="file" />
						</td>
					</tr>
				{/if}
				{if $attach2}
					<tr class="formcolor">
						<td>{tr}Attachment 2{/tr}</td>
						<td>
							{$attach2} <input type="submit" name="remove_attach2" value="{tr}Remove{/tr}" />
						</td>
					</tr>
				{else}
					<tr class="formcolor">
						<td>
							{tr}Attachment 2{/tr}
						</td>
						<td>
							<input type="hidden" name="MAX_FILE_SIZE" value="1500000" /><input name="userfile2" type="file" />
						</td>
					</tr>
				{/if}
				{if $attach3}
					<tr class="formcolor">
						<td>{tr}Attachment 3{/tr}</td>
						<td>
							{$attach3} <input type="submit" name="remove_attach3" value="{tr}Remove{/tr}" />
						</td>
					</tr>
				{else}
					<tr class="formcolor">
						<td>{tr}Attachment 3{/tr}</td>
						<td>
							<input type="hidden" name="MAX_FILE_SIZE" value="1500000" /><input name="userfile3" type="file" />
						</td>
					</tr>
				{/if}
				<tr class="formcolor">
					<td>&nbsp;</td>
					<td>
						<input type="submit" name="attached" value="{tr}Done{/tr}" />
					</td>
				</tr>
			</table>
		</form>
	{/if}
{/if}
