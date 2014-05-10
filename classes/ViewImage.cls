public class ViewImage {
      public Attachment att {
            get {
                  if (att == null) {
                        String id = '00PE00000090dZe';
                        att = [SELECT Body, ContentType, Name FROM Attachment WHERE ID = :id];
                  }
                  return att;
            }
            private set;
      }
      public String image {
            get {
                  return EncodingUtil.Base64Encode(att.body);
            }
      }
}