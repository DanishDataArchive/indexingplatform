(:
    Search for XML schemas in database.

    Parameters:
    - $collection      top level collection to start searching
    - $targetNamespace target namespace of schema 

    Returns:
    Sequence of document-uris.
    
    $Id: find_schema_by_targetNamespace.xq 6868 2007-11-05 19:14:55Z brihaye $
:)
for $schema in collection($collection)//xs:schema[@targetNamespace = $targetNamespace ]/root() 
return document-uri($schema)