cmake_minimum_required(VERSION 3.16)

project(wayland-based-smart-tv VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick WaylandCompositor)
find_package(Qt6 REQUIRED COMPONENTS Core)
find_package(Qt6 REQUIRED COMPONENTS Core)
find_package(Qt6 REQUIRED COMPONENTS Core)

qt_standard_project_setup(REQUIRES 6.10)

qt_add_executable(appwayland-based-smart-tv
    src/main.cpp
)

qt_add_qml_module(appwayland-based-smart-tv
    URI wayland-based-smart-tv
    VERSION 1.0
    QML_FILES
        src/qml/Main.qml
        src/qml/HomeScreen.qml
        src/qml/WindowManager.qml
        src/qml/BrowserWindow.qml
        src/qml/dynamicUtils.js
        src/qml/Component/AppList.qml
        src/qml/Component/AppTile.qml
        src/qml/Component/SideBar.qml
        src/qml/Component/ToolBar.qml
    SOURCES
        src/headers/backend.h src/backend.cpp
        src/headers/webview.h src/webview.cpp

    QML_FILES src/qml/Component/Basics/ShadowRectangle.qml
    QML_FILES src/qml/Component/Clock.qml
    QML_FILES src/qml/Component/Date.qml
    RESOURCES rsc/sprite-animation/black-home-icon.png
    RESOURCES resources.qrc
    RESOURCES rsc/sprite-animation/white-home-icon.png
)



# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appwayland-based-smart-tv PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appwayland-based-smart-tv
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appwayland-based-smart-tv
    PRIVATE Qt6::Quick
    PRIVATE Qt6::WaylandCompositor
)
target_link_libraries(appwayland-based-smart-tv PRIVATE Qt6::Core)
target_link_libraries(appwayland-based-smart-tv PRIVATE Qt6::Core)
target_link_libraries(appwayland-based-smart-tv PRIVATE Qt6::Core)

include(GNUInstallDirs)
install(TARGETS appwayland-based-smart-tv
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
