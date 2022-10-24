# NetworkKit

NetworkKit is an HTTP networking library.


## Components

### Request

 - **RequestProtocol:** this protocol has all parameters needed to be used to build the request.
 - **HTTPMethod:** enumeration that provides all http methods available.

### NetworkResponse

 - **NetworkResponse:** this protocol has all information about the network response.
 - **NetworkResponseResult:** enumeration with possible network request results (success, failure).
 - **NetworkResponseError:** enumeration with possible network request errors. It is used to compose the network response result when it is a failure.

### Service

 - **ServiceProtocol:** protocol that defines methods that should be implemented by a worker.
 - **MainWorker:** it's the main worker and responsible for all requests. It **must be inherited** and its subclasses should use one of its final methods to make requests and treat the response.

```swift
// Example
class ExampleWorker: MainWorker {
    func fetchExample() {
        makeRequest(request: ExampleRequest(),
                    mapResponseAction: { response in
                        // use to convert the response into some model
                    },
                    success: { model in
                        print(model)
                    }, failure: { response in
                        print(response)
                    })
    }
}
```

### Provider

- **BackendProvider:** protocol that defines a backend provider. A backend provider is responsible for the receiving request parameters, treat them and make the request using some `ApiRequester`.
- **DefaultBackendProvider:** it's an example of backend provider with a default implementation of how to treat the request parameters (*header*, *body*, *http method*, *endpoint*, *path parameters*, *query parameters*), build the request url and make the request using the `DefaultApiRequester`. 
Feel free to inherit this class or create your own backend provider from scratch.

### ApiRequester

- **ApiRequester:** protocol that defines an api requester. The api requester is the actual component responsible for making the request and communicating to the api.
- **DefaultApiRequester:** it's an example of api requester with a default implementation of making the request.
Feel free to create your own api requester.
