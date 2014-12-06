<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
<<<<<<< HEAD
        <fullName>Increment Push Counter</fullName>
=======
        <fullName>Increment_Push_Counter</fullName>
>>>>>>> d86af2223b9040b6337f5479af3c67fa3e9917be
        <field>SFDC_Push_Counter__c</field>
        <formula>IF(
ISNULL(  SFDC_Push_Counter__c  ),
1,
SFDC_Push_Counter__c +1
)</formula>
<<<<<<< HEAD
=======
        <name>Increment Push Counter</name>
>>>>>>> d86af2223b9040b6337f5479af3c67fa3e9917be
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Push Counter</fullName>
        <actions>
<<<<<<< HEAD
            <name>Increment Push Counter</name>
=======
            <name>Increment_Push_Counter</name>
>>>>>>> d86af2223b9040b6337f5479af3c67fa3e9917be
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Push Counterの数字をあげるルール</description>
        <formula>IF( CloseDate &gt; PRIORVALUE( CloseDate ), IF (MONTH(CloseDate) &lt;&gt; MONTH(PRIORVALUE( CloseDate )) , TRUE, FALSE), FALSE)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
