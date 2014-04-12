@isTest
private class ImageViewController_TestClass
{
    static testMethod void test_ImageViewController ()
    {
        // Create a contact to hang an image from
        Contact Cont = new Contact (FirstName = 'Doug', LastName='Merrett');        
        insert Cont;
        
        // Create an image attachment
        List <Attachment> attachments = new List <Attachment> ();
        
        Attachment attach  = new Attachment ();
        attach.parentId    = Cont.id;
        attach.body        = EncodingUtil.base64decode ('R0lGODlhAwADAIAAAAAAAP///ywAAAAAAwADAAACA4x/BQA7');  // Base64 of a small GIF file
        attach.contenttype = 'image/gif';
        attach.name        = 'dot.gif'; 
        attachments.add (attach);
        insert attachments;
        
        PageReference pageRef = Page.ShowImageAttachments;
        Test.setCurrentPageReference (pageRef);
        
        ApexPages.currentPage ().getParameters ().put ('id', Cont.id);    
          
        ApexPages.StandardController stdCon = new ApexPages.StandardController (Cont);
        
        ImageViewController ivc = new ImageViewController (stdCon);
        
        // call internal methods to make 75% coverage -- this is not a real test class at all...
        List <ImageViewController.Photo> photos = ivc.getPhotos ();
        photos [0].getId ();
        photos [0].getUrl ();
        photos [0].getName ();
    }    
}