import QtQuick
import QtQuick.Layouts

RowLayout {
  spacing: 0
  Text {
    text: " Waves:"
    color: shellRoot.white
    font {
      family: shellRoot.fontFamily
      pixelSize: shellRoot.fontSize
    }
  }
  Text {
    text: volume
    color: shellRoot.green
    font {
      family: shellRoot.fontFamily
      pixelSize: shellRoot.fontSize
      bold: true
    }
  }
}
