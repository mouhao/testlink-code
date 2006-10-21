{* TestLink Open Source Project - http://testlink.sourceforge.net/ $Id: resultsMoreBuilds_report.tpl,v 1.18 2006/10/21 23:03:33 kevinlevy Exp $@author Francisco Mancardi - fm - start solving BUGID 97/9820051022 - scs - removed ' in component id values20051121 - scs - added escaping of tpname20051203 - scs - added missing apo in lang_get*}	{include file="inc_head.tpl" openHead='yes'} 		<script language="JavaScript" src="gui/javascript/expandAndCollapseFunctions.js" type="text/javascript"></script>		<script language="JavaScript">		var bAllShown = false;		var g_progress = null;		var g_pCount = 0;		progress();		</script></head>	<h2>{lang_get s="caption_user_selected_query_parameters"} :</h2>	<table class="simple" style="width: 100%; text-align: center; margin-left: 0px;" border="2">		<tr>			<th>{lang_get s="th_test_plan"}</th>			<th>{lang_get s="th_builds"}</th>			<th>{lang_get s="th_test_suites"}</th>			<th>{lang_get s="th_keywords"}</th>			<th>{lang_get s="th_owners"}</th>			<th>{lang_get s="th_report_format"}</th>			<th>{lang_get s="th_last_result"}</th>		</tr> 		<tr>			<td>				{$testPlanName|escape}			</td>			<td>				{foreach key=buildrow item=array from=$buildsSelected}					{assign var=buildid value=$buildsSelected[$buildrow]}					{$mapBuilds[$buildid]|escape}				{/foreach}			</td>			<td>				{foreach key=componentrow item=array from=$componentsSelected}					{assign var=componentid value=$componentsSelected[$componentrow]}					{foreach key=x item=array from=$arrComponents}											{if ($arrComponents[$x].id) == $componentid}							{$arrComponents[$x].name|escape} <br />						{/if}					{/foreach}				{/foreach}			</td>			<td>				{foreach key=keywordrow item=array from=$keywordsSelected}					{assign var=keywordid value=$keywordsSelected[$keywordrow]}					{$arrKeywords[$keywordid]}	<br />				{/foreach}			</td>						<td>				owners - n/a			</td>						<td>				html only			</td>						<td>{$lastStatus|escape}</td>		</tr>	</table>				<table class="simple" style="width: 100%; text-align: center; margin-left: 0px;" border="2">		<tr>			<th>{lang_get s='th_total_cases'}</th>			<th>{lang_get s='th_total_pass}</th>			<th>{lang_get s='th_total_fail}</th>			<th>{lang_get s='th_total_block}</th>			<th>{lang_get s='th_total_not_run}</th>		</tr> 		<tr>			<td>{$totals.total}</td>			<td>{$totals.pass}</td>			<td>{$totals.fail}</td>			<td>{$totals.blocked}</td>			<td>{$totals.notRun}</td>		</tr>	</table>		<!-- KL - 20061021 - comment out until I can figure out how to fix	<a href="javascript:showOrCollapseAll()">{lang_get s='show_hide_all'}</a>	<h2 onClick="plusMinus_onClick(this);"><img class="minus" src="icons/minus.gif" />{lang_get s='caption_show_collapse}</h2>	-->	<div class="workBack">	{foreach key=id item=array from=$flatArray}		{if ($id mod 3) == 0}			{assign var=depthChange value=$flatArray[$id]}		{elseif ($id mod 3) == 1}			{assign var=suiteNameText value=$flatArray[$id]}		{elseif ($id mod 3) == 2}			{assign var=currentSuiteId value=$flatArray[$id]}						{if ($depthChange == 0)}				<div class="workBack">	<!-- KL - 20061021 - comment out until I can figure out how to fix		<h2 onClick="plusMinus_onClick(this);"><img class="minus" src="icons/minus.gif" />{lang_get s='caption_show_collapse}</h2>		-->					{elseif ($depthChange gt 0) }				{section name="loopOutDivs" loop="$flatArray" max="$depthChange"}					<div class="workBack"><!-- KL - 20061021 - comment out until I can figure out how to fix					<h2 onClick="plusMinus_onClick(this);"><img class="minus" src="icons/minus.gif" />{lang_get s='caption_show_collapse}</h2>-->				{/section}			{elseif ($depthChange == -1) }					</div>			{elseif ($depthChange == -2) }					</div></div>					{elseif ($depthChange == -3) }					</div></div></div>					{elseif ($depthChange == -4) }					</div></div></div></div>			{elseif ($depthChange == -5) }					</div></div></div></div></div>			{/if}			{assign var=previousDepth value=$depth}			{if $mapOfSuiteSummary[$currentSuiteId]}			<!-- KL 20061021 - Only display title of category if it has test cases in the test plan -->			<!-- not a total fix - I need to adjust results.class.php to not pass suite names in				which are not in the plan -->			<h2>{$suiteNameText|escape}</h2>						<table class="simple" style="width: 100%; text-align: center; margin-left: 0px;" border="2">				<tr>					<th>{lang_get s='th_total_cases'}</th>					<th>{lang_get s='th_total_pass}</th>					<th>{lang_get s='th_total_fail}</th>					<th>{lang_get s='th_total_block}</th>					<th>{lang_get s='th_total_not_run}</th>				</tr> 				<tr>					<td>{$mapOfSuiteSummary[$currentSuiteId].total}</td>					<td>{$mapOfSuiteSummary[$currentSuiteId].pass}</td>					<td>{$mapOfSuiteSummary[$currentSuiteId].fail}</td>					<td>{$mapOfSuiteSummary[$currentSuiteId].blocked}</td>					<td>{$mapOfSuiteSummary[$currentSuiteId].notRun}</td>				</tr>			</table>					{else}				<!-- 				{lang_get s='not_yet_executed'}				-->			{/if}				{foreach key=suiteId item=array from=$suiteList}				{* probably can be done better. If suiteId in $suiteList matches the current 				suite id - print that suite's information *}				{if ($suiteId == $currentSuiteId)}					<table class="simple" style="width: 100%; text-align: center; margin-left: 0px;" border="2">					<tr>						<th>{lang_get s='th_test case id'}</th>						<th>{lang_get s='th_build'}</th>						<th>{lang_get s='th_tester_id'}</th>						<th>{lang_get s='th_execution_ts'}</th>						<th>{lang_get s='th_status'}</th>						<th>{lang_get s='th_notes'}</th>					</tr> 					{foreach key=executionInstance item=array from=$suiteList[$suiteId]}						{assign var=inst value=$suiteList[$suiteId][$executionInstance]}						<tr>							<td>{$inst.testcaseID} </td>							<td>{$mapBuilds[$inst.build_id]|escape}</td> 							<td>{$mapUsers[$inst.tester_id].fullname|escape}</td>							<td>{$inst.execution_ts} </td>							<td>{$gsmarty_tc_status_css[$inst.status]|escape}</td>							<td>{$inst.notes|escape} </td> 						</tr>					{/foreach}										</table>				{/if}			{/foreach}													{/if}	{/foreach}	</div></body></html>