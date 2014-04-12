trigger hoge on Opportunity (before update) {
    for(Opportunity o : Trigger.new){
        o.addError('error');
    }

}