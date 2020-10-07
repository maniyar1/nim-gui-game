# This example shows several controls of NiGui.

import nigui, net, locks

proc server() {.thread.} =
  var socket = newSocket()
  socket.bindAddr(Port(1234))
  socket.listen()
  var client = new Socket
  var address = ""
  while true:
    socket.acceptAddr(client, address)
    echo("Client connected from: ", address)

var thread: Thread[void]
createThread[void](thread, server)

app.init()



var window = newWindow("Epic")
window.width = 600.scaleToDpi
window.height = 600.scaleToDpi

var container = newLayoutContainer(Layout_Vertical)
window.add(container)

# Add a Button control:
var button = newButton("Button")
container.add(button)

# Add a Checkbox control:
var checkbox = newCheckbox("Checkbox")
container.add(checkbox)

# Add a Label control:
var label = newLabel("Label")
container.add(label)

# Add a Progress Bar control:
var progressBar = newProgressBar()
progressBar.value = 0.5
container.add(progressBar)

# Add a TextBox control:
var textBox = newTextBox("TextBox")
container.add(textBox)

# Add a TextArea control:
var textArea = newTextArea("TextArea\pLine 2\p")
container.add(textArea)

# Add click event to the button:
button.onClick = proc(event: ClickEvent) =
  let client = newSocket()
  client.connect("127.0.0.1", Port(1234))
  progressBar.value = progressBar.value + 0.1
  textArea.addLine("Button clicked")

window.show()

app.run()
joinThread(thread)