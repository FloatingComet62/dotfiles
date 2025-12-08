import QtQuick

MouseArea {
    id: iconButton
    
    property string icon: ""
    property string tooltip: ""
    
    width: 32
    height: 32
    
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    enabled: true
    z: 10
    
    Rectangle {
        anchors.fill: parent
        color: "transparent"
        radius: 6
        
        Behavior on color {
            ColorAnimation { duration: 200 }
        }
        
        Text {
            id: iconText
            anchors.centerIn: parent
            text: iconButton.icon
            font.family: shellRoot.fontFamily
            font.pixelSize: 22
            color: shellRoot.white
            
            Component.onCompleted: {
                console.log("IconButton text:", iconButton.icon, "length:", iconButton.icon.length)
            }
        }
    }
    

}
