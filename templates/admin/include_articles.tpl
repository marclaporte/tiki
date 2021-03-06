{* $Id$ *}

{if !empty($msgs)}
	<div class="alert alert-warning">
	{foreach from=$msgs item=msg}
	{$msg}			 
	{/foreach}
	</div>
{/if}

<form method="post" action="tiki-admin.php?page=articles">
    <div class="row">
        <div class="form-group col-lg-12 clearfix">
			<a role="button" class="btn btn-default btn-sm" href="tiki-list_articles.php" title="{tr}List{/tr}">
				{glyph name="list"} {tr}Articles{/tr}
			</a>
			<a role="button" class="btn btn-default btn-sm" href="tiki-article_types.php" title="{tr}List{/tr}">
				{glyph name="wrench"} {tr}Article Types{/tr}
			</a>
			<a role="button" class="btn btn-default btn-sm" href="tiki-admin_topics.php" title="{tr}List{/tr}">
				{glyph name="wrench"} {tr}Article Topics{/tr}
			</a>
            <div class="pull-right">
                <input type="submit" class="btn btn-primary btn-sm" title="{tr}Apply Changes{/tr}" value="{tr}Apply{/tr}">
            </div>
        </div>
    </div>

	{tabset name="admin_articles"}
		{tab name="{tr}General Settings{/tr}"}
            <h2>{tr}General Settings{/tr}</h2>
			<input type="hidden" name="articlesprefs" />

			<fieldset class="table">
				<legend>{tr}Activate the feature{/tr}</legend>
				{preference name=feature_articles visible="always"}
			</fieldset>

			<fieldset class="table">
				<legend>{tr}Plugins{/tr}</legend>
				{preference name=wikiplugin_articles}
				{preference name=wikiplugin_article}
			</fieldset>
			
			{preference name=art_home_title}
			{preference name=maxArticles}

			<fieldset>
				<legend>
					{tr}Features{/tr}{help url="Articles"}
				</legend>

				{preference name=feature_submissions}
				{preference name=article_remembers_creator}
				{preference name=feature_cms_rankings}
				{preference name=article_user_rating}
				<div class="adminoptionboxchild" id="article_user_rating_childcontainer">
					{preference name=article_user_rating_options}
				</div>

				{preference name=feature_article_comments}
				<div class="adminoptionboxchild" id="feature_article_comments_childcontainer">
					{preference name=article_comments_per_page}
					{preference name=article_comments_default_ordering}
				</div>

				{preference name=feature_cms_templates}
				{preference name=feature_cms_print}
				{preference name=feature_cms_emails}

				{preference name=article_paginate}
				{preference name=article_custom_attributes}

				{preference name=geo_locate_article}
				{preference name=feature_sefurl_title_article}
				
				{preference name=article_related_articles}

				{preference name=tracker_article_tracker}
 				<div class="adminoptionboxchild" id="tracker_article_tracker_container">
 					{preference name=tracker_article_trackerId}
 				</div>

				<input type="hidden" name="articlesfeatures" />
			</fieldset>
			
			<fieldset>
				<legend>
					{tr}Article properties{/tr}
				</legend>
				<fieldset>
					<legend>{tr}Default maximum dimensions of custom images{/tr}</legend>
					<fieldset>
						<legend>{tr}General (view mode){/tr}</legend>
						{preference name=article_image_size_x}
						{preference name=article_image_size_y}
					</fieldset>
					<fieldset>
						<legend>{tr}List mode{/tr}</legend>
						{preference name=article_default_list_image_size_x}
						{preference name=article_default_list_image_size_y}
					</fieldset>
				</fieldset>
			</fieldset>

			<fieldset>
				<legend>
					{tr}Sharing on social networks{/tr}{help url="Social+Networks#Using+ShareThis"}
				</legend>
				{preference name=feature_cms_sharethis}
				<div class="adminoptionboxchild" id="feature_cms_sharethis_childcontainer">
					{preference name=article_sharethis_publisher}
				</div>
			</fieldset>

			<fieldset>
				<legend>{tr}Import CSV file{/tr}</legend>
				<div class="adminoptionbox">
					<div class="adminoptionlabel">
						<label for="csvlist">{tr}Batch upload (CSV file):{/tr}</label>
						<input type="file" name="csvlist" id="csvlist" /> 
						<br>
						<em>{tr}File format: title,authorName,heading,body,lang,user{/tr}....</em>
						<div align="center">
							<input type="submit" class="btn btn-default btn-sm" name="import" value="{tr}Import{/tr}" />
						</div>
					</div>
				</div>
			</fieldset>
		{/tab}

		{tab name="{tr}Articles Listing{/tr}"}
            <h2>{tr}Articles Listing{/tr}</h2>
			<fieldset>
				<legend>{tr}List Articles{/tr}</legend>
				<div class="adminoptionbox">
					{tr}Select which items to display when listing articles:{/tr} 	  
					<a class="rbox-link" href="tiki-list_articles.php">tiki-list_articles.php</a>
				</div>
				<input type="hidden" name="artlist" />

				{preference name=art_sort_mode}

				{preference name=art_list_title}
				<div class="adminoptionboxchild" id="art_list_title_childcontainer">
					{preference name=art_list_title_len}
				</div>
				{preference name=art_list_id}
				{preference name=art_list_type}
				{preference name=art_list_topic}
				{preference name=art_list_date}
				{preference name=art_list_expire}
				{preference name=art_list_visible}
				{preference name=art_list_lang}
				{preference name=art_list_author}
				{preference name=art_list_authorName}
				{preference name=art_list_rating}
				{preference name=art_list_usersRating}
				{preference name=art_list_reads}
				{preference name=art_list_size}
				{preference name=art_list_img}
				
				{preference name=gmap_article_list}
			</fieldset>
			<fieldset>
				<legend>{tr}Article View{/tr}</legend>
				{preference name=art_trailer_pos}
				{preference name=art_header_text_pos}
			</fieldset>
		{/tab}
	{/tabset}
    <br>{* I cheated. *}
    <div class="row">
        <div class="form-group col-lg-12 clearfix">
			<div class="text-center">
                <input type="submit" class="btn btn-primary btn-sm" title="{tr}Apply Changes{/tr}" value="{tr}Apply{/tr}">
            </div>
        </div>
    </div>
</form>

