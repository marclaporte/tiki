<!--<form onsubmit="javascript:top.document.frames[0].document.write('<span style=\'color:blue;\'>{$nickname}'+':'+getElementById('chatedit').value+'</span><br />');">-->
<form>
<input type="hidden" name="channelId" value="{$channelId|escape}" />
<input type="hidden" name="nickname" value="{$nickname|escape}" />
{tr}User{/tr}: {$nickname} 
<input id="chatedit" accesskey="s" type="text" name="data" size="50" />
<!--<input type="submit" name="send" value="send" />-->
</form>