
import QtQuick 2.12
import QtQuick.Controls 2.15

import QtQuick.Layouts 1.0

import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents

import org.kde.kirigami as Kirigami

import org.kde.draganddrop 2.0

AppGridView {
    property QtObject recentAppsModel: rootModel.modelForRow(0);
    showScrollBar: false

    model: main.pinnedModel == 0 ? globalFavorites : recentAppsModel

    Component.onCompleted: {
        recentAppsModel = rootModel.modelForRow(0);
    }
}