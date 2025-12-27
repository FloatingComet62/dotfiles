import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

Rectangle {
  id: batteryModeConfigRect
  
  width: 200
  height: 50
  Layout.fillWidth: true
  Layout.fillHeight: true
  color: shellRoot.black
  antialiasing: true
  bottomLeftRadius: 10
  bottomRightRadius: 10
  property int current: 1

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
    command: ["sh", "-c", "powerprofilesctl get"]

    stdout: SplitParser {
      onRead: data => {
        const p = data.trim();
        if (p == "power-saver") current = 0;
        else if (p == "balanced") current = 1;
        else if (p == "performance") current = 2;
        else current = 3;
      }
    }
    Component.onCompleted: running = true
  }

  Process {
    id: saverProc
    command: ["sh", "-c", "powerprofilesctl set power-saver"]
    Component.onCompleted: running = false
  }
  Process {
    id: balancedProc
    command: ["sh", "-c", "powerprofilesctl set balanced"]
    Component.onCompleted: running = false
  }
  Process {
    id: perfProc
    command: ["sh", "-c", "powerprofilesctl set performance"]
    Component.onCompleted: running = false
  }

  RowLayout {
    anchors.centerIn: parent
    spacing: 40
    Text {
      text: "󰌪"
      font.family: shellRoot.fontFamily
      font.pixelSize: batteryModeConfigRect.current == 0 ? 40 : 20
      font.weight: Font.Medium
      color: batteryModeConfigRect.current == 0 ? shellRoot.green : shellRoot.white
      MouseArea {
        anchors.fill: parent
        onClicked: {
          saverProc.running = true;
          current = 0;
        }
      }
    }
    Text {
      text: ""
      font.family: shellRoot.fontFamily
      font.pixelSize: batteryModeConfigRect.current == 1 ? 40 : 20
      font.weight: Font.Medium
      color: batteryModeConfigRect.current == 1 ? shellRoot.green : shellRoot.white
      MouseArea {
        anchors.fill: parent
        onClicked: {
          balancedProc.running = true;
          current = 1;
        }
      }
    }
    Text {
      text: "󰠠"
      font.family: shellRoot.fontFamily
      font.pixelSize: batteryModeConfigRect.current == 2 ? 40 : 20
      font.weight: Font.Medium
      color: batteryModeConfigRect.current == 2 ? shellRoot.green : shellRoot.white
      MouseArea {
        anchors.fill: parent
        onClicked: {
          perfProc.running = true;
          current = 2;
        }
      }
    }
  }
}
