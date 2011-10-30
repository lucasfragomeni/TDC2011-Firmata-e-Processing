package cc.bebop;

import java.util.HashMap;
import java.util.Map;

public class HTTPRequest {

	private String request;
	private String queryString;
	
	private Map<String, String> parameters = new HashMap<String, String>();
	
	public HTTPRequest(String request) {
		this.request = request;
		if(request.indexOf("favicon.ico") != 0) {
			int indexOfParams = request.indexOf("/?");
			int indexOfEndParams = request.indexOf(" ", indexOfParams);
			if(indexOfParams > 0 && indexOfEndParams > 0) {
				queryString = request.substring(indexOfParams + 2, indexOfEndParams);
				for(String params : queryString.split("&")) {
					String[] keyValue = params.split("=");
					parameters.put(keyValue[0], keyValue[1]);
				}
			}
		}
	}

	public String getParameter(String name) {
		return parameters.get(name);
	}
	
	public String[] getParameterNames() {
		return parameters.keySet().toArray(new String[parameters.size()]);
	}
	
//	public static void main(String[] args) {
//		String request = "Request: GET /?estado=1 HTTP/1.1\r\nHost: localhost:10002\r\nConnection: keep-alive\r\n" +
//				"User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_7) AppleWebKit/534.24 (KHTML, like Gecko) Chrome/11.0.696.71 Safari/534.24\r\n" +
//				"Accept: application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5\r\n" +
//				"Accept-Encoding: gzip,deflate,sdch\r\nAccept-Language: en-US,en;q=0.8\r\nAccept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.3";
//
//		new HTTPRequest(request);
//	}	
	
}
