(:
    Search for DTD in catalogs of database.

    Parameters:
    - $collection      top level collection to start searching
    - $PublicId        public identifier of DTD 

    Returns:
    Sequence of document-uris.

    $Id: find_catalogs_with_dtd.xq 6868 2007-11-05 19:14:55Z brihaye $    
:)
declare namespace ctlg='urn:oasis:names:tc:entity:xmlns:xml:catalog';
for $uri in collection($collection)//ctlg:catalog/ctlg:public[@publicId = $publicId]/@uri/root()
return document-uri($uri)