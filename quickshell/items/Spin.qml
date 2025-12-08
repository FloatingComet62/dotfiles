import QtQuick
import QtQuick.Layouts

RowLayout {
  spacing: 0
  Text {
    text: " Spin:"
    color: shellRoot.white
    font {
      family: shellRoot.fontFamily
      pixelSize: shellRoot.fontSize
    }
  }
  Text {
    property var formatMode: "HH:mm:ss"

    id: clock
    text: Qt.formatDateTime(new Date(), clock.formatMode)
    color: shellRoot.purple
    font {
      family: shellRoot.fontFamily
      pixelSize: shellRoot.fontSize
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
