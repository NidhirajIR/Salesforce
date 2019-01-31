/*
Description - Basic http callout 
Author - Nidhiraj IR

Steps-
1.Created new remote site inside salesforce.
2.Provided Remote Site URL as 'https://postman-echo.com/get?foo1=bar1&foo2=bar2'.

*/
HttpRequest feedRequest = new HttpRequest();
feedRequest.setEndpoint('https://postman-echo.com/get?foo1=bar1&foo2=bar2');
feedRequest.setMethod('GET');
Http http = new Http();
HTTPResponse feedResponse = http.send(feedRequest);
System.debug(feedResponse.getBody());
