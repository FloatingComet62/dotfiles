import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

Rectangle {
  id: batteryInfoRect
  
  width: 300
  height: 120
  Layout.fillWidth: true
  Layout.fillHeight: true
  color: shellRoot.black
  antialiasing: true
  topLeftRadius: 10
  topRightRadius: 10
  property var energy: ""
  property var voltage: ""
  property var capacity: ""

  Timer {
    interval: 0
    running: true
    repeat: false
    onTriggered: {
      fetchProc.running = true;
    }
  }

  signal requestClose()
  focus: true
  Keys.onEscapePressed: requestClose()

  Process {
    id: fetchProc
    command: ["sh", "-c", "~/.config/quickshell/scripts/battery-info.sh"]

    stdout: SplitParser {
      onRead: data => {
        if (data.includes("energy")) {
          energy = data.split(":")[1]
          return
        }
        if (data.includes("voltage")) {
          voltage = data.split(":")[1]
          return
        }
        if (data.includes("capacity")) {
          capacity = data.split(":")[1]
          return
        }
      }

    }
    Component.onCompleted: running = true
  }

  RowLayout {
    anchors.centerIn: parent
    ColumnLayout {
      anchors.left: parent
      Text {
        text: "Energy"
        font.family: shellRoot.fontFamily
        font.pixelSize: 20
        font.weight: Font.Medium
        color: shellRoot.green
        MouseArea {
          anchors.fill: parent
          onClicked: {
          }
        }
      }
      Text {
        text: "Capacity"
        font.family: shellRoot.fontFamily
        font.pixelSize: 20
        font.weight: Font.Medium
        color: shellRoot.green
        MouseArea {
          anchors.fill: parent
          onClicked: {
          }
        }
      }
      Text {
        text: "Voltage" 
        font.family: shellRoot.fontFamily
        font.pixelSize: 20
        font.weight: Font.Medium
        color: shellRoot.green
        MouseArea {
          anchors.fill: parent
          onClicked: {
          }
        }
      }
    }
    ColumnLayout {
      anchors.right: parent
      Text {
        text: energy
        font.family: shellRoot.fontFamily
        font.pixelSize: 20
        font.weight: Font.Medium
        color: shellRoot.white
        MouseArea {
          anchors.fill: parent
          onClicked: {
          }
        }
      }
      Text {
        text: capacity
        font.family: shellRoot.fontFamily
        font.pixelSize: 20
        font.weight: Font.Medium
        color: shellRoot.white
        MouseArea {
          anchors.fill: parent
          onClicked: {
          }
        }
      }
      Text {
        text: voltage 
        font.family: shellRoot.fontFamily
        font.pixelSize: 20
        font.weight: Font.Medium
        color: shellRoot.white
        MouseArea {
          anchors.fill: parent
          onClicked: {
          }
        }
      }
    }
  }
}
