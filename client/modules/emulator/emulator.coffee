app = angular.module "nescoffee"

app.factory "emulator", ($rootScope, $state) ->
    emulator = new NESCoffee
    emulator.useDefaultControls()
    emulator

app.controller "EmulatorController", ($scope, emulator) ->
    $scope.$on "$stateChangeStart", ->
        emulator.stop()

    $scope.$on "$stateChangeSuccess", ->
        emulator.setVideoOutput $("#video-output")[0]
        $("#file-upload").on "change", (event) ->
            document.activeElement.blur()
            event.preventDefault()
            event.stopPropagation()
            emulator.loadCartridge event.target.files[0]
        $("#file-drop").on "dragover", (event) ->
            event.preventDefault()
            event.stopPropagation()
            event.dataTransfer.dropEffect = "copy"
        $("#file-drop").on "drop", (event) ->
            event.preventDefault()
            event.stopPropagation()
            emulator.loadCartridge event.dataTransfer.files[0]

    emulator.onError = (error) ->
        $scope.error = error
        emulator.stop()

    emulator.onLoad = ->
        $scope.error = null
        emulator.start()

    $scope.clearError = ->
        $scope.error = null

app.controller "ToolbarController", ($scope, emulator) ->
    $scope.isRunning = ->
        emulator.isRunning()

    $scope.startEmulator = ->
        emulator.start()

    $scope.stopEmulator = ->
        emulator.stop()

    $scope.pressPower = ->
        emulator.pressPower()

    $scope.pressReset = ->
        emulator.pressReset()

    $scope.decreaseSize = ->
        emulator.decreaseVideoScale()

    $scope.increaseSize = ->
        emulator.increaseVideoScale()

    $scope.enterFullScreen = ->
        emulator.enterFullScreen()

    $scope.getFPS = ->
        ~~emulator.getFPS()

    refreshScope = -> $scope.$apply()
    setInterval refreshScope, 1000
