
{* $Id$ *}
{*
 * If you want to change this page, check http://tiki.org/AdministrationDev
 * there you"ll find attached a gimp image containing this page with icons in separated layers
 *}

{remarksbox type="tip" title="{tr}Tip{/tr}"}
	{tr}Enable/disable Tiki features in {/tr}<a class="rbox-link" href="tiki-admin.php?page=features">{tr}Admin{/tr}&nbsp;{$prefs.site_crumb_seper}&nbsp;{tr}Features{/tr}</a>{tr}, but configure them elsewhere{/tr}
{/remarksbox}

<div class="clearfix cbox-data">
	{self_link page="general" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: 0px 0px;" _title="{tr}General{/tr}"}<span>{tr}General{/tr}</span>{/self_link}

	{self_link page="features" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -100px 0px;" _title="{tr}Features{/tr}"}<span>{tr}Features{/tr}</span>{/self_link}

	{self_link page="login" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -200px 0px;" _title="{tr}Log in{/tr}"}<span>{tr}Log in{/tr}</span>{/self_link}

	{self_link page="community" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -300px 0px;" _title="{tr}Community{/tr}"}<span>{tr}Community{/tr}</span>{/self_link}

	{self_link page="profiles" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -400px 0px;" _title="{tr}Profiles{/tr}"}<span>{tr}Profiles{/tr}</span>{/self_link}

	{self_link page="look" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -500px 0px;" _title="{tr}Look & Feel{/tr}"}<span>{tr}Look & Feel{/tr}</span>{/self_link}

	{self_link page="i18n" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: 0px -100px;" _title="{tr}i18n{/tr}"}<span>{tr}i18n{/tr}</span>{/self_link}

	{self_link page="textarea" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -100px -100px;" _title="{tr}Editing and Plugins{/tr}"}<span>{tr}Editing and Plugins{/tr}</span>{/self_link}

	{self_link page="module" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -200px -100px;" _title="{tr}Module{/tr}"}<span>{tr}Module{/tr}</span>{/self_link}

	{self_link page="metatags" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -300px -100px;" _title="{tr}Meta Tags{/tr}"}<span>{tr}Meta Tags{/tr}</span>{/self_link}

	{self_link page="performance" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -400px -100px;" _title="{tr}Performance{/tr}"}<span>{tr}Performance{/tr}</span>{/self_link}

	{self_link page="security" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -500px -100px;" _title="{tr}Security{/tr}"}<span>{tr}Security{/tr}</span>{/self_link}

	{self_link page="comments" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: 0px -200px;" _title="{tr}Comments{/tr}"}<span>{tr}Comments{/tr}</span>{/self_link}

	{self_link page="rss" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -100px -200px;" _title="{tr}Feeds{/tr}"}<span>{tr}Feeds{/tr}</span>{/self_link}
	{self_link page="connect" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -200px -200px;" _title="{tr}Connect{/tr}"}<span>{tr}Connect{/tr}</span>{/self_link}
	{self_link page="rating" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -300px -200px;" _title="{tr}Rating{/tr}"}<span>{tr}Rating{/tr}</span>{/self_link}
	
	{self_link page="wiki" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -400px -200px;"}<img src="pics/trans.png" alt="{tr}Wiki{/tr}" title="{tr}Wiki{/tr}{if $prefs.feature_wiki ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}Wiki{/tr}</span>{/self_link}

	{self_link page="fgal" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -500px -200px;"}<img src="pics/trans.png" alt="{tr}File Galleries{/tr}" title="{tr}File Galleries{/tr}{if $prefs.feature_file_galleries ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}File Galleries{/tr}</span>{/self_link}

	{self_link page="blogs" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: 0px -300px;"}<img src="pics/trans.png" alt="{tr}Blogs{/tr}" title="{tr}Blogs{/tr}{if $prefs.feature_blogs ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}Blogs{/tr}</span>{/self_link}
	
	{self_link page="gal" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -100px -300px;"}<img src="pics/trans.png" alt="{tr}Image Galleries{/tr}" title="{tr}Image Galleries{/tr}{if $prefs.feature_galleries ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}Image Galleries{/tr}</span>{/self_link}

	{self_link page="articles" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -200px -300px;"}<img src="pics/trans.png" alt="{tr}Articles{/tr}" title="{tr}Articles{/tr}{if $prefs.feature_articles ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}Articles{/tr}</span>{/self_link}

	{self_link page="forums" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -300px -300px;"}<img src="pics/trans.png" alt="{tr}Forums{/tr}" title="{tr}Forums{/tr}{if $prefs.feature_forums ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}Forums{/tr}</span>{/self_link}

	{self_link page="trackers" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -400px -300px;"}<img src="pics/trans.png" alt="{tr}Trackers{/tr}" title="{tr}Trackers{/tr}{if $prefs.feature_trackers ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}Trackers{/tr}</span>{/self_link}

	{self_link page="polls" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -500px -300px;"}<img src="pics/trans.png" alt="{tr}Polls{/tr}" title="{tr}Polls{/tr}{if $prefs.feature_polls ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}Polls{/tr}</span>{/self_link}
	
	{self_link page="calendar" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: 0px -400px;"}<img src="pics/trans.png" alt="{tr}Calendar{/tr}" title="{tr}Calendar{/tr}{if $prefs.feature_calendar ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}Calendar{/tr}</span>{/self_link}

	{self_link page="category" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -100px -400px;"}<img src="pics/trans.png" alt="{tr}Categories{/tr}" title="{tr}Categories{/tr}{if $prefs.feature_categories ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}Categories{/tr}</span>{/self_link}

	{self_link page="score" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -200px -400px;"}<img src="pics/trans.png" alt="{tr}Score{/tr}" title="{tr}Score{/tr}{if $prefs.feature_score ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}Score{/tr}</span>{/self_link}

	{self_link page="freetags" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -300px -400px;"}<img src="pics/trans.png" alt="{tr}Freetags{/tr}" title="{tr}Freetags{/tr}{if $prefs.feature_freetags ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}Freetags{/tr}</span>{/self_link}

	{self_link page="search" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -400px -400px;"}<img src="pics/trans.png" alt="{tr}Search{/tr}" title="{tr}Search{/tr}{if $prefs.feature_search ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}Search{/tr}</span>{/self_link}
	
	{self_link page="faqs" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -500px -400px;"}<img src="pics/trans.png" alt="{tr}FAQs{/tr}" title="{tr}FAQs{/tr}{if $prefs.feature_faqs ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}FAQs{/tr}</span>{/self_link}

	{self_link page="directory" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: 0px -500px;"}<img src="pics/trans.png" alt="{tr}Directory{/tr}" title="{tr}Directory{/tr}{if $prefs.feature_directory ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}Directory{/tr}</span>{/self_link}

	{self_link page="maps" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -100px -500px;"}<img src="pics/trans.png" alt="{tr}Maps{/tr}" title="{tr}Maps{/tr}{if $prefs.feature_maps ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}Maps{/tr}</span>{/self_link}
	
	{self_link page="gmap" _ajax="n" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -200px -500px;"}<img src="pics/trans.png" alt="{tr}Google Maps{/tr}" title="{tr}Google Maps{/tr}{if $prefs.feature_gmap ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}Google Maps{/tr}</span>{/self_link}
{* Google map does not load on ajax page load - white screens *}
	{self_link page="copyright" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -300px -500px;"}<img src="pics/trans.png" alt="{tr}Copyright{/tr}" title="{tr}Copyright{/tr}{if $prefs.feature_copyright ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}Copyright{/tr}</span>{/self_link}

	{self_link page="messages" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -400px -500px;"}<img src="pics/trans.png" alt="{tr}Messages{/tr}" title="{tr}Messages{/tr}{if $prefs.feature_messages ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}Messages{/tr}</span>{/self_link}
	
	{self_link page="userfiles" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -500px -500px;"}<img src="pics/trans.png" alt="{tr}User files{/tr}" title="{tr}User files{/tr}{if $prefs.feature_userfiles ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}User files{/tr}</span>{/self_link}
	
	{self_link page="webmail" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: 0px -600px;"}<img src="pics/trans.png" alt="{tr}Webmail{/tr}" title="{tr}Webmail{/tr}{if $prefs.feature_webmail ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}Webmail{/tr}</span>{/self_link}
	
	{self_link page="wysiwyg" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -100px -600px;"}<img src="pics/trans.png" alt="{tr}Wysiwyg{/tr}" title="{tr}Wysiwyg{/tr}{if $prefs.feature_wysiwyg ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}Wysiwyg{/tr}</span>{/self_link}
	
	{self_link page="ads" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -200px -600px;"}<img src="pics/trans.png" alt="{tr}Site Ads and Banners{/tr}" title="{tr}Site Ads and Banners{/tr}{if $prefs.feature_banners ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}Site Ads and Banners{/tr}</span>{/self_link}

	{self_link page="intertiki" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -300px -600px;"}<img src="pics/trans.png" alt="{tr}InterTiki{/tr}" title="{tr}InterTiki{/tr}{if $prefs.feature_intertiki ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}InterTiki{/tr}</span>{/self_link}

	{self_link page="semantic" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -400px -600px;"}<img src="pics/trans.png" alt="{tr}Semantic links{/tr}" title="{tr}Semantic links{/tr}{if $prefs.feature_semantic ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}Semantic links{/tr}</span>{/self_link}

	{self_link page="webservices" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -500px -600px;"}<img src="pics/trans.png" alt="{tr}Webservices{/tr}" title="{tr}Webservices{/tr}{if $prefs.feature_webservices ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}Webservices{/tr}</span>{/self_link}

	{self_link page="sefurl" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: 0px -700px;"}<img src="pics/trans.png" alt="{tr}Search engine friendly url{/tr}" title="{tr}Search engine friendly url{/tr}{if $prefs.feature_sefurl ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}Search engine friendly url{/tr}</span>{/self_link}

	{self_link page="video" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -100px -700px;"}<img src="pics/trans.png" alt="{tr}Video{/tr}" title="{tr}Video streaming integration{/tr}{if $prefs.feature_kaltura ne 'y' && $prefs.feature_watershed ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}Video{/tr}</span>{/self_link}

	{self_link page="payment" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -200px -700px;"}<img src="pics/trans.png" alt="{tr}Payment{/tr}" title="{tr}Payment{/tr}{if $prefs.payment_feature ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}Payment{/tr}</span>{/self_link}

	{self_link page="socialnetworks" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -300px -700px;"}<img src="pics/trans.png" alt="{tr}Social Networks{/tr}" title="{tr}Social networks{/tr}{if $prefs.feature_socialnetworks ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}Social networks{/tr}</span>{/self_link}

	{self_link page="share" _class="admbox" _style="background-image: url('pics/sprite/admin.fullpanel.png'); background-position: -400px -700px;"}<img src="pics/trans.png" alt="{tr}Share{/tr}" title="{tr}Share{/tr}{if $prefs.feature_share ne 'y'} ({tr}Disabled{/tr}){/if}" /><span>{tr}Share{/tr}</span>{/self_link}

</div>
