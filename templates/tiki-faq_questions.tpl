<a class="pagetitle" href="tiki-faq_questions.php?faqId={$faqId}">Admin FAQ: {$faq_info.title}</a><br/><br/>
[<a href="tiki-list_faqs.php" class="link">{tr}List FAQs{/tr}</a>
|<a href="tiki-view_faq.php?faqId={$faqId}" class="link">{tr}View FAQ{/tr}</a>
|<a href="tiki-list_faqs.php?faqId={$faqId}" class="link">{tr}Edit this FAQ{/tr}</a>
|<a class="link" href="tiki-faq_questions.php?faqId={$faqId}">{tr}new question{/tr}</a>]<br/><br/>
<h2>{tr}Edit FAQ questions{/tr}</h2>
<form action="tiki-faq_questions.php" method="post">
<input type="hidden" name="questionId" value="{$questionId}" />
<input type="hidden" name="faqId" value="{$faqId}" />
<table class="normal">
<tr><td class="formcolor">{tr}Question{/tr}:</td><td class="formcolor" ><textarea type="text" rows="2" cols="60" name="question">{$question}</textarea></td></tr>
<tr><td class="formcolor">{tr}Answer{/tr}:</td><td class="formcolor" ><textarea type="text" rows="8" cols="60" name="answer">{$answer}</textarea></td></tr>
<tr><td  class="formcolor">&nbsp;</td><td class="formcolor" ><input type="submit" name="save" value="{tr}Save{/tr}" /></td></tr>
</table>
</form>
<h2>{tr}Use a question from another FAQ{/tr}</h2>
<form action="tiki-faq_questions.php" method="post">
<input type="hidden" name="questionId" value="{$questionId}" />
<input type="hidden" name="faqId" value="{$faqId}" />
<table class="normal">
<tr><td class="formcolor">{tr}Filter{/tr}</td><td class="formcolor"><input type="text" name="filter" value="{$filter}" /><input type="submit" name="filteruseq" value="{tr}filter{/tr}" /></td></tr>
<tr><td class="formcolor">{tr}Question{/tr}:</td><td class="formcolor" >
<select name="usequestionId">
{section name=ix loop=$allq}
<option value="{$allq[ix].questionId}">{$allq[ix].question}</option>
{/section}
</select>
</td></tr>
<tr><td class="formcolor">&nbsp;</td><td class="formcolor"><input type="submit" name="useq" value="{tr}use{/tr}" /></td></tr>
</table>
</form>
<br/>
<h2>{tr}FAQ questions{/tr}</h2>
<div  align="center">
<table class="findtable">
<tr><td class="findtable">{tr}Find{/tr}</td>
   <td class="findtable">
   <form method="get" action="tiki-faq_questions.php">
     <input type="text" name="find" value="{$find}" />
     <input type="submit" value="{tr}find{/tr}" name="search" />
     <input type="hidden" name="sort_mode" value="{$sort_mode}" />
   </form>
   </td>
</tr>
</table>
<table class="normal">
<tr>
<td class="heading"><a class="tableheading" href="tiki-faq_questions.php?faqId={$faqId}&amp;offset={$offset}&amp;sort_mode={if $sort_mode eq 'questionId_desc'}questionId_asc{else}questionId_desc{/if}">{tr}ID{/tr}</a></td>
<td class="heading"><a class="tableheading" href="tiki-faq_questions.php?faqId={$faqId}&amp;offset={$offset}&amp;sort_mode={if $sort_mode eq 'question_desc'}question_asc{else}question_desc{/if}">{tr}question{/tr}</a></td>
<td class="heading">{tr}action{/tr}</td>
</tr>
{section name=user loop=$channels}
{if $smarty.section.user.index % 2}
<tr>
<td class="odd">{$channels[user].faqId}</td>
<td class="odd">{$channels[user].question}</td>
<td class="odd">
   <a class="link" href="tiki-faq_questions.php?faqId={$faqId}&amp;offset={$offset}&amp;sort_mode={$sort_mode}&amp;remove={$channels[user].questionId}">{tr}remove{/tr}</a>
   <a class="link" href="tiki-faq_questions.php?faqId={$faqId}&amp;offset={$offset}&amp;sort_mode={$sort_mode}&amp;questionId={$channels[user].questionId}">{tr}edit{/tr}</a>
   
</td>
</tr>
{else}
<tr>
<td class="even">{$channels[user].faqId}</td>
<td class="even">{$channels[user].question}</td>
<td class="even">
   <a class="link" href="tiki-faq_questions.php?faqId={$faqId}&amp;offset={$offset}&amp;sort_mode={$sort_mode}&amp;remove={$channels[user].questionId}">{tr}remove{/tr}</a>
   <a class="link" href="tiki-faq_questions.php?faqId={$faqId}&amp;offset={$offset}&amp;sort_mode={$sort_mode}&amp;questionId={$channels[user].questionId}">{tr}edit{/tr}</a>
</td>
</tr>
{/if}
{/section}
</table>
<br/>
<div class="mini">
{if $prev_offset >= 0}
[<a class="prevnext" href="tiki-faq_questions.php?find={$find}&amp;faqId={$faqId}&amp;offset={$prev_offset}&amp;sort_mode={$sort_mode}">{tr}prev{/tr}</a>]&nbsp;
{/if}
{tr}Page{/tr}: {$actual_page}/{$cant_pages}
{if $next_offset >= 0}
&nbsp;[<a class="prevnext" href="tiki-faq_questions.php?find={$find}&amp;faqId={$faqId}&amp;offset={$next_offset}&amp;sort_mode={$sort_mode}">{tr}next{/tr}</a>]
{/if}
</div>
</div>

