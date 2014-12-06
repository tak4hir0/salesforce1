<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
<<<<<<< HEAD
        <fullName>登録フォームからの問い合わせ</fullName>
=======
        <fullName>ActionEmail</fullName>
        <description>登録フォームからの問い合わせ</description>
>>>>>>> d86af2223b9040b6337f5479af3c67fa3e9917be
        <protected>false</protected>
        <recipients>
            <field>Mail__c</field>
            <type>email</type>
        </recipients>
<<<<<<< HEAD
        <template>unfiled$public/CommunityChangePasswordEmailTemplate</template>
    </alerts>
    <fieldUpdates>
        <fullName>メールアドレス%EF%BC%88カスタム%EF%BC%89を更新</fullName>
        <field>Mail__c</field>
        <formula>&quot;tkawabata@uhuru.jp&quot;</formula>
=======
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/CommunityChangePasswordEmailTemplate</template>
    </alerts>
    <fieldUpdates>
        <fullName>ActionFieldUpdateMail</fullName>
        <field>Mail__c</field>
        <formula>&quot;tkawabata@uhuru.jp&quot;</formula>
        <name>メールアドレス（カスタム）を更新</name>
>>>>>>> d86af2223b9040b6337f5479af3c67fa3e9917be
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>メールアドレスが入力</fullName>
        <actions>
<<<<<<< HEAD
            <name>メールアドレス%EF%BC%88カスタム%EF%BC%89を更新</name>
=======
            <name>ActionFieldUpdateMail</name>
>>>>>>> d86af2223b9040b6337f5479af3c67fa3e9917be
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.MailFomula__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>メール送信</fullName>
        <actions>
<<<<<<< HEAD
            <name>登録フォームからの問い合わせ</name>
=======
            <name>ActionEmail</name>
>>>>>>> d86af2223b9040b6337f5479af3c67fa3e9917be
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Mail__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>取引先責任者更新</fullName>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
<<<<<<< HEAD
    </rules>
    <tasks>
        <fullName>取引先責任者が作られました</fullName>
=======
        <workflowTimeTriggers>
            <actions>
                <name>ActionTask</name>
                <type>Task</type>
            </actions>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <tasks>
        <fullName>ActionTask</fullName>
>>>>>>> d86af2223b9040b6337f5479af3c67fa3e9917be
        <assignedTo>tak4hir0@sf.dev</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
<<<<<<< HEAD
=======
        <subject>取引先責任者が作られました</subject>
>>>>>>> d86af2223b9040b6337f5479af3c67fa3e9917be
    </tasks>
</Workflow>
