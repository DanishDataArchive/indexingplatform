package dk.dda.exist;

import java.io.InputStream;
import java.net.Authenticator;
import java.net.PasswordAuthentication;
import java.net.URL;
import java.net.URLConnection;

public class Denormalize {
	protected static void usage() {
		System.out
				.println("usage: dk.dda.exist.Denormalize uri xquery user passwd");
		System.exit(0);
	}

	public static void main(String args[]) throws Exception {
		if (args.length < 2)
			usage();

		final String user = args[2];
		final String passwd = args[3];
		Authenticator.setDefault(new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, passwd.toCharArray());
			}
		});

		String uri = args[0], xquery = args[1];
		URLConnection connection = new URL(uri + xquery).openConnection();
		
		connection.setRequestProperty("Accept-Charset", "UTF-8");
		InputStream response = connection.getInputStream();

		// return convertStreamToString(response);
	}
}
