#!/bin/sh

echo "`awk -F '=' '/BUILD_VERSION/{$2=$2+1}1' OFS='=' .build-config`"  > .build-config
source .build-config
USER_AGENT="Yandex.Music for macOS Version ${APP_VERSION} (build ${BUILD_VERSION} / Nativefier ${NATIVEFIER_VERSION})"
echo "Building ${USER_AGENT}"

rm -rf ./build
mkdir ./build

nativefier \
  -p mac \
  --verbose \
  --app-version "${APP_VERSION}" \
  --build-version "${BUILD_VERSION}" \
  --user-agent "${USER_AGENT}" \
  --browserwindow-options '{ "fullscreenable": "true", "titleBarStyle": "hiddenInset", "transparent": true }' \
  --icon ./src/icon.icns \
  --inject ./src/inject.js \
  --inject ./src/inject.css \
  --fast-quit \
  --internal-urls 'music\.yandex\.ru' \
  --name Yandex.Music \
  https://music.yandex.ru/ ./build
