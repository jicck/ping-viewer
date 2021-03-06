import QtQuick 2.4
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
import Qt.labs.settings 1.0
import QtQuick.Controls.Material 2.1

import StyleManager 1.0

ApplicationWindow {
    id: window
    objectName: "window"
    title: createTitle()
    visible: true
    height: 600
    width: 800

    Material.theme: StyleManager.theme
    Material.primary: StyleManager.primaryColor
    Material.accent: Material.Blue
    Material.foreground: Material.Blue

    MainPage {
        id: mainPage
        anchors.fill: parent

        // Popups
        DeviceManagerViewer {
            id: deviceManagerViewer
            width: parent.width/2
            height: parent.height*0.9
            anchors.centerIn: parent
        }

        Ping360EthernetConfiguration {
            id: ping360EthernetConfiguration
            width: 300
            height: 280
            anchors.centerIn: parent
        }
    }

    Component.onCompleted: checkPosition()

    // Save windows position and size
    Settings {
        property alias x: window.x
        property alias y: window.y
        property alias width: window.width
        property alias height: window.height
    }

    function createTitle() {
        var applicationName = "Ping Viewer"

        var versionInfo = GitTag

        if (versionInfo === "") {
            versionInfo = GitVersion
        }

        var title = applicationName + " - " + versionInfo

        return  title
    }

    // Ensure that the application is inside the screen boundaries
    function checkPosition() {
        print(`Screen position: (${x},${y}, ${width}, ${height}) [0, 0, ${Screen.desktopAvailableWidth}, ${Screen.desktopAvailableHeight}]`)
        if(y < -height || x < -width ||
            y > Screen.desktopAvailableHeight || x > Screen.desktopAvailableWidth) {
            x = (Screen.desktopAvailableWidth - width)/2
            y = (Screen.desktopAvailableHeight - height)/2
        }
    }
}
