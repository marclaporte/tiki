package wiki3d;

import java.io.DataInputStream;
import java.net.URL;

public class XmlReader {

	public String url;

	public XmlReader(String url) {
		this.url = url;
	}

	public Node getNode(String nodeName) {
		String s = getUrlData(nodeName);
		int i = s.indexOf("graph");
		int j = s.indexOf("\"", i + 4);
		int k = s.indexOf("\"", j + 2);
		nodeName = s.substring(++j, k);
		//parentNode = new Node(nodeName);
		//graph.add(parentNode);
		Node node = new Node(nodeName);
		
		
		while ((i = s.indexOf("link", ++j)) > 0) {
			j = s.indexOf("\"", i + 4);
			k = s.indexOf("\"", j + 2);
			String name = s.substring(++j, k);
			
			node.addLink(name);
			int lastlink = s.indexOf("</link>", j);			

			j = lastlink + 4;

		}
		
		return node;
	}

	private String getUrlData(String nodeName) {
		StringBuffer buffer = new StringBuffer();
		
		try {
			URL u = new URL(url + "?page=" + nodeName);
			DataInputStream b1 = new DataInputStream(u.openStream());
			int j;
			while (true) {

				j = b1.read();
				if (j == -1)
					break;
				
				buffer.append((char) j);
			}
		} catch (Exception e) {
			System.out.println("Can't get URL");
		}

		return buffer.toString();
	}

}
