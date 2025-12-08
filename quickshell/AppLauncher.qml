import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io

Rectangle {
    id: appLauncher
    
    width: 400
    height: 600
    color: shellRoot.black
    radius: 16
    border.width: 3
    border.color: shellRoot.blue
    antialiasing: true
    
    property bool isVisible: false
    property int selectedIndex: -1
    property int hoverIndex: -1
    
    signal requestClose()
    
    focus: true
    
    Keys.onEscapePressed: requestClose()
    
    Keys.onUpPressed: {
        hoverIndex = -1
        if (selectedIndex === -1) {
            selectedIndex = appListModel.count - 1
        } else if (selectedIndex > 0) {
            selectedIndex--
        }
        listView.positionViewAtIndex(selectedIndex, ListView.Contain)
    }
    
    Keys.onDownPressed: {
        hoverIndex = -1
        if (selectedIndex === -1) {
            selectedIndex = 0
        } else if (selectedIndex < appListModel.count - 1) {
            selectedIndex++
        }
        listView.positionViewAtIndex(selectedIndex, ListView.Contain)
    }
    
    Keys.onReturnPressed: {
        if (selectedIndex >= 0 && selectedIndex < appListModel.count) {
            launchApp(appListModel.get(selectedIndex).appCommand)
        }
    }
    
    Keys.onEnterPressed: {
        if (selectedIndex >= 0 && selectedIndex < appListModel.count) {
            launchApp(appListModel.get(selectedIndex).appCommand)
        }
    }
    
    // Reset selection when widget becomes visible
    onIsVisibleChanged: {
        if (isVisible) {
            selectedIndex = -1  // Start with nothing selected
            hoverIndex = -1  // Reset hover on open
            appLauncher.forceActiveFocus()
            // Reload apps every time the launcher opens
            loadApps()
        }
    }
    
    // Process to load apps
    Process {
        id: appLoader
        running: false  // Don't auto-start, we'll trigger it manually
        command: ["sh", "-c", "~/.config/quickshell/scripts/list-apps.sh"]
        
        stdout: SplitParser {
            onRead: data => {
                const lines = data.split('\n')
                for (const line of lines) {
                    if (line.trim().length === 0) continue
                    
                    const parts = line.split('|')
                    if (parts.length >= 4) {
                        appListModel.append({
                            appName: parts[0],
                            appDescription: parts[1],
                            appIcon: parts[2],
                            appCommand: parts[3]
                        })
                    }
                }
                console.log("Loaded", appListModel.count, "applications")
            }
        }
        
        onRunningChanged: {
            // When process finishes, reset it for next run
            if (!running) {
                appLoader.running = false
            }
        }
    }
    
    // Function to load/reload applications
    function loadApps() {
        // Clear existing apps
        appListModel.clear()
        // Start the process to reload
        appLoader.running = true
    }
    
    // Load apps initially when component is created
    Component.onCompleted: {
        loadApps()
    }
    
    Column {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 8
        
        // Header
        Rectangle {
            width: parent.width
            height: 36
            color: "transparent"
            
            Text {
                anchors.centerIn: parent
                text: "Applications"
                font.family: shellRoot.fontFamily
                font.pixelSize: 14
                font.weight: Font.Medium
                color: shellRoot.white
            }
            
            // Close button
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
                    color: closeMouseArea.containsMouse ? shellRoot.red : shellRoot.orange
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
        
        // Apps list
        ListView {
            id: listView
            width: parent.width
            height: parent.height - 44
            spacing: 8
            clip: true
            
            model: ListModel {
                id: appListModel
                // Apps will be loaded dynamically from the script
            }
            
            delegate: Rectangle {
                width: listView.width
                height: 30
                color: {
                    if (appLauncher.hoverIndex === index) return shellRoot.lightgray
                    if (appLauncher.hoverIndex === -1 && index === shellRoot.selectedIndex) return shellRoot.lightgray
                    return shellRoot.gray
                }
                radius: 12
                border.width: 2
                border.color: {
                    if (appLauncher.hoverIndex === index || (shellRoot.hoverIndex === -1 && index === shellRoot.selectedIndex)) return shellRoot.blue
                    return "transparent"
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
                            if (appLauncher.hoverIndex === index) return shellRoot.blue
                            if (appLauncher.hoverIndex === -1 && index === shellRoot.selectedIndex) return shellRoot.blue
                            return shellRoot.purple
                        }
                        elide: Text.ElideRight
                    }
                }
                
                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    
                    onEntered: {
                        appLauncher.hoverIndex = index
                    }
                    onExited: {
                        appLauncher.hoverIndex = -1
                    }
                    
                    onClicked: {
                        launchApp(model.appCommand)
                    }
                }
            }
        }
    }
    
    function launchApp(command) {
        console.log("Launching app:", command)
        // Close the launcher first
        appLauncher.requestClose()
        
        // Use a small delay before launching to ensure the window closes properly
        Qt.callLater(() => {
            Quickshell.execDetached(["sh", "-c", command + " &"])
        })
    }
}
