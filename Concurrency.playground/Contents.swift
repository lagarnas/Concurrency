import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

import Foundation

func performFiveTimes(_ block: () -> Void) {
    for _ in 0..<5 {
        block()
    }
}

func bananaTask() {
    performFiveTimes {
        print("🍌")
    }
}

func tomatoTask() {
    performFiveTimes {
        print("🍅")
    }
}

// create queues

let serialQueue = DispatchQueue(label: "concurrency.playground.serial")
let concurrentQueue = DispatchQueue(label: "concurrency.playground.concurrent", attributes: .concurrent)


// sync vc. async

/// 1
//serialQueue.sync {
//    bananaTask()
//}
//tomatoTask()

/// 2
//serialQueue.async {
//    bananaTask()
//}
//tomatoTask()


// serial vc. concurrent

/// 1
//serialQueue.async {
//    bananaTask()
//}
//
//serialQueue.async {
//    tomatoTask()
//}

/// 2
concurrentQueue.async {
    bananaTask()
}

concurrentQueue.async {
    tomatoTask()
}


// dispatch group

let group = DispatchGroup()

group.enter()
concurrentQueue.async {
    bananaTask()
    group.leave()
}

group.enter()
concurrentQueue.async {
    tomatoTask()
    group.leave()
}

group.notify(queue: concurrentQueue) {
    print("done!")
}
