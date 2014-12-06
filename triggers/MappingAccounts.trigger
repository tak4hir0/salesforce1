trigger MappingAccounts on Event (before update, before insert) {
    for(Event e : Trigger.new){
        e.WhatId = '001E000000r7lLe';
    }
}