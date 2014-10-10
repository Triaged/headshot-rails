Messaging.Message = DS.Model.extend(
  body: DS.attr("string")
  author: DS.attr("boolean")
  thread: DS.belongsTo("thread")
)
Messaging.Message.FIXTURES = [
  {
    id: 1
    body: "This is the first message"
    author: "Bashar"
    thread: 1
  }
  {
    id: 2
    body: "This is the second message"
    author: "Charlie"
    thread: 1
  }
  {
    id: 3
    body: "This is the third message"
    author: "Bashar"
    thread: 2
  }
  {
    id: 4
    body: "This is the fourth message"
    author: "Charlie"
    thread: 2
  }
]