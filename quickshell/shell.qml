import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

PanelWindow {
  id: root

  property int redBatteryPoint: 15
  property int orangeBatteryPoint: 30

  property color black: "#000000"
  property color white: "#ffffff"
  property color green: "#28CD41"
  property color red: "#FF4040"
  property color orange: "#FFA500"
  property color purple: "#BF00FF"
  property color blue: "#00FFFF"
  property string fontFamily: "JetBrainsMono Nerd Font"
  property int fontSize: 18

  property int cpuUsage: 0
  property int lastCpuTotal: 0
  property int lastCpuIdle: 0

  Process {
    id: cpuProc
    command: ["sh", "-c", "head -1 /proc/stat"]

    stdout: SplitParser {
      onRead: data => {
        var p = data.trim().split(/\s+/)
        var idle = parseInt(p[4]) + parseInt(p[5])
        var total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0)
        if (lastCpuTotal > 0) {
          cpuUsage = Math.round(100 * (1 - (idle - lastCpuIdle) / (total - lastCpuTotal)))
        }
        lastCpuTotal = total
        lastCpuIdle = idle
      }
    }
    Component.onCompleted: running = true
  }

  property int memUsage: 0
  Process {
    id: memProc
    command: ["sh", "-c", "free | grep Mem"]
    stdout: SplitParser {
      onRead: data => {
        var parts = data.trim().split(/\s+/)
        var total = parseInt(parts[1]) || 1
        var used = parseInt(parts[2]) || 0
        memUsage = Math.round(100 * used / total)
      }
    }
    Component.onCompleted: running = true
  }

  property int brightness: 100
  property int temperature: 6000
  Process {
    id: brightnessProc
    command: ["sh", "-c", "~/.config/quickshell/brightness.sh"]
    stdout: SplitParser {
      onRead: data => {
        var parts = data.trim().split(/\s+/)
        brightness = parseInt(parts[0]) || 100
        temperature = parseInt(parts[1]) || 6000
      }
    }
    Component.onCompleted: running = true
  }

  property int volume: 12
  Process {
    id: volumeProc
    command: ["sh", "-c", "~/.config/quickshell/volume.sh"]
    stdout: SplitParser {
      onRead: data => {
        volume = parseInt(data.trim()) || 13;
      }
    }
    Component.onCompleted: running = true
  }

  property int battery: 12
  Process {
    id: batteryProc
    command: ["sh", "-c", "~/.config/quickshell/battery.sh"]
    stdout: SplitParser {
      onRead: data => {
        battery = parseInt(data.trim()) || 13;
      }
    }
    Component.onCompleted: running = true
  }

  property string wifiName: "Offline"
  Process {
    id: networkProc
    command: ["sh", "-c", "~/.config/quickshell/network.sh"]
    stdout: SplitParser {
      onRead: data => {
        var parts = data.trim().split(/\s+/)
        wifiName = parts[0];
      }
    }
    Component.onCompleted: running = true
  }

  Timer {
    interval: 2000
    running: true
    repeat: true
    onTriggered: {
      cpuProc.running = true
      memProc.running = true
      brightnessProc.running = true
      volumeProc.running = true
      batteryProc.running = true
      networkProc.running = true
    }
  }
  Process {
    id: networkManagerProc
    command: ["foot", "-e", "nmtui"]
    Component.onCompleted: running = false
  }

  anchors.top: true
  anchors.left: true
  anchors.right: true
  implicitHeight: 32
  color: root.black

  RowLayout {
    anchors.fill: parent
    anchors.margins: 0

    Repeater {
      model: 5

      Text {
        property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

        text: index + 1
        color: isActive ? root.green : root.white
        font {
          pixelSize: root.fontSize;
          bold: true;
        }

        MouseArea {
          anchors.fill: parent
          onClicked: Hyprland.dispatch("workspace " + (index + 1))
        }
      }
    }
    Item { Layout.fillWidth: true }
    RowLayout {
      spacing: 0
      Text {
        text: " Radio:"
        color: root.white
        font {
          family: root.fontFamily
          pixelSize: root.fontSize
        }
      }
      Text {
        text: wifiName
        color: wifiName == "Offline" ? root.red : root.green
        font {
          family: root.fontFamily
          pixelSize: root.fontSize
          bold: true
        }

        MouseArea {
          anchors.fill: parent
          onClicked: networkManagerProc.running = true
        }
      }
    }
    RowLayout {
      spacing: 0
      Text {
        text: " Electrons:"
        color: root.white
        font {
          family: root.fontFamily
          pixelSize: root.fontSize
        }
      }
      Text {
        text: battery
        color: (battery <= redBatteryPoint) ? root.red : ((battery <= orangeBatteryPoint) ? root.orange : root.green)
        font {
          family: root.fontFamily
          pixelSize: root.fontSize
          bold: true
        }
      }
    }
    RowLayout {
      spacing: 0
      Text {
        text: " Waves:"
        color: root.white
        font {
          family: root.fontFamily
          pixelSize: root.fontSize
        }
      }
      Text {
        text: volume
        color: root.green
        font {
          family: root.fontFamily
          pixelSize: root.fontSize
          bold: true
        }
      }
    }
    RowLayout {
      spacing: 0
      Text {
        text: " Photons:"
        color: root.white
        font {
          family: root.fontFamily
          pixelSize: root.fontSize
        }
      }
      Text {
        text: brightness
        color: root.orange
        font {
          family: root.fontFamily
          pixelSize: root.fontSize
          bold: true
        }
      }
      Text {
        text: "(" + temperature + "K)"
        color: root.red
        font {
          family: root.fontFamily
          pixelSize: root.fontSize
          bold: true
        }
      }
    }
    RowLayout {
      spacing: 0
      Text {
        text: " Radiation:"
        color: root.white
        font {
          family: root.fontFamily
          pixelSize: root.fontSize
        }
      }
      Text {
        text: cpuUsage + "K"
        color: root.orange
        font {
          family: root.fontFamily
          pixelSize: root.fontSize
          bold: true
        }
      }
    }
    RowLayout {
      spacing: 0
      Text {
        text: " Data Bus:"
        color: root.white
        font {
          family: root.fontFamily
          pixelSize: root.fontSize
        }
      }
      Text {
        text: cpuUsage
        color: root.orange
        font {
          family: root.fontFamily
          pixelSize: root.fontSize
          bold: true
        }
      }
    }
    RowLayout {
      spacing: 0
      Text {
        text: " Latch:"
        color: root.white
        font {
          family: root.fontFamily
          pixelSize: root.fontSize
        }
      }
      Text {
        text: memUsage
        color: root.orange
        font {
          family: root.fontFamily
          pixelSize: root.fontSize
          bold: true
        }
      }
    }
    RowLayout {
      spacing: 0
      Text {
        text: " Spin:"
        color: root.white
        font {
          family: root.fontFamily
          pixelSize: root.fontSize
        }
      }
      Text {
        property var formatMode: "HH:mm:ss"

        id: clock
        text: Qt.formatDateTime(new Date(), clock.formatMode)
        color: root.purple
        font {
          family: root.fontFamily
          pixelSize: root.fontSize
          bold: true
        }

        Timer {
          interval: 1000
          running: true
          repeat: true
          onTriggered: clock.text = Qt.formatDateTime(new Date(), clock.formatMode)
        }

        MouseArea {
          anchors.fill: parent
          onClicked: {
            if (clock.formatMode === "HH:mm:ss") {
              clock.formatMode = "yyyy/MM/dd, dddd"
            } else {
              clock.formatMode = "HH:mm:ss"
            }
            clock.text = Qt.formatDateTime(new Date(), clock.formatMode)
          }
        }
      }
    }
  }
}
