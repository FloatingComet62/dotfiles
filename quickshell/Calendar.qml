import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

Rectangle {
  id: calendarRoot
  
  color: shellRoot.black
  antialiasing: true
  focus: true
  
  property bool isVisible: false
  property int monthOffset: 0
  
  signal requestClose()
  Keys.onEscapePressed: {
    monthOffset = 0;
    requestClose()
  }
  
  Column {
    anchors.fill: parent
    spacing: 1
    Rectangle {
      width: parent.width
      height: parent.height
      color: shellRoot.black
      
      Column {
        anchors.fill: parent
        anchors.margins: 5
        spacing: 6

        RowLayout {
          width: parent.width
          Text {
            text: " <"
            font.pixelSize: 20
            font.family: shellRoot.fontFamily
            color: shellRoot.white
            MouseArea {
              anchors.fill: parent
              onClicked: monthOffset--;
            }
          }
          Item { Layout.fillWidth: true }
          Text {
            text: {
              const now = new Date()
              const monthNames = ["January", "February", "March", "April", "May", "June",
              "July", "August", "September", "October", "November", "December"]
              let shiftedMonth = now.getMonth() + monthOffset;
              let year = now.getFullYear();
              year += Math.floor(shiftedMonth / 12);
              shiftedMonth %= 12;
              return monthNames[shiftedMonth] + " " + year
            }
            font.family: shellRoot.fontFamily
            font.pixelSize: 20
            font.weight: Font.Medium
            color: shellRoot.white
            horizontalAlignment: Text.AlignHCenter
          }
          Item { Layout.fillWidth: true }
          Text {
            text: "> "
            font.pixelSize: 20
            font.family: shellRoot.fontFamily
            color: shellRoot.white
            MouseArea {
              anchors.fill: parent
              onClicked: monthOffset++;
            }
          }
        }
        Grid {
          width: parent.width
          columns: 7
          columnSpacing: 1
          rowSpacing: 1
       
          Repeater {
            model: ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
            
            Text {
              text: modelData
              font.family: shellRoot.fontFamily
              font.pixelSize: 15
              font.weight: Font.Medium
              color: shellRoot.white
              width: 50
              height: 20
              horizontalAlignment: Text.AlignHCenter
              verticalAlignment: Text.AlignVCenter
            }
          }
          Repeater {
            model: 35
            
            Rectangle {
              width: 60
              height: 60
              
              property var now: new Date()
              property int currentDay: now.getDate()
              property int currentMonth: (now.getMonth() + monthOffset) % 12
              property int currentYear: now.getFullYear() + Math.floor((now.getMonth() + monthOffset) / 12)
              
              // Calculate what day this cell represents
              property var firstDay: new Date(currentYear, currentMonth, 1)
              property int startOffset: firstDay.getDay()  // 0 = Sunday
              property int dayNumber: index - startOffset + 1
              property var lastDay: new Date(currentYear, currentMonth + 1, 0)
              property int daysInMonth: lastDay.getDate()
              property bool isCurrentDay: dayNumber === currentDay
              property bool isValidDay: dayNumber >= 1 && dayNumber <= daysInMonth
              
              color: {
                if (!isValidDay) return "transparent"
                if (monthOffset == 0 && isCurrentDay) return shellRoot.green
                return shellRoot.gray
              }
              
              Text {
                anchors.centerIn: parent
                text: parent.isValidDay ? parent.dayNumber : ""
                font.family: shellRoot.fontFamily
                font.pixelSize: 20
                color: {
                  if (parent.isValidDay && parent.isCurrentDay) return shellRoot.white
                  if (!parent.isValidDay) return shellRoot.white
                  return shellRoot.white
                }
                font.weight: parent.isValidDay && parent.isCurrentDay ? Font.DemiBold : Font.Normal
              }
            }
          }
        }
      }
    }
  }
}
