<h6>{tr}Tracker Item Modified{/tr}</h6>
<p>{object_link type=$activity.type id=$activity.object} in {object_link type=tracker id=$activity.trackerId}</p>
<small>{tr _0=$activity.user|userlink _1=$activity.event_date|tiki_short_datetime}By %0 (%1){/tr}</small>
