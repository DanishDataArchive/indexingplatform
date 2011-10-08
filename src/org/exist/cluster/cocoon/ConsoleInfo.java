//$Id: ConsoleInfo.java 1538 2005-08-05 18:04:49Z nbreda $
package org.exist.cluster.cocoon;

import java.io.Serializable;
import java.util.HashMap;

/**
 * Created by Nicola Breda.
 *
 * @author Nicola Breda aka maiale
 * @author David Frontini aka spider
 *         Date: 05-aug-2005
 *         Time: 18.09.08
 *         Revision $Revision: 1538 $
 */
public class ConsoleInfo implements Serializable{

    private static final long serialVersionUID = 0L;

    private HashMap map = new HashMap();

    public void setProperty(String name, Object value){
        map.put(name,value);
    }

    public Object getProperty(String name){
        return map.get(name);    
    }

}
