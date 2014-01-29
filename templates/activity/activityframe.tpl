<div class="activity" data-id="{$activityframe.object.id|escape}">
	<strong style="vertical-align: middle;">{$activityframe.activity.user|avatarize} {$activityframe.heading}</strong>
	{if in_array($user, $activityframe.activity.user_followers)}
	This user is your friend!
	{/if}
	{if $activityframe.sharedgroups and $user != $activityframe.activity.user}
	You share the following groups with this user:
	{foreach $activityframe.sharedgroups as $s_grp}
	{$s_grp|escape}{if !$s_grp@last}, {/if}
	{/foreach}
	{/if}
	<div class="content">{$activityframe.content}</div>
	<div class="footer">
		<span class="pull-right">
			{$activityframe.activity.modification_date|tiki_short_datetime}
		</span>
		{if $activity_format neq 'extended'}
			<a class="comment" href="{service controller=comment action=list type=$activityframe.object.type objectId=$activityframe.object.id modal=true}">
				{tr}Comment{/tr}
				{if $activityframe.activity.comment_count}({$activityframe.activity.comment_count|escape}){/if}
			</a>
		{/if}
		{if $activityframe.like}
			<a class="like" href="{service controller=social action=unlike type=$activityframe.object.type id=$activityframe.object.id}">
				{tr}Unlike{/tr}
				{if $activityframe.activity.like_list}({$activityframe.activity.like_list|count}){/if}
			</a>
		{else}
			<a class="like" href="{service controller=social action=like type=$activityframe.object.type id=$activityframe.object.id}">
				{tr}Like{/tr}
				{if $activityframe.activity.like_list}({$activityframe.activity.like_list|count}){/if}
			</a>
		{/if}
	</div>
	{if $activity_format eq 'extended'}
		<div class="comment-container" data-reload="{service controller=comment action=list type=$activityframe.object.type objectId=$activityframe.object.id}">
			{service_inline controller=comment action=list type=$activityframe.object.type objectId=$activityframe.object.id}
		</div>
	{/if}
</div>
