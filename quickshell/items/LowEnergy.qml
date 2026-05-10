import QtQuick
import QtQuick.Layouts

RowLayout {
  spacing: 0
  Text {
    text: " Low Energy:"
    color: shellRoot.white
    font {
      family: shellRoot.fontFamily
      pixelSize: shellRoot.fontSize
    }
  }
  Text {
    text: bluetoothName
    color: bluetoothName == "Offline" ? shellRoot.red : shellRoot.green
    font {
      family: shellRoot.fontFamily
      pixelSize: shellRoot.fontSize
      bold: true
    }
  }
  MouseArea {
    anchors.fill: parent
    onClicked: bluetoothManagerProc.running = true
  }
}
