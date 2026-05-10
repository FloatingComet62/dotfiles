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
  property bool calendarVisible: false
  property bool batteryInfo: false
  property bool blink: false

  GlobalShortcut {
    id: launcherShortcut
    name: "toggleLauncher"
    onPressed: {
      appLauncherVisible = true
    }
  }
  GlobalShortcut {
    id: calendarShortcut
    name: "toggleCalendar"
    onPressed: {
      calendarVisible = true
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
      property bool volume_muted: false
      property int battery: 12
      property bool batteryCharging: false
      property string wifiName: "Offline"

      Procs {}
      Process {
        id: networkManagerProc
        command: ["foot", "-e", "nmtui"]
        Component.onCompleted: running = false
      }

      anchors.bottom: true
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
        top: 5
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

  Variants {
    model: Quickshell.screens
    
    PanelWindow {
      visible: shellRoot.calendarVisible
      
      anchors {
        top: true
        left: true
      }
      
      margins {
        top: 5
        left: Screen.width - 435 - 5
      }
      
      implicitWidth: 435
      implicitHeight: 370
      
      color: "transparent"
      exclusiveZone: 0
      
      WlrLayershell.layer: WlrLayer.Overlay
      WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
      
      Behavior on height {
        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
      }
      
      Calendar {
        anchors.fill: parent
        isVisible: shellRoot.calendarVisible
        
        onRequestClose: {
          shellRoot.calendarVisible = false
        }
      }
    }
  }

  Variants {
    model: Quickshell.screens
    
    PanelWindow {
      visible: shellRoot.batteryInfo
      
      anchors {
        bottom: true
        left: true
      }
      
      margins {
        top: 0
        left: Screen.width / 2 - 100
      }
      
      implicitWidth: 300
      implicitHeight: 120
      
      color: "transparent"
      exclusiveZone: 0

      WlrLayershell.layer: WlrLayer.Overlay
      WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
      
      Behavior on height {
        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
      }

      BatteryInfo {
        onRequestClose: {
          shellRoot.batteryInfo = false
        }
      }
    }
  }

  Timer {
    interval: 1000 * 60 * 30
    running: true
    repeat: true
    onTriggered: {
      shellRoot.blink = true;
    }
  }

  Variants {
    model: Quickshell.screens
    
    PanelWindow {
      visible: shellRoot.blink
      
      margins {
        top: 0
        left: 0
      }
      
      implicitWidth: 800
      implicitHeight: 400
      
      color: "transparent"
      exclusiveZone: 0
      
      WlrLayershell.layer: WlrLayer.Overlay
      WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
      
      Behavior on height {
        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
      }

      Rectangle {
        id: blinkRect
        
        width: 800
        height: 400
        Layout.fillWidth: true
        Layout.fillHeight: true
        color: shellRoot.black
        antialiasing: true
        radius: 10
        focus: true
        Keys.onEscapePressed: shellRoot.blink = false;

        Text {
          anchors.centerIn: parent
          text: "BLINK"
          font.family: shellRoot.fontFamily
          font.weight: 800
          font.pixelSize: 200
          color: shellRoot.white
        }
      }
    }
  }
}
