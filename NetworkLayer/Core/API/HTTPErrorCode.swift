//
//  HTTPErrorCode.swift
//
//  Created by Sachin on 13/04/17.
//


import Foundation

public enum HTTPErrorCode : Int, Error {
    // The server cannot or will not process the request due to something that is perceived to be a
    // client error (e.g., malformed request syntax, invalid request message framing, or deceptive request routing).
    case BadRequest = 400
    
    // Similar to 403 Forbidden, but specifically for use when authentication is required and has failed or has not
    // yet been provided. The response must include a WWW-Authenticate header field containing a challenge applicable
    // to the requested resource. See Basic access authentication and Digest access authentication.[37] 401 semantically
    // means "unauthenticated", i.e. "you don't have necessary credentials".
    case Unauthorized = 401
    
    // The request was a valid request, but the server is refusing to respond to it. Unlike a 401 Unauthorized response,
    // authenticating will make no difference.[39] 403 error semantically means "unauthorized", i.e. "you don't
    // have necessary permissions for the resource".
    case Forbidden = 403
    
    // The requested resource could not be found but may be available again in the future.
    // Subsequent requests by the client are permissible.
    case NotFound = 404
    
    // A request was made of a resource using a request method not supported by that resource; for example,
    // using GET on a form which requires data to be presented via POST, or using PUT on a read-only resource.
    case MethodNotAllowed = 405
    
    // The requested resource is only capable of generating content not acceptable according to the
    // Accept headers sent in the request.
    case NotAcceptable = 406
    
    // The client must first authenticate itself with the proxy.
    case ProxyAuthenticationRequired = 407
    
    // The server timed out waiting for the request. According to HTTP specifications: "The client did not produce
    // a request within the time that the server was prepared to wait. The client MAY repeat the request
    // without modifications at any later time."
    case RequestTimeout = 408
    
    // This code was defined in 1998 as one of the traditional IETF April Fools' jokes, in RFC 2324, Hyper Text
    // Coffee Pot Control Protocol, and is not expected to be implemented by actual HTTP servers.
    // The RFC specifies this code should be returned by tea pots requested to brew coffee.[54]
    // This HTTP status is used as an easter egg in some websites, including Google.com.
    case IAmATeapot = 418
    
    // Defined in the internet draft "A New HTTP Status Code for Legally-restricted Resources".
    // Intended to be used when resource access is denied for legal reasons, e.g. censorship or
    // government-mandated blocked access. A reference to the 1953 dystopian novel Fahrenheit 451, where books are outlawed.
    case Censored = 451
    
    // A generic error message, given when an unexpected condition was encountered and no more specific message is suitable.
    case InternalServerError = 500
    
    // The server either does not recognize the request method, or it lacks the ability to fulfill the request.
    // Usually this implies future availability (e.g., a new feature of a web-service API).
    case NotImplemented = 501
    
    // The server was acting as a gateway or proxy and received an invalid response from the upstream server.
    case BadGateway = 502
    
    // The server is currently unavailable (because it is overloaded or down for maintenance). Generally, this is a temporary state.
    case ServiceUnavailable = 503
    
    // The server was acting as a gateway or proxy and did not receive a timely response from the upstream server.
    case GatewayTimeout = 504
    
    // The server does not support the HTTP protocol version used in the request.
    case HTTPVersionNotSupported = 505
    
    // This status code is not specified in any RFC and is returned by certain services, for instance Microsoft Azure
    // and CloudFlare servers: "The 520 error is essentially a “catch-all” response for when the origin server
    // returns something unexpected or something that is not tolerated/interpreted (protocol violation or empty response).
    case UnknownError = 520
    
    public static var cases : Set<HTTPErrorCode> {
        get {
            let cases : Set<HTTPErrorCode> = [.BadRequest, .Unauthorized, .Forbidden, .NotFound, .MethodNotAllowed,
                                              .NotAcceptable, .ProxyAuthenticationRequired, .RequestTimeout, .IAmATeapot, .Censored,
                                              .InternalServerError, .NotImplemented, .BadGateway, .ServiceUnavailable, .GatewayTimeout, .HTTPVersionNotSupported, .UnknownError]
            
            return cases
        }
    }
}
