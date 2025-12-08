import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io

Rectangle {
  id: appLauncher
  
  width: 400
  height: 600
  color: shellRoot.black
  antialiasing: true
  
  property bool isVisible: false
  property int hoverIndex: 0
  property bool cleared: true
  
  signal requestClose()
  
  focus: true
  
  Keys.onEscapePressed: requestClose()
  
  Keys.onUpPressed: {
    hoverIndex--
    if (hoverIndex < 0) hoverIndex += appListModel.count
    listView.positionViewAtIndex(hoverIndex, ListView.Contain)
  }
  
  Keys.onDownPressed: {
    hoverIndex = (hoverIndex + 1) % appListModel.count
    listView.positionViewAtIndex(hoverIndex, ListView.Contain)
  }
  
  Keys.onReturnPressed: {
    if (hoverIndex >= 0 && hoverIndex < appListModel.count) {
      launchApp(appListModel.get(hoverIndex).appCommand)
    }
  }
  
  Keys.onEnterPressed: {
    if (hoverIndex >= 0 && hoverIndex < appListModel.count) {
      launchApp(appListModel.get(hoverIndex).appCommand)
    }
  }
  
  onIsVisibleChanged: {
    if (!isVisible) return;
    hoverIndex = -1
    appLauncher.forceActiveFocus()
    loadApps()
  }
  
  Process {
    id: appLoader
    running: false
    command: ["sh", "-c", "~/.config/quickshell/scripts/list-apps.sh"]
    
    stdout: SplitParser {
      onRead: data => {
        if (!cleared) {
          appListModel.clear()
          cleared = true;
        }

        const lines = data.split('\n')
        for (const line of lines) {
          if (line.trim().length === 0) continue
          
          const parts = line.split('|')
          if (parts.length < 4) continue;
          appListModel.append({
            appName: parts[0],
            appDescription: parts[1],
            appIcon: parts[2],
            appCommand: parts[3]
          })
        }
      }
    }
    
    onRunningChanged: {
      if (running) return;
      appLoader.running = false
    }
  }
  
  function loadApps() {
    cleared = false;
    appLoader.running = true
  }
  
  Component.onCompleted: {
    loadApps()
  }
  
  Column {
    anchors.fill: parent
    anchors.margins: 12
    spacing: 8
    
    Rectangle {
      width: parent.width
      height: 36
      color: "transparent"
      
      Text {
        anchors.centerIn: parent
        text: "Applications"
        font.family: shellRoot.fontFamily
        font.pixelSize: 20
        font.weight: Font.Medium
        color: shellRoot.white
      }
      
      Rectangle {
        width: 28
        height: 28
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        radius: 6
        color: closeMouseArea.containsMouse ? shellRoot.red : "transparent"
        
        Text {
          anchors.centerIn: parent
          text: "✕"
          font.family: shellRoot.fontFamily
          font.pixelSize: 16
          font.weight: Font.Bold
          color: closeMouseArea.containsMouse ? shellRoot.white : shellRoot.red
        }
        
        MouseArea {
          id: closeMouseArea
          anchors.fill: parent
          hoverEnabled: true
          cursorShape: Qt.PointingHandCursor
          onClicked: appLauncher.requestClose()
        }
      }
    }
    
    ListView {
      id: listView
      width: parent.width
      height: parent.height - 44
      spacing: 8
      clip: true
      
      model: ListModel {
        id: appListModel
      }
      
      delegate: Rectangle {
        width: listView.width
        height: 30
        color: {
          if (appLauncher.hoverIndex === index) return shellRoot.lightgray
          return shellRoot.gray
        }
        
        Row {
          anchors.fill: parent
          anchors.leftMargin: 12
          anchors.rightMargin: 12
          anchors.topMargin: 8
          anchors.bottomMargin: 8
          spacing: 12
          
          Text {
            width: parent.width - 62
            anchors.centerIn: parent
            text: model.appName
            font.family: shellRoot.fontFamily
            font.pixelSize: 14
            font.weight: Font.Medium
            color: {
              return shellRoot.white;
            }
            elide: Text.ElideRight
          }
        }
        
        MouseArea {
          id:ouseArea
          anchors.fill: parent
          hoverEnabled: true
          cursorShape: Qt.PointingHandCursor
          
          onEntered: {
            appLauncher.hoverIndex = index
          }
          
          onClicked: {
            launchApp(model.appCommand)
          }
        }
      }
    }
  }
  
  function launchApp(command) {
      appLauncher.requestClose()
      
      // Use a small delay before launching to ensure the window closes properly
      Qt.callLater(() => {
          Quickshell.execDetached(["sh", "-c", command + " &"])
      })
  }
}
