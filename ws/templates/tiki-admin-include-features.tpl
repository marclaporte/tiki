{* $Id$ *}

{remarksbox type="tip" title="{tr}Tip{/tr}"}{tr}Please see the <a class='rbox-link' target='tikihelp' href='http://doc.tikiwiki.org/Features'>evaluation of each feature</a> on Tiki's developer site.{/tr}{/remarksbox}

	<form class="admin" id="features" name="features" action="tiki-admin.php?page=features" method="post">
		<div class="heading input_submit_container" style="text-align: right">
			<input type="submit" name="features" value="{tr}Apply{/tr}" />
			<input type="reset" name="featuresreset" value="{tr}Reset{/tr}" />
		</div>

{tabset name="admin_features"}
{*
 * The following section is typically for features that act like Tikiwiki
 * sections and add a configuration icon to the sections list
 *}
{tab name="{tr}Main Features{/tr}"}
			<div class="admin clearfix">
{* ---------- Main features ------------ *}
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_wiki" {if $prefs.feature_wiki eq 'y'}checked="checked"{/if}/></span>
					<span class="label" > {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Wiki" target="tikihelp" class="tikihelp" title="{tr}Wiki{/tr}">{/if} {tr}Wiki{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_blogs" {if $prefs.feature_blogs eq 'y'}checked="checked"{/if}/></span>
					<span class="label" > {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Blogs" target="tikihelp" class="tikihelp" title="{tr}Wiki{/tr}">{/if} {tr}Blogs{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_galleries" {if $prefs.feature_galleries eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Image+Galleries" target="tikihelp" class="tikihelp" title="{tr}Image Galleries{/tr}">{/if} {tr}Image Galleries{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_file_galleries" {if $prefs.feature_file_galleries eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}File+Galleries" target="tikihelp" class="tikihelp" title="{tr}File Galleries{/tr}">{/if} {tr}File Galleries{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_articles" {if $prefs.feature_articles eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Articles" target="tikihelp" class="tikihelp" title="{tr}Articles{/tr}">{/if} {tr}Articles{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_forums" {if $prefs.feature_forums eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Forums" target="tikihelp" class="tikihelp" title="{tr}Forums{/tr}">{/if} {tr}Forums{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_trackers" {if $prefs.feature_trackers eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Trackers" target="tikihelp" class="tikihelp" title="{tr}Trackers{/tr}">{/if} {tr}Trackers{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_polls" {if $prefs.feature_polls eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Polls" target="tikihelp" class="tikihelp" title="{tr}Polls{/tr}">{/if} {tr}Polls{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_calendar" {if $prefs.feature_calendar eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Calendar" target="tikihelp" class="tikihelp" title="{tr}Calendar{/tr}">{/if} {tr}Calendar{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>		
									<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_newsletters" {if $prefs.feature_newsletters eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Newsletters" target="tikihelp" class="tikihelp" title="{tr}Newsletters{/tr}">{/if} {tr}Newsletters{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_banners" {if $prefs.feature_banners eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Banners" target="tikihelp" class="tikihelp" title="{tr}Banners{/tr}">{/if} {tr}Banners{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>	

			</div>
{/tab}
	
{* ---------- Global features ------------ *}
{tab name="{tr}Site Global Features{/tr}"}
			<div class="admin">
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_categories" {if $prefs.feature_categories eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Categories" target="tikihelp" class="tikihelp" title="{tr}Categories{/tr}">{/if} {tr}Categories{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_score" {if $prefs.feature_score eq 'y'}checked="checked"{/if} /></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Score" target="tikihelp" class="tikihelp" title="{tr}Score{/tr}: {tr}Score{/tr}">{/if} {tr}Score{/tr}{if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_freetags" {if $prefs.feature_freetags eq 'y'}checked="checked"{/if}/></span>
					<span class="label">{if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Tags" target="tikihelp" class="tikihelp" title="{tr}Freetags{/tr}: {tr}Freetags{/tr}">{/if}{tr}Freetags{/tr}{if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_search" {if $prefs.feature_search eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Search" target="tikihelp" class="tikihelp" title="{tr}Search{/tr}">{/if} {tr}Search{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_actionlog" {if $prefs.feature_actionlog eq 'y'}checked="checked"{/if}/></span>
					<span class="label">{if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Action+Log" target="tikihelp" class="tikihelp" title="{tr}Action Log{/tr}: {tr}Action Log{/tr}">{/if}{tr}Action log setting{/tr}{if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_contribution"{if $prefs.feature_contribution eq 'y'} checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Contribution" target="tikihelp" class="tikihelp" title="{tr}Contribution{/tr}">{/if} {tr}Contribution{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_multilingual"{if $prefs.feature_multilingual eq 'y'} checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Internationalization" target="tikihelp" class="tikihelp" title="{tr}Internationalization{/tr}">{/if} {tr}Multilingual{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
			</div>
{/tab}

{* ---------- Additional features ------------ *}
{tab name="{tr}Additional Features{/tr}"}
			<div class="admin">
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_faqs" {if $prefs.feature_faqs eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}FAQs" target="tikihelp" class="tikihelp" title="{tr}FAQs{/tr}">{/if} {tr}FAQs{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_surveys" {if $prefs.feature_surveys eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Surveys" target="tikihelp" class="tikihelp" title="{tr}Surveys{/tr}">{/if} {tr}Surveys{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_directory" {if $prefs.feature_directory eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Directory" target="tikihelp" class="tikihelp" title="{tr}Directory{/tr}">{/if} {tr}Directory{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_quizzes" {if $prefs.feature_quizzes eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Quizzes" target="tikihelp" class="tikihelp" title="{tr}Quizzes{/tr}">{/if} {tr}Quizzes{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_featuredLinks" {if $prefs.feature_featuredLinks eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Featured+Links" target="tikihelp" class="tikihelp" title="{tr}Featured Help{/tr}">{/if} {tr}Featured links{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">	 
					<span class="checkbox"><input type="checkbox" name="feature_copyright" {if $prefs.feature_copyright eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Copyright" target="tikihelp" class="tikihelp" title="{tr}Copyright System{/tr}">{/if} {tr}Copyright system{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_multimedia" {if $prefs.feature_multimedia eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> <a href="{$prefs.helpurl}Multimedia" target="tikihelp" class="tikihelp" title="{tr}Multimedia{/tr}"> {tr}Multimedia{/tr}</a></span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_shoutbox" {if $prefs.feature_shoutbox eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Shoutbox" target="tikihelp" class="tikihelp" title="{tr}Shoutbox{/tr}">{/if} {tr}Shoutbox{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_maps" {if $prefs.feature_maps eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Maps" target="tikihelp" class="tikihelp" title="{tr}Maps{/tr}">{/if} {tr}Maps{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_gmap" {if $prefs.feature_gmap eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Gmap" target="tikihelp" class="tikihelp" title="{tr}Google Maps{/tr}: {tr}Google Maps{/tr}">{/if} {tr}Google Maps{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_live_support" {if $prefs.feature_live_support eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Live+Support" target="tikihelp" class="tikihelp" title="{tr}Live Support{/tr}">{/if} {tr}Live support system{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_tell_a_friend" {if $prefs.feature_tell_a_friend eq 'y'}checked="checked"{/if}/></span>
					<span class="label">{if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Tell+a+Friend" target="tikihelp" class="tikihelp" title="{tr}Tell a Friend{/tr}">{/if} {tr}Tell a Friend{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_html_pages" {if $prefs.feature_html_pages eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Html+Pages" target="tikihelp" class="tikihelp" title="{tr}HTML Pages{/tr}">{/if} {tr}HTML pages{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_contact"						{if $prefs.feature_contact eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Contact+Us" target="tikihelp" class="tikihelp" title="{tr}Contact Us{/tr}">{/if} {tr}Contact Us{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_minichat" {if $prefs.feature_minichat eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Minichat" target="tikihelp" class="tikihelp" title="{tr}HTML Pages{/tr}">{/if} {tr}Minichat{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_comments_moderation" {if $prefs.feature_comments_moderation eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Comments" target="tikihelp" class="tikihelp" title="{tr}Comments Moderation{/tr}">{/if} {tr}Comments Moderation{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_comments_locking" {if $prefs.feature_comments_locking eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Comments" target="tikihelp" class="tikihelp" title="{tr}Comments Locking{/tr}">{/if} {tr}Comments Locking{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
			</div>
{/tab}

{* ---------- User interface enhancement features ------------ *}
{tab name="{tr}User interface enhancement features{/tr}"}
			<div class="admin">
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_jscalendar" {if $prefs.feature_jscalendar eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Js+Calendar" target="tikihelp" class="tikihelp" title="{tr}JsCalendar{/tr}">{/if} {tr}JavaScript popup date selector{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_phplayers" {if $prefs.feature_phplayers eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="http://themes.tikiwiki.org/PhpLayersMenu" target="tikihelp" class="tikihelp" title="{tr}PHPLayers{/tr}">{/if} {tr}PhpLayers Dynamic menus{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div> 
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_fullscreen" {if $prefs.feature_fullscreen eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Fullscreen" target="tikihelp" class="tikihelp" title="{tr}Fullscreen{/tr}">{/if} {tr}Allow users to activate fullscreen mode{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_cssmenus" {if $prefs.feature_cssmenus eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> <a href="{$prefs.helpurl}Menus" target="tikihelp" class="tikihelp" title="{tr}Menus{/tr}"> {tr}Css Menus (suckerfish){/tr}</a></span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_shadowbox"{if $prefs.feature_shadowbox eq 'y'} checked="checked"{/if}/></span>
					<span class="label"><a href="{$prefs.helpurl}Shadowbox" target="tikihelp" class="tikihelp" title="{tr}Shadowbox{/tr}"> {tr}Shadowbox{/tr}</a></span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_quick_object_perms" {if $prefs.feature_quick_object_perms eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> <a href="{$prefs.helpurl}Quickperms" target="tikihelp" class="tikihelp" title="{tr}Quickperms{/tr}"> {tr}Quickperms{/tr}</a></span>
				</div>
			</div>
{/tab}
			
{* ---------- Experimental features ------------ *}
{tab name="{tr}Experimental Features{/tr}"}
			<div class="admin">
				<fieldset>
					<legend class="heading">{icon _id="accept"}<span>{tr}Seem ok{/tr}</span></legend>
					<span class="description">{tr}Features that may change or might be re-worked in the future{/tr}</span>
					<div class="half_width">
						<span class="checkbox"><input type="checkbox" name="feature_ajax" {if $prefs.feature_ajax eq 'y'}checked="checked"{/if}/></span>
						<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Ajax" target="tikihelp" class="tikihelp" title="{tr}Ajax{/tr}: {tr}Ajax{/tr}">{/if} {tr}Ajax{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
					</div>
					<div class="half_width">
						<span class="checkbox"><input type="checkbox" name="feature_purifier" {if $prefs.feature_purifier eq 'y'}checked="checked"{/if}/></span>
						<span class="label"> <a href="{$prefs.helpurl}Purifier" target="tikihelp" class="tikihelp" title="{tr}HTML Purifier{/tr}"> {tr}HTML Purifier (Content is cleaned to XHTML 1.1 Strict on each save){/tr}</a> </span>
					</div>					
					<div class="half_width">
						<span class="checkbox"><input type="checkbox" name="feature_mobile" {if $prefs.feature_mobile eq 'y'}checked="checked"{/if}/></span>
						<span class="label"> {if $prefs.feature_help eq 'y'}<a href="http://mobile.tikiwiki.org/" target="tikihelp" class="tikihelp" title="{tr}Mobile{/tr}: {tr}Mobile{/tr}">{/if} {tr}Mobile{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
					</div>
					<div class="half_width">
						<span class="checkbox"><input type="checkbox" name="feature_morcego" {if $prefs.feature_morcego eq 'y'}checked="checked"{/if}/></span>
						<span class="label">{if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Wiki+3D" target="tikihelp" class="tikihelp" title="{tr}Morcego 3D browser{/tr}: {tr}Morcego 3D browser{/tr}">{/if}{tr}Morcego 3D browser{/tr}{if $prefs.feature_help eq 'y'}</a>{/if}</span>
					 </div>
					<div class="half_width">
						<span class="checkbox"><input type="checkbox" name="feature_webmail" {if $prefs.feature_webmail eq 'y'}checked="checked"{/if}/></span>
						<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Webmail" target="tikihelp" class="tikihelp" title="{tr}Webmail{/tr}">{/if} {tr}Webmail{/tr} {if $prefs.feature_help eq 'y'}</a>{/if} </span>
					</div>
				</fieldset>
				<fieldset>
					<legend class="heading">{icon _id="error"}<span>{tr}Need polish{/tr}</span></legend>
					<span class="description">{tr}Features that need admin help and user patience to work well{/tr}</span>
					<div class="half_width">
						<span class="checkbox"><input type="checkbox" name="feature_intertiki" {if $prefs.feature_intertiki eq 'y'}checked="checked"{/if}/></span>
						<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}InterTiki" target="tikihelp" class="tikihelp" title="{tr}Intertiki{/tr}: {tr}Intertiki{/tr}">{/if} {tr}Intertiki{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
					</div>
					<div class="half_width">
						<span class="checkbox"><input type="checkbox" name="feature_mailin" {if $prefs.feature_mailin eq 'y'}checked="checked"{/if}/></span>
						<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Mail-in" target="tikihelp" class="tikihelp" title="{tr}Mail-in{/tr}">{/if} {tr}Mail-in{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
					</div>
					<div class="half_width">
						<span class="checkbox"><input type="checkbox" name="feature_wiki_mindmap" {if $prefs.feature_wiki_mindmap eq 'y'}checked="checked"{/if}/></span>
						<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}MindMap" target="tikihelp" class="tikihelp" title="{tr}Mindmap{/tr}">{/if} {tr}Mindmap{/tr} {if $prefs.feature_help eq 'y'}</a>{/if} </span>
					</div>
					<div class="half_width">
						<span class="checkbox"><input type="checkbox" name="feature_print_indexed" {if $prefs.feature_print_indexed eq 'y'}checked="checked"{/if}/></span>
						<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Print+Indexed" target="tikihelp" class="tikihelp" title="{tr}Print Indexed{/tr}: {tr}Print Indexed{/tr}">{/if} {tr}Print Indexed{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
					</div>
					<div class="half_width">
						 <span class="checkbox"><input type="checkbox" name="feature_sefurl" {if $prefs.feature_sefurl eq 'y'}checked="checked"{/if}/></span>
						 <span class="label">{if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Rewrite+Rules" target="tikihelp" class="tikihelp" title="{tr}SEFURL{/tr}">{/if} {tr}Search engine friendly url{/tr}{if $prefs.feature_help eq 'y'}</a>{/if}</span>
					</div>
					<div class="half_width">
						<span class="checkbox"><input type="checkbox" name="feature_sheet" {if $prefs.feature_sheet eq 'y'}checked="checked"{/if}/></span>
						<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Spreadsheet" target="tikihelp" class="tikihelp" title="{tr}Spreadsheet{/tr}: {tr}TikiSheet{/tr}">{/if} {tr}Tiki Sheet{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
					</div>
					<div class="half_width">
						<span class="checkbox"><input type="checkbox" name="feature_wysiwyg" {if $prefs.feature_wysiwyg eq 'y'}checked="checked"{/if}/></span>
						<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Wysiwyg+Editor" target="tikihelp" class="tikihelp" title="{tr}Wysiwyg editor{/tr}: {tr}Wysiwyg editor{/tr}">{/if} {tr}Wysiwyg editor{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
					</div>
					<div class="half_width">
						<span class="checkbox"><input type="checkbox" name="feature_ajax_autosave" {if $prefs.feature_ajax_autosave eq 'y'}checked="checked"{/if}/></span>
						<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Lost+Edit+Protection" target="tikihelp" class="tikihelp" title="{tr}Ajax{/tr}: {tr}Ajax auto-save{/tr}">{/if} {tr}Ajax auto-save{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}{if $prefs.feature_ajax neq 'y'} ({tr}required{/tr}: {tr}Ajax{/tr}){/if}</span>
					</div>
				</fieldset>
				<fieldset>
					<legend class="heading">{icon _id="exclamation"}<span>{tr}Malfunctioning{/tr}</span></legend>
					<span class="description">{tr}These features have critical faults - not recommended{/tr}</span>
					<div class="half_width">
						<span class="checkbox"><input type="checkbox" name="feature_magic" {if $prefs.feature_magic eq 'y'}checked="checked"{/if}/></span>
						<span class="label"><a>{tr}Magic Admin Panel{/tr}</a></span>
					</div>
				</fieldset>
				<fieldset>
					<legend class="heading">{icon _id="information_gray"}<span>{tr}Neglected{/tr}</span></legend>
					<span class="description">{tr}Old features no longer maintained{/tr}</span>
					<div class="half_width">
						<span class="checkbox"><input type="checkbox" name="feature_friends" {if $prefs.feature_friends eq 'y'}checked="checked"{/if}/></span>
						<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Friendship" target="tikihelp" class="tikihelp" title="{tr}Friendship{/tr}: {tr}Friendship Network{/tr}">{/if} {tr}Friendship Network{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
					</div>
				</fieldset>
			</div>
{/tab}

{* ---------- Administration features ------------ *}
{tab name="{tr}Administration Features{/tr}"}
			<div class="admin">
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_banning" {if $prefs.feature_banning eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Banning" target="tikihelp" class="tikihelp" title="{tr}Banning System{/tr}">{/if} {tr}Banning system{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_stats" {if $prefs.feature_stats eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Stats" target="tikihelp" class="tikihelp" title="{tr}Stats{/tr}">{/if} {tr}Stats{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_action_calendar" {if $prefs.feature_action_calendar eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Action+Calendar" target="tikihelp" class="tikihelp" title="{tr}Action Calendar{/tr}: {tr}Action Calendar{/tr}">{/if} {tr}Tiki action calendar{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_referer_stats"					{if $prefs.feature_referer_stats eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Stats" target="tikihelp" class="tikihelp" title="{tr}Referer Stats{/tr}">{/if} {tr}Referer Stats{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_redirect_on_error"			{if $prefs.feature_redirect_on_error eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {tr}Redirect On Error{/tr} </span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_comm" {if $prefs.feature_comm eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Communication+Center" target="tikihelp" class="tikihelp" title="{tr}Communications (send/receive objects){/tr}">{/if} {tr}Communications (send/receive objects){/tr} {if $prefs.feature_help eq 'y'}</a>{/if} </span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_custom_home" {if $prefs.feature_custom_home eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Custom+Home" target="tikihelp" class="tikihelp" title="{tr}Custom Home{/tr}">{/if} {tr}Custom Home{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
			</div>
{/tab}
			
{* --- User Features --- *}
{tab name="{tr}User Features{/tr}"}
			<div class="admin">
				<div style="width: 49%; text-align: left; float: left">
					<span class="checkbox"><input type="checkbox" name="feature_mytiki" {if $prefs.feature_mytiki eq 'y'}checked="checked"{/if} /></span>
					<span class="label"> {tr}Display 'MyTiki' in the application menu{/tr} </span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_minical" {if $prefs.feature_minical eq 'y'}checked="checked"{/if} /></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Calendar" target="tikihelp" class="tikihelp" title="{tr}Mini Calendar{/tr}">{/if} {tr}Mini Calendar{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				
				<div style="width: 49%; text-align: left; float: left">
					<span class="checkbox"><input type="checkbox" name="feature_userPreferences" {if $prefs.feature_userPreferences eq 'y'}checked="checked"{/if} /></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}User+Preferences" target="tikihelp" class="tikihelp" title="{tr}User Preferences Screen{/tr}">{/if} {tr}User Preferences Screen{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_notepad" {if $prefs.feature_notepad eq 'y'}checked="checked"{/if} /></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Notepad" target="tikihelp" class="tikihelp" title="{tr}User Notepad{/tr}">{/if} {tr}User Notepad{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				
				<div style="width: 49%; text-align: left; float: left">
					<span class="checkbox"><input type="checkbox" name="feature_user_bookmarks"	{if $prefs.feature_user_bookmarks eq 'y'}checked="checked"{/if} /></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Bookmarks" target="tikihelp" class="tikihelp" title="{tr}User Bookmarks{/tr}">{/if} {tr}User Bookmarks{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_contacts" {if $prefs.feature_contacts eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Contacts" target="tikihelp" class="tikihelp" title="{tr}User Contacts{/tr}">{/if} {tr}User Contacts{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				
				<div style="width: 49%; text-align: left; float: left">
					<span class="checkbox"><input type="checkbox" name="feature_user_watches" {if $prefs.feature_user_watches eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}User+Watches" target="tikihelp" class="tikihelp" title="{tr}User Watches{/tr}">{/if} {tr}User Watches{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_group_watches" {if $prefs.feature_group_watches eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Group+Watches" target="tikihelp" class="tikihelp" title="{tr}Group Watches{/tr}">{/if} {tr}Group Watches{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_daily_report_watches" {if $prefs.feature_daily_report_watches eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Daily+Reports" target="tikihelp" class="tikihelp" title="{tr}Daily Repors for User Watches{/tr}">{/if} {tr}Daily Reports{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_user_watches_translations"	{if $prefs.feature_user_watches_translations eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}User+Watches" target="tikihelp" class="tikihelp" title="{tr}User Watches Translations{/tr}">{/if} {tr}User Watches Translations{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				
				<div style="width: 49%; text-align: left; float: left">
					<span class="checkbox"><input type="checkbox" name="feature_usermenu" {if $prefs.feature_usermenu eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}User+Menu" target="tikihelp" class="tikihelp" title="{tr}User Menu{/tr}">{/if} {tr}User Menu{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_tasks" {if $prefs.feature_tasks eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Task" target="tikihelp" class="tikihelp" title="{tr}User Tasks{/tr}">{/if} {tr}User Tasks{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				
				<div style="width: 49%; text-align: left; float: left">
					<span class="checkbox"><input type="checkbox" name="feature_messages" {if $prefs.feature_messages eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Inter-User+Messages" target="tikihelp" class="tikihelp" title="{tr}User Messages{/tr}">{/if} {tr}User Messages{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_userfiles" {if $prefs.feature_userfiles eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}User+Files" target="tikihelp" class="tikihelp" title="{tr}User Files{/tr}">{/if} {tr}User Files{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_userlevels" {if $prefs.feature_userlevels eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}User+Levels" target="tikihelp" class="tikihelp" title="{tr}User Levels{/tr}">{/if} {tr}User Levels{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div style="width: 49%; text-align: left; float: left">
					<span class="checkbox"><input type="checkbox" name="feature_groupalert" {if $prefs.feature_groupalert eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Group+Alert" target="tikihelp" class="tikihelp" title="{tr}Group Alert{/tr}">{/if} {tr}Group Alert{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
			</div>
{/tab}

{tab name="{tr}Programmer Features{/tr}"}
			<div class="admin">
				<div style="width: 49%; text-align: left; float: left">
					<span class="checkbox"><input type="checkbox" name="feature_integrator" {if $prefs.feature_integrator eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Tiki+Integrator" target="tikihelp" class="tikihelp" title="{tr}Integrator{/tr}">{/if} {tr}Integrator{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_xmlrpc"	{if $prefs.feature_xmlrpc eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Xmlrpc" target="tikihelp" class="tikihelp" title="{tr}XMLRPC API{/tr}">{/if} {tr}XMLRPC API{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div style="width: 49%; text-align: left; float: left">
					<span class="checkbox"><input type="checkbox" name="feature_debug_console" {if $prefs.feature_debug_console eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Debugger+Console" target="tikihelp" class="tikihelp" title="{tr}Debugger Console{/tr}">{/if} {tr}Debugger Console{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div class="half_width">
					<span class="checkbox"><input type="checkbox" name="feature_tikitests"{if $php_major_version lt 5} disabled="disabled"{/if}{if $prefs.feature_tikitests eq 'y'} checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}TikiTests" target="tikihelp" class="tikihelp" title="{tr}TikiTests{/tr}">{/if} {tr}TikiTests{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}{if $php_major_version lt 5} ({tr}requires PHP5 or more{/tr}) {/if}</span>
				</div>
				<div style="width: 49%; text-align: left; float: left">
					<span class="checkbox"><input type="checkbox" name="feature_workflow" {if $prefs.feature_workflow eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Workflow" target="tikihelp" class="tikihelp" title="{tr}Workflow{/tr}">{/if} {tr}Workflow engine{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div style="width: 49%; text-align: left; float: left">
					<span class="checkbox"><input type="checkbox" name="use_minified_scripts" {if $prefs.use_minified_scripts eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}MinifiedScripts" target="tikihelp" class="tikihelp" title="{tr}Use Minified Scripts{/tr}">{/if} {tr}Use Minified Scripts{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
				<div style="width: 49%; text-align: left; float: left">
					<span class="checkbox"><input type="checkbox" name="debug_ignore_xdebug" {if $prefs.debug_ignore_xdebug eq 'y'}checked="checked"{/if}/></span>
					<span class="label"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}DebugIgnoreXDebug" target="tikihelp" class="tikihelp" title="{tr}Ignore XDebug: Don't use XDebug debugging info if installed. Try this if you use xdebug and are geting blank pages.{/tr}">{/if} {tr}Ignore XDebug{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</span>
				</div>
			</div>
{/tab}
{/tabset}

	<div class="input_submit_container" style="margin-top: 5px; text-align: center">
		<input type="submit" name="features" value="{tr}Apply{/tr}" />
	</div>
</form>
