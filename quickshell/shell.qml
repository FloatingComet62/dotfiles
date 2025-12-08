import "./items"
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

ShellRoot {
  id: shellRoot

  property int redBatteryPoint: 15
  property int orangeBatteryPoint: 30

  property color black: "#000000"
  property color gray: "#202020"
  property color lightgray: "#404040"
  property color white: "#ffffff"
  property color green: "#28CD41"
  property color red: "#FF4040"
  property color orange: "#FFA500"
  property color purple: "#BF00FF"
  property color blue: "#00FFFF"
  property string fontFamily: "JetBrainsMono Nerd Font"
  property int fontSize: 18

  property bool appLauncherVisible: false

  // focus: true
  // Keys.onPressed: (event) => {
  //   if (event.key === Qt.Key_R && event.modifiers & Qt.MetaModifier) {
  //     Quickshell.execDetached(["notify-send", "ok"])
  //     appLauncherVisible = true;
  //   }
  // }
  // Component.onCompleted: {
  //   Hyprland.rawSignals = true;
  // }
  // Connections {
  //   target: Hyprland
  //
  //   function onEvent(sig) {
  //     Quickshell.execDetached(["notify-send", "ok"])
  //     console.log("Raw = ", sig);
  //   }
  // }
  GlobalShortcut {
    id: launcherShortcut
    name: "toggleLauncher"
    onPressed: {
      appLauncherVisible = true
    }
  }

  Variants {
    model: Quickshell.screens
    PanelWindow {
      id: root

      property int cpuUsage: 0
      property int lastCpuTotal: 0
      property int lastCpuIdle: 0
      property int memUsage: 0
      property int cpu_temperature: 6000
      property int brightness: 100
      property int temperature: 6000
      property int volume: 12
      property int battery: 12
      property string wifiName: "Offline"

      Procs {}
      Process {
        id: networkManagerProc
        command: ["foot", "-e", "nmtui"]
        Component.onCompleted: running = false
      }

      anchors.top: true
      anchors.left: true
      anchors.right: true
      implicitHeight: 32
      color: shellRoot.black

      RowLayout {
        anchors.fill: parent
        anchors.margins: 0
        anchors.leftMargin: 10
        anchors.rightMargin: 10

        Workspace {}
        Item { Layout.fillWidth: true }
        Radio {}
        Electrons {}
        Waves {}
        Photons {}
        Radiation {}
        DataBus {}
        Latch {}
        Spin {}
      }

      PanelWindow {
        id: apps

        anchors.top: true
        anchors.right: true
        anchors.bottom: true
        implicitWidth: 32
        color: shellRoot.black

        ColumnLayout {
          IconButton {
            icon: ""
            tooltip: "Firefox"
            onClicked: Quickshell.execDetached(["firefox"])
          }
          IconButton {
            icon: ""
            tooltip: "Dolphin"
            onClicked: Quickshell.execDetached(["dolphin"])
          }
          IconButton {
            icon: ""
            tooltip: "Vscode"
            onClicked: Quickshell.execDetached(["code"])
          }
          IconButton {
            icon: ""
            tooltip: "Localsend"
            onClicked: Quickshell.execDetached(["localsend_app"])
          }
          IconButton {
            icon: ""
            tooltip: "Bitwarden"
            onClicked: Quickshell.execDetached(["bitwarden"])
          }
          IconButton {
            icon: ""
            tooltip: "GIMP"
            onClicked: Quickshell.execDetached(["gimp"])
          }
          IconButton {
            icon: "󰠮"
            tooltip: "Obsidian"
            onClicked: Quickshell.execDetached(["obsidian"])
          }
          IconButton {
            icon: ""
            tooltip: "Discord"
            onClicked: Quickshell.execDetached(["discord"])
          }
          IconButton {
            icon: "󰕼"
            tooltip: "VLC"
            onClicked: Quickshell.execDetached(["vlc"])
          }
        }
      }
    }
  }
  Variants {
    model: Quickshell.screens
    
    PanelWindow {
      visible: shellRoot.appLauncherVisible
      
      anchors {
        top: true
        left: true
      }
      
      margins {
        top: Screen.height/2 - 300
        left: Screen.width/2 - 200
      }
      
      implicitWidth: 400
      implicitHeight: 600
      
      color: "transparent"
      exclusiveZone: 0
      
      WlrLayershell.layer: WlrLayer.Overlay
      WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
      
      Behavior on height {
        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
      }
      
      AppLauncher {
        anchors.fill: parent
        isVisible: shellRoot.appLauncherVisible
        
        onRequestClose: {
          shellRoot.appLauncherVisible = false
        }
      }
    }
  }
}
