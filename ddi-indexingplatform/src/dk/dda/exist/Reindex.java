package dk.dda.exist;

import java.util.ArrayList;

import org.exist.xmldb.IndexQueryService;
import org.exist.xmldb.XmldbURI;
import org.xmldb.api.DatabaseManager;
import org.xmldb.api.base.Collection;
import org.xmldb.api.base.Database;
import org.xmldb.api.base.XMLDBException;

public class Reindex {
	protected static void usage() {
		System.out
				.println("usage: dk.dda.exist.Reindex uri collection user passwd");
		System.exit(0);
	}

	public static void main(String args[]) throws Exception {
		if (args.length < 2)
			usage();

		String uri = args[0], collection = args[1], user = args[2], passwd = args[3];

		// initialize driver
		String driver = "org.exist.xmldb.DatabaseImpl";
		Class<?> cl = Class.forName(driver);
		Database database = (Database) cl.newInstance();
		database.setProperty("create-database", "true");

		DatabaseManager.registerDatabase(database);

		// try to get collection
		Collection col = DatabaseManager.getCollection(uri + "/" + collection,
				user, passwd);
		if (col == null) {
			System.out.println(uri + "/" + collection + " does not exist");
		}

		System.out.print("start reindex uri collection: " + uri + "/"
				+ collection + "...");
		try {			
			ArrayList subCollections = getCollections(col, new ArrayList());
			System.out.println("subCollections size: " + subCollections.size());
			
			IndexQueryService service = (IndexQueryService) col.getService(
					"IndexQueryService", "1.0");
			service.reindexCollection(XmldbURI.xmldbUriFor(uri, collection));
			for (int i = 0; i < subCollections.size(); i++) {
				System.out.print("reindexing collection: "
						+ (XmldbURI) subCollections.get(i)+"...");
				service.reindexCollection((XmldbURI) subCollections.get(i));
			}
			System.out.println("ok.");
		} catch (Exception e) {
			System.out.println("Exception");
			e.printStackTrace();
		}
	}

	private static ArrayList getCollections(Collection root,
			ArrayList collectionsList) throws XMLDBException {
		collectionsList.add(XmldbURI.create(root.getName()));
		String[] childCollections = root.listChildCollections();
		Collection child;
		for (int i = 0; i < childCollections.length; i++) {
			child = root.getChildCollection(childCollections[i]);
			getCollections(child, collectionsList);
		}
		return collectionsList;
	}
}
