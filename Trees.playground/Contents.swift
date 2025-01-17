// MARK: - TREES
/// Trees are an essential data structure for storing hierarchical data with a directed flow. Similar to linked lists and graphs, trees are composed of nodes which hold data.
/// - root: A node which has no parent. One per tree.
/// - parent: A node which references other nodes.
/// - child: Nodes referenced by other nodes.
/// - sibling: Nodes which have the same parent.
/// - leaf: Nodes which have no children.
/// - level: The height or depth of the tree. Root nodes are at level 1, their children are at level 2, and so on.

// A tree contains nodes, specifically:
// - A root node
// - Branch nodes
// - Leaf nodes

//Branch nodes have children
//Leaf nodes do not have children

//We can traverse a tree either depth-first or breadth-first
//We can define equality by implementing the Equatable protocol and define what equal means to our classes.
//We can change the way Swift prints a class by implementing the CustomStringConvertible protocol and defining what data to return as the description variable.

// A basic TreeNode class has two mandatory properties, its data, which is used to store the value of what the node is designed to hold, and its children, typically an array that is used to store references to subordinate TreeNodes.


import UIKit

class TreeNode<T: Equatable>: Equatable, CustomStringConvertible {
    
    //  MARK: - Instance Variables
    var data: T
    var children: [TreeNode]
    weak var parent: TreeNode?
    
    // MARK: - Initializer
    init(data: T) {
        self.data = data
        self.children = []
    }
    
    // MARK: - addChild Methods
    func addChild(_ newChild: TreeNode) {
        newChild.parent = self
        children.append(newChild)
    }
    
    // MARK: -  function overloading - We want to create two variations of the .addChild() method  one that accepts a complete TreeNode as an argument  and one that accepts a String  as an argument and then creates a TreeNode from that String. This technique, also called function overloading (or method overloading, depending on your programming language), is the practice of creating multiple instances of a function with different parameters and/or return types. You’ll run into this practice quite often as it serves a variety of roles, from making your code easier to use to allowing you to encapsulate (hide from the user) certain internal functions of your program.
    
    func addChild(newChildData: T) {
        children.append(TreeNode(data: newChildData))
    }
    func addChildren(_ newChildren: [TreeNode]) {
        children.append(contentsOf: newChildren)
    }
    
    // MARK: - removeChild Method
    func removeChild(_ nodeToRemove: TreeNode) {
        if children.isEmpty {
            return
        } else if children.contains(nodeToRemove) {
            children.removeAll(where: {$0 == nodeToRemove})
            return
        } else {
            for child in children {
                child.removeChild(nodeToRemove)
            }
        }
    }
    
    // MARK: - Equatable Protocol
    static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        lhs.data == rhs.data && lhs.children == rhs.children
    }
    // MARK: - CustomStringConvertible Protocol
    var description: String {
        return "\(data)"
    }
}


class Tree<T: Equatable> {
    var root: TreeNode<T>
    
    init(root: TreeNode<T>) {
        self.root = root
    }
    
    // MARK: - print Method
    func print() {
        printFrom(root)
    }
    
    // MARK: - printFrom Method
    func printFrom(_ currentNode: TreeNode<T>, _ depth: Int = 0) {
        let depthMarker = String(repeating: "--|", count: depth)
        Swift.print("\(depthMarker)\(currentNode)")
        for child in currentNode.children {
            printFrom(child, depth + 1)
        }
    }
    
    // MARK: - find Methods
    func find(matchingNode: TreeNode<T>) -> TreeNode<T>? {
        return find(matchingNode: matchingNode, root)
    }
    private func find(matchingNode: TreeNode<T>, _ currentNode: TreeNode<T>) -> TreeNode<T>? {
        if matchingNode == currentNode {
            return currentNode
        }
        for child in currentNode.children {
            if let found = find(matchingNode: matchingNode, child) {
                return found
            }
        }
        return nil
    }
    
    // MARK: - Depth First Traversal
    func depthFirstTraversal(startingAtNode: TreeNode<T>) {
        Swift.print("\(startingAtNode) ", terminator: "")
        for child in startingAtNode.children {
            depthFirstTraversal(startingAtNode: child)
        }
    }
    
    // MARK: - Breadth First Traversal
    func breadthFirstTraversal() {
        var queue = [TreeNode<T>]()
        queue.append(root)
        while !queue.isEmpty {
            let currentNode = queue.removeFirst()
            Swift.print("\(currentNode) ", terminator: "")
            queue.append(contentsOf: currentNode.children)
        }
    }
}

let matriarch = TreeNode(data: "Tracy")
let tim = TreeNode(data: "Tim")
let spencer = TreeNode(data: "Spencer")
let daina = TreeNode(data: "Daina")
let olivia = TreeNode(data: "Olivia")
let noah = TreeNode(data: "Noah")
let zola = TreeNode(data: "Zola the Dog")
let luna = TreeNode(data: "Luna the Cat")
let sansa = TreeNode(data: "Sansa the Dog")
let finnegan = TreeNode(data: "Finnegan the Cat")
let pepeduke = TreeNode(data: "Pepeduke the Cat")
let flora = TreeNode(data: "Flora the Puppy")
let notInFamily = TreeNode(data: "Poe")
matriarch.addChildren([tim, spencer, daina])
tim.addChildren([olivia, noah, zola, luna])
spencer.addChild(sansa)
sansa.addChild(flora)
daina.addChildren([finnegan, pepeduke])
let stringTree = Tree(root: matriarch)


let root = TreeNode(data: 54)
let branch1 = TreeNode(data: 33)
let branch2 = TreeNode(data: 32)
let branch3 = TreeNode(data: 27)
let branch1_1 = TreeNode(data: 12)
let branch1_2 = TreeNode(data: 10)
let branch1_3 = TreeNode(data: 6)
let branch1_4 = TreeNode(data: 1)
let branch2_1 = TreeNode(data: 2)
let branch3_1 = TreeNode(data: 5)
let branch3_2 = TreeNode(data: 3)
let branch2_1_1 = TreeNode(data: 1)
root.addChildren([branch1, branch2, branch3])
branch1.addChildren([branch1_1, branch1_2, branch1_3, branch1_4])
branch2.addChild(branch2_1)
branch2_1.addChild(branch2_1_1)
branch3.addChildren([branch3_1, branch3_2])
let intergerTree = Tree(root: root)


let charRoot = TreeNode<Character>(data: "🇨🇦")
let charBranch1 = TreeNode<Character>(data: "🇨🇱")
let charBranch2 = TreeNode<Character>(data: "🇭🇷")
let charBranch3 = TreeNode<Character>(data: "\u{1F1FA}\u{1F1F8}")
let charBranch1_1 = TreeNode<Character>(data: "🇬🇬")
let charBranch1_2 = TreeNode<Character>(data: "🇺🇿")
let charBranch1_3 = TreeNode<Character>(data: "🇺🇬")
let charBranch1_4 = TreeNode<Character>(data: "🇾🇪")
let charBranch2_1 = TreeNode<Character>(data: "🇦🇿")
let charBranch3_1 = TreeNode<Character>(data: "🇦🇶")
let charBranch3_2 = TreeNode<Character>(data: "🏴‍☠️")
let charBranch2_1_1 = TreeNode<Character>(data: "🇦🇮")
charRoot.addChildren([charBranch1, charBranch2, charBranch3])
charBranch1.addChildren([charBranch1_1, charBranch1_2, charBranch1_3, charBranch1_4])
charBranch2.addChild(charBranch2_1)
charBranch2_1.addChild(charBranch2_1_1)
charBranch3.addChildren([charBranch3_1, charBranch3_2])
let charTree = Tree(root: charRoot)

stringTree.print()
print()
intergerTree.print()
print()
charTree.print()
