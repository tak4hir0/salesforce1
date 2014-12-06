<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
<<<<<<< HEAD
        <fullName>chatter_answers_num_subscriptions_above_</fullName>
        <description>Priority</description>
        <field>Priority</field>
        <literalValue>high</literalValue>
=======
        <fullName>X01RE0000000MI80</fullName>
        <description>Priority</description>
        <field>Priority</field>
        <literalValue>high</literalValue>
        <name>chatter_answers_num_subscriptions_above_</name>
>>>>>>> d86af2223b9040b6337f5479af3c67fa3e9917be
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>chatter_answers_no_best_reply_within_time_limit_wf</fullName>
        <active>false</active>
        <formula>NOT(ISPICKVAL(Priority,&apos;high&apos;)) &amp;&amp; ISBLANK(BestReplyId)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
<<<<<<< HEAD
=======
        <workflowTimeTriggers>
            <actions>
                <name>X01RE0000000MI80</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Question.CreatedDate</offsetFromField>
            <timeLength>24</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
>>>>>>> d86af2223b9040b6337f5479af3c67fa3e9917be
    </rules>
    <rules>
        <fullName>chatter_answers_num_subscriptions_above_limit_wf</fullName>
        <actions>
<<<<<<< HEAD
            <name>chatter_answers_num_subscriptions_above_</name>
=======
            <name>X01RE0000000MI80</name>
>>>>>>> d86af2223b9040b6337f5479af3c67fa3e9917be
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>NOT(ISPICKVAL(Priority,&apos;high&apos;)) &amp;&amp; ISBLANK(BestReplyId) &amp;&amp; NumSubscriptions &gt;= 20</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
