class Node
  attr_accessor :element
  attr_accessor :nex
  def initialize(elem, nex = nil)
    validateElement elem
    @element = elem
    @nex = nex
  end

  def validateElement(elem)
    raise ArgumentError, "New Node requires some text" if elem.nil? || elem == ""
  end
end

class LinkedList
  attr_accessor :head
  attr_reader :size

  def initialize(elem)
    @head = Node.new(elem)
    @size = 1
  end

  def appendNode(elem)
    lastNode.nex = Node.new(elem)
    @size += 1
  end

  def addFirst(elem)
    newHead = Node.new(elem, @head)
    @head = newHead
    @size += 1
  end

  def lastNode
    current = @head

    while !current.nex.nil?
      current = current.nex
    end

    current
  end

  def removeFirst
    raise StandardError, "Can't remove a node from empty list" if @head.nil?
    original = @head
    @head = @head.nex
    original.nex = nil
    @size -= 1
  end

  def findNode(elem)
    current = @head

    while !current.nex.nil?
      return current if current.element == elem

      current = current.nex
    end

    nil
  end

  def displayNodes
    current = @head
    text = %Q[Size: #{@size}, Head: '#{current.element}' => ]
    while !current.nex.nil?
      current = current.nex
      text += %Q[element: '#{current.element}' => ]
    end

    text += " nil"
    p text
  end
end

list = LinkedList.new("testing")
list.appendNode "first"
list.appendNode "second"
list.appendNode "third"
list.displayNodes
p "Head object is: " + list.head.inspect
p " "
second = list.findNode "second"
p "find 'second' results in: " + second.inspect
p "adding a new head "
list.addFirst "New test head"
list.displayNodes
p "Removing head "
list.removeFirst
list.displayNodes

