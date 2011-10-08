//$Id: ClusterException.java 985 2005-01-29 14:57:28Z fmondora $
package org.exist.cluster;

/**
 * Created by Francesco Mondora.
 *
 * @author Francesco Mondora aka Makkina
 * @author Michele Danieli aka mdanieli
 *         Date: Aug 30, 2004
 *         Time: 3:58:41 PM
 *         Revision $Revision: 985 $
 */
public class ClusterException extends Exception {
    public ClusterException() {
    }

    public ClusterException(String s) {
        super(s);
    }

    public ClusterException(String s, Throwable throwable) {
        super(s, throwable);
    }

    public ClusterException(Throwable throwable) {
        super(throwable);
    }
}
