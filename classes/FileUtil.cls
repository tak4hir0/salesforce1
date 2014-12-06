public class FileUtil {
    
    public static HTTPResponse upload2Box(Attachment file){
      String boundary = '__boundary__xxx';

      String header = '--'+boundary+'\r\n';
      header += 'Content-Disposition: form-data; name="filename"; filename="' + file.name + '"\r\n';
      header += 'Content-Type: application/octet-stream\r\n\r\n';
     
      String footer = '\r\n--'+boundary+'--';
       
      // no trailing padding on header by adding ' ' before the last "\n\n" characters
      String headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n'));
      //this ensures no trailing "=" padding
      while(headerEncoded.endsWith('='))
      {
       header+=' ';
       headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n'));
      }
      //base64 encoded body
      String bodyEncoded = EncodingUtil.base64Encode(file.body);
      //base64 encoded footer
      String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
       
      Blob bodyBlob = null;
      //last encoded body bytes
      String last4Bytes = bodyEncoded.substring(bodyEncoded.length()-4,bodyEncoded.length());
      //if the last 4 bytes encoded base64 ends with the padding character (= or ==) then re-encode those bytes with the footer
      //to ensure the padding is added only at the end of the body
      if(last4Bytes.endsWith('='))
      {
       Blob decoded4Bytes = EncodingUtil.base64Decode(last4Bytes);
       HttpRequest tmp = new HttpRequest();
       tmp.setBodyAsBlob(decoded4Bytes);
       String last4BytesFooter = tmp.getBody()+footer;   
       bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded.substring(0,bodyEncoded.length()-4)+EncodingUtil.base64Encode(Blob.valueOf(last4BytesFooter)));
      }
      else
      {
       bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);
      }
       
      if(bodyBlob.size()>3000000)
      { 
       //this a "public class CustomException extends Exception{}"
       //throw new CustomException('File size limit is 3 MBytes');
      }
      
      HttpRequest req = new HttpRequest();
      req.setHeader('Content-Type','multipart/form-data; boundary='+boundary);
      req.setMethod('POST');
      req.setEndpoint('https://upload.box.com/api/2.0/files/content?folder_id=0');
      req.setBodyAsBlob(bodyBlob);
      req.setTimeout(60000);
      req.setHeader('Authorization', 'Bearer TxyJxo6JDE6a4uPusA0QoPCbZqYZzg16');
      req.setHeader('Content-Length',String.valueof(req.getBodyAsBlob().size()));
      
      //System.debug('***: ' + req.getHeader('Authorization'));
      //System.debug('***: ' + req.getHeader('Content-Type'));
      //System.debug('***: ' + req.getHeader('Content-Length'));      
      //System.debug('***: ' + req.getBody());
      
      Http http = new Http();
      HTTPResponse res = http.send(req);
      
      return res;
    }
    
    public static HTTPResponse uploadFile(Attachment file)
    {
      String boundary = '__boundary__xxx';
      String header = '--'+boundary+'\n';
      header += 'Content-Disposition: form-data; name="data"; filename="'+file.name
        +'"\nContent-Type: application/octet-stream';
     
      String footer = '\n--'+boundary+'--';
       
      // no trailing padding on header by adding ' ' before the last "\n\n" characters
      String headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\n\n'));
      //this ensures no trailing "=" padding
      while(headerEncoded.endsWith('='))
      {
       header+=' ';
       headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\n\n'));
      }
      //base64 encoded body
      String bodyEncoded = EncodingUtil.base64Encode(file.body);
      //base64 encoded footer
      String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
       
      Blob bodyBlob = null;
      //last encoded body bytes
      String last4Bytes = bodyEncoded.substring(bodyEncoded.length()-4,bodyEncoded.length());
      //if the last 4 bytes encoded base64 ends with the padding character (= or ==) then re-encode those bytes with the footer
      //to ensure the padding is added only at the end of the body
      if(last4Bytes.endsWith('='))
      {
       Blob decoded4Bytes = EncodingUtil.base64Decode(last4Bytes);
       HttpRequest tmp = new HttpRequest();
       tmp.setBodyAsBlob(decoded4Bytes);
       String last4BytesFooter = tmp.getBody()+footer;   
       bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded.substring(0,bodyEncoded.length()-4)+EncodingUtil.base64Encode(Blob.valueOf(last4BytesFooter)));
      }
      else
      {
       bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);
      }
       
      if(bodyBlob.size()>3000000)
      { 
       //this a "public class CustomException extends Exception{}"
       //throw new CustomException('File size limit is 3 MBytes');
      }
       
      HttpRequest req = new HttpRequest();
      req.setHeader('Content-Type','multipart/form-data; boundary='+boundary);
      req.setMethod('POST');
      req.setEndpoint('http://posttestserver.com/post.php?dir=watchdox');  
      req.setBodyAsBlob(bodyBlob);
      req.setTimeout(60000);
      req.setHeader('Content-Length',String.valueof(req.getBodyAsBlob().size()));
      
      //System.debug('***: ' + req.getHeader('Authorization'));
      //System.debug('***: ' + req.getHeader('Content-Type'));
      //System.debug('***: ' + req.getHeader('Content-Length'));      
      //System.debug('***: ' + req.getBody());
      
      Http http = new Http();
      HTTPResponse res = http.send(req);
      
      return res;
    }

}