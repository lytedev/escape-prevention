conf = {}

function love.conf(t)
    t.title = "Escape Prevention"
    t.author = "Daniel \"lytedev\" Flanagan"
    t.url = "http://lytedev.com"
    t.identity = "EscapePrevention"
    t.version = "0.8.0"
    t.titleVersion = "Alpha 1.0"

    t.release = false
    t.console = not t.release

    t.screen.scaleHeight = 360 / 2
    t.screen.width = 640
    t.screen.height = 360
    t.screen.fullscreen = false
    t.screen.vsync = true
    t.screen.fsaa = 0

    t.modules.joystick = true
    t.modules.audio = true
    t.modules.keyboard = true
    t.modules.event = true
    t.modules.image = true
    t.modules.graphics = true
    t.modules.timer = true
    t.modules.mouse = true
    t.modules.sound = true
    t.modules.physics = true

    conf = t
end
