<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>chatter_answers_num_subscriptions_above_</fullName>
        <description>Priority</description>
        <field>Priority</field>
        <literalValue>high</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>chatter_answers_no_best_reply_within_time_limit_wf</fullName>
        <active>false</active>
        <formula>NOT(ISPICKVAL(Priority,&apos;high&apos;)) &amp;&amp; ISBLANK(BestReplyId)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>chatter_answers_num_subscriptions_above_limit_wf</fullName>
        <actions>
            <name>chatter_answers_num_subscriptions_above_</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>NOT(ISPICKVAL(Priority,&apos;high&apos;)) &amp;&amp; ISBLANK(BestReplyId) &amp;&amp; NumSubscriptions &gt;= 20</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
