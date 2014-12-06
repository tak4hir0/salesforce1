//Copyright (c) 2009, Doug Merrett, Sales Engineering, Salesforce.com Inc.
//All rights reserved.
//
//Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. 
//Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//Neither the name of the salesforce.com nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission. 
//THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
//INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
//SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
//LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
//CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, 
//EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

//
// History
//
// Version  Date            Author          Comments
// 1.0      16-03-2009      Doug Merrett    Initial version
//

//
// Please see the Instructions document in the ViewAttachments folder in the Documents tab.  This code does not need modifying for different parent objects as I
// use the generic SObject type for the getRecord from the standard controller.
//           
                
public class ImageViewController
{
    private final SObject so;
    private List<Photo> myPhotos = new List<Photo> ();
    
    public ImageViewController (ApexPages.StandardController controller)
    {
        this.so = controller.getRecord ();
        fetchPhotos ();
    }

    public class Photo
    {
        String id;
        String url;
        String name;
        
        public Photo (String ipId, String ipName)
        {
            id   = ipId;
            url  = '/servlet/servlet.FileDownload?file=' + id;  // This is the standard SFDC manner to "download" attachments.
            name = ipName;
        }
        
        public String getId ()
        {
            return id;
        }
        
        public String getUrl ()
        {
            return url;
        }
        
        public String getName ()
        {
            return name;
        }
    }

    private void fetchPhotos ()
    {
        myPhotos.clear ();  // Empty list
        
        for (Attachment a : [Select Id, Name, ContentType From Attachment Where ParentId = :so.Id])
        {
            if (a.ContentType.startsWith ('image/'))  // Only add images to the list, ignore all other types
            {
                myPhotos.add (new Photo (a.Id, a.Name));
            }
        }
    }
                                   
    public List<Photo> getPhotos ()
    {
        return myPhotos;
    }             
}