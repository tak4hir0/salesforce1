public class D3Cloud {

    public List<String> chatter{get;set;}
    
    public D3Cloud(){
        this.chatter = new List<String>();
        
        for(FeedItem fi : [Select Type, Body From FeedItem Order By CreatedDate Asc limit 100]){

System.debug('***: ' + fi.body);

            if(fi.Type == 'TextPost' && String.isNotBlank(fi.Body)){
                
                this.chatter.add(fi.Body.subString(0,(fi.Body.length()>5 ? 5 : fi.Body.length())));
            }
        }
    }
}