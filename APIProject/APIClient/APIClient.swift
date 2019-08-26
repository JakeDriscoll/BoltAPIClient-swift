import Foundation

struct APIClient {
    //MARK: Properties
    private let queue = OperationQueue()
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    
    //MARK: Workers
    @discardableResult
    func request(_ request: URLRequest, priority: Operation.QueuePriority = .normal, completion: @escaping (Data?, URLResponse?, Error?) -> ()) -> URLSessionTaskOperation {

        let task = self.session.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }
        let operation = URLSessionTaskOperation(task: task)
        operation.queuePriority = priority
        self.queue.addOperation(operation)
        
        return operation
    }
}
