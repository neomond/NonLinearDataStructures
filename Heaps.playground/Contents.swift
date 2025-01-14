// MARK: - Heaps

//A heap is a specialized data structure used to keep track of the minimum or maximum values in the structure. We visualize a heap as a binary tree , although in implementation it is most common to use an array to store our values.
//Binary trees, a subset of a classic tree structure,essentially means that each parent can have at most two children, a left child, and a right child.

/// Binary is a number system of 1s and 0s which serves as a textual representation method for giving instructions to a computers CPU.
/// DS - Systems for organizing data that dictate how items relate to one another, are accessed, and modified.

// This technique of reducing a problem down to its smallest solvable chunk is called dynamic programming, a common topic of technical interviews. In order for our data structure to be truly classified as a heap one of two conditions must be met for each branch in a binary tree:
//In a min-heap, for any given element, its parent’s value is less than or equal to its value.
//In a max-heap, for any given element, its parent’s value is greater than or equal to its value.


import Foundation

class MinHeap {
    
    // Instance Variables
    private var heap: [TaskNode]
    private var size: Int {
        heap.count
    }
    
    // Initializer
    init() {
        self.heap = []
    }
    
    // Public Functions
    
    // Add Function -> Adds a task to the heap
    func add(task: String, dueDate: Date) {
        let taskNode = TaskNode(task, dueDate)
        heap.append(taskNode)
        heapifyUp()
    }
    
    // getTask Function -> Allows a user to see the task without removing it
    func getTask() {
        if heap.isEmpty {
            print("Your task list is empty, good job!")
        } else {
            print("Your next task is: \(heap[0])")
        }
    }
    
    // finishTask Function -> Removes the task from the heap and reorganizes it
    func finishTask() {
        if heap.isEmpty {
            print("There are no tasks left to complete.")
        } else {
            heap.swapAt(0, size - 1)
            print("Removing: \(heap.remove(at: size - 1))")
            heapifyDown()
        }
    }
    
    // Private Functions
    
    // HeapifyUp Function -> Makes sure the the parent node is older than its children
    private func heapifyUp() {
        var currentIndex = size - 1
        while currentIndex > 0 && heap[currentIndex] < heap[parentIndex(of: currentIndex)] {
            heap.swapAt(currentIndex, parentIndex(of: currentIndex))
            currentIndex = parentIndex(of: currentIndex)
        }
    }
    
    // HeapifyDown Function -> Makes sure the older child is swapped with a younger parent
    private func heapifyDown() {
        var currentIndex = 0
        var toSwap: (needsToSwap: Bool, olderChildIndex: Int) = hasOlderChildren(currentIndex)
        while toSwap.needsToSwap {
            heap.swapAt(currentIndex, toSwap.olderChildIndex)
            currentIndex = toSwap.olderChildIndex
            toSwap = hasOlderChildren(currentIndex)
        }
    }
    
    // hasOlderChildren Function -> Determines if a parent has children to swap with and returns the bool to run the while loop and the index of the oldest child to swap with
    private func hasOlderChildren(_ currentIndex: Int) -> (Bool, Int) {
        var olderChild = false
        var olderChildIndex = 0
        
        let leftChildIndex = findLeftChildIndex(of: currentIndex)
        let rightChildIndex = findRightChildIndex(of: currentIndex)
        if indexExists(leftChildIndex) && heap[currentIndex] > heap[leftChildIndex] {
            olderChild = true
            olderChildIndex = leftChildIndex
        }
        if indexExists(rightChildIndex)
            && heap[currentIndex] > heap[rightChildIndex]
            && heap[rightChildIndex] < heap[leftChildIndex]{
            olderChild = true
            olderChildIndex = rightChildIndex
        }
        return (olderChild, olderChildIndex)
    }
    
    // Helper Functions
    private func findLeftChildIndex(of index: Int) -> Int {
        return (2 * index) + 1
    }
    
    private func findRightChildIndex(of index: Int) -> Int {
        return (2 * index) + 2
    }
    
    private func parentIndex(of index: Int) -> Int {
        return (index - 1) / 2
    }
    
    private func indexExists(_ index: Int) -> Bool {
        return index < size
    }
}

extension MinHeap: CustomStringConvertible {
    
    var description: String {
        var text = ""
        text += "Total outstanding tasks: \(size)\n"
        var taskNumber = 1
        for task in heap {
            text += "\(taskNumber): \(task)\n"
            taskNumber += 1
        }
        return String(text.dropLast(1))
    }
}

class TaskNode {
    
    // Instance Variables
    private let dueDate: Date
    private let task: String
    
    // Initializer
    init(_ task: String, _ dueDate: Date) {
        self.dueDate = dueDate
        self.task = task
    }
    func getTask() -> String {
        return task
    }
}

extension TaskNode: Comparable, CustomStringConvertible {
    static func < (lhs: TaskNode, rhs: TaskNode) -> Bool {
        lhs.dueDate < rhs.dueDate
    }

    static func == (lhs: TaskNode, rhs: TaskNode) -> Bool {
        lhs.dueDate == rhs.dueDate && lhs.task == rhs.task
    }
    var description: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        if dueDate < Date() {
            return "LATE: \(task), Due: \(dateFormatter.string(from: dueDate))"
        }
        return "\(task), Due: \(dateFormatter.string(from: dueDate))"
    }
}


let toDoList: MinHeap = MinHeap();
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
toDoList.add(task: "Meeting: Annual Review", dueDate: dateFormatter.date(from: "05/01/2045 09:00")!)
toDoList.add(task: "Submit Initial Design Ideas", dueDate: dateFormatter.date(from: "05/01/2000 11:00")!)
toDoList.add(task: "Review Swift Fundamentals", dueDate: dateFormatter.date(from: "04/28/2000 19:00")!)
toDoList.add(task: "Finish Lesson on Algorithms", dueDate: dateFormatter.date(from: "03/22/2000 13:45")!)
toDoList.add(task: "Apply for Job", dueDate: dateFormatter.date(from: "06/17/2044 12:55")!)
toDoList.add(task: "Finish Interview Prep", dueDate: dateFormatter.date(from: "07/25/2046 11:05")!)
toDoList.add(task: "Complete Code Review", dueDate: dateFormatter.date(from: "10/29/2012 15:30")!)
toDoList.add(task: "Mentor Intern", dueDate: dateFormatter.date(from: "09/15/2041 16:25")!)
toDoList.add(task: "Swap Laundry", dueDate: dateFormatter.date(from: "11/05/2003 13:00")!)
toDoList.add(task: "Run Anti Virus Software", dueDate: dateFormatter.date(from: "08/31/2009 23:30")!)
toDoList.add(task: "Relax", dueDate: dateFormatter.date(from: "01/11/2100 19:00")!)
print(toDoList)

 

// MARK: - Heaps Review
// A heap is a data structure that stores the minimum or maximum values at the top of the heap, depending on how it is set up
// Each subtree, that is a parent node and its left and right children, will also maintain order. The parent node is always less than its children in a min-heap, or greater than its children in a max-heap.
// The top of the heap is accessed in O(1), or constant time, since the value at index 0 is always the priority value, no need to search for it.
// Adding and removing elements from the heap run in O(logN) time, where N is the count of all elements in the heap.
// Heaps, though visualized as binary trees, are most commonly stored in an array. Parent and child elements are not stored sequentially but rather separated by a factor of 2.
// When we add an element to a heap, we add it at the end of the array, we then must heapify up until we find a place in the tree that satisfies the heap conditions.
// Removing an element is not as easy as removing the first element in the array, if we did that we would fracture the tree. Instead, we swap the first and last nodes, remove the last node, and then heapfiy down the tree from the new top node until its placement satisfies the heap conditions.
// Heaps are integral to the famous Dijkstra’s algorithm, which uses a min-heap to find the shortest path between two nodes of a graph.
