/*
 * This file is automatically generated by Qt Design Studio.
 * Do not change.
*/

#include <QGuiApplication>
#include "qqmlextensionplugin.h"

Q_IMPORT_QML_PLUGIN(MiniTermProjectContentPlugin)
Q_IMPORT_QML_PLUGIN(MiniTermProjectPlugin)

const char mainQmlFile[] = "qrc:/qt/qml/MiniTermProjectContent/App.qml";

#ifdef BUILD_QDS_COMPONENTS

Q_IMPORT_QML_PLUGIN(QtQuick_Studio_ComponentsPlugin)
Q_IMPORT_QML_PLUGIN(QtQuick_Studio_EffectsPlugin)
Q_IMPORT_QML_PLUGIN(QtQuick_Studio_ApplicationPlugin)
Q_IMPORT_QML_PLUGIN(FlowViewPlugin)
Q_IMPORT_QML_PLUGIN(QtQuick_Studio_LogicHelperPlugin)
Q_IMPORT_QML_PLUGIN(QtQuick_Studio_MultiTextPlugin)
Q_IMPORT_QML_PLUGIN(QtQuick_Studio_EventSimulatorPlugin)
Q_IMPORT_QML_PLUGIN(QtQuick_Studio_EventSystemPlugin)

#endif

inline void set_qt_environment() {
	qputenv("QML_COMPAT_RESOLVE_URLS_ON_ASSIGNMENT", "1");
	qputenv("QT_AUTO_SCREEN_SCALE_FACTOR", "1");
	qputenv("QT_ENABLE_HIGHDPI_SCALING", "0");
	qputenv("QT_LOGGING_RULES", "qt.qml.connections=false");
	qputenv("QT_QUICK_CONTROLS_CONF", ":/qtquickcontrols2.conf");
}
