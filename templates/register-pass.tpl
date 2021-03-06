{* $Id$ *}
{if $prefs.user_register_prettytracker eq 'y' and $prefs.user_register_prettytracker_tpl}
	<input id='pass1' type="password" name="pass" onkeypress="regCapsLock(event)">
	&nbsp;<strong class='mandatory_star'>*</strong>	
{else}
	{if $openid_associate neq 'y'}
		<div class="form-group">
			<label class="col-md-4 col-sm-3 control-label" for="pass1">{tr}Password:{/tr}</label>
			{if $trackerEditFormId}&nbsp;<strong class='mandatory_star'>*</strong>&nbsp;{/if}
			<div class="col-md-4 col-sm-6">
				<input class="form-control" id='pass1' type="password" name="pass" onkeypress="regCapsLock(event)" value="{if !empty($smarty.post.pass)}{$smarty.post.pass}{/if}"
						onkeyup="runPassword(this.value, 'mypassword');{if $prefs.feature_jquery_validation neq 'y' && !$userTrackerData}checkPasswordsMatch('#pass2', '#pass1', '#mypassword2_text');{/if}">
				<div style="margin-left:5px;">
					<div id="mypassword_text"></div>
					<div id="mypassword_bar" style="font-size: 5px; height: 2px; width: 0px;"></div> 
				</div>
				{if $prefs.feature_jquery_validation neq 'y'}
					{include file='password_help.tpl'}
				{/if}
			</div>
		</div>
	{/if}
{/if}
