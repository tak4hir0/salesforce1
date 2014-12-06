<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Increment Push Counter</fullName>
        <field>SFDC_Push_Counter__c</field>
        <formula>IF(
ISNULL(  SFDC_Push_Counter__c  ),
1,
SFDC_Push_Counter__c +1
)</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Push Counter</fullName>
        <actions>
            <name>Increment Push Counter</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Push Counterの数字をあげるルール</description>
        <formula>IF( CloseDate &gt; PRIORVALUE( CloseDate ), IF (MONTH(CloseDate) &lt;&gt; MONTH(PRIORVALUE( CloseDate )) , TRUE, FALSE), FALSE)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
