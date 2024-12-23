local monitorSide = "left"  -- Seite, an der der Monitor angeschlossen ist
local redstoneSide = "back" -- Seite, an der Redstone aktiviert werden soll
local buttonText = "Starterlaubnis anfragen"

local monitor = peripheral.wrap(monitorSide)
if not monitor then
    error("Kein Monitor an der Seite " .. monitorSide .. " gefunden!")
end

monitor.setTextScale(1)
monitor.clear()

local function drawButton()
    monitor.setBackgroundColor(colors.blue)
    monitor.clear()
    monitor.setTextColor(colors.white)
    
    local width, height = monitor.getSize()
    local buttonY = math.floor(height / 2)
    local buttonX = math.floor((width - #buttonText) / 2)
    
    monitor.setCursorPos(buttonX, buttonY)
    monitor.write(buttonText)
end

local function isButtonClicked(x, y)
    local width, height = monitor.getSize()
    local buttonY = math.floor(height / 2)
    local buttonXStart = math.floor((width - #buttonText) / 2)
    local buttonXEnd = buttonXStart + #buttonText - 1

    return y == buttonY and x >= buttonXStart and x <= buttonXEnd
end

-- Hauptprogramm
drawButton()

while true do
    local event, side, x, y = os.pullEvent("monitor_touch")
    if isButtonClicked(x, y) then
        -- Redstone-Signal aktivieren
        redstone.setOutput(redstoneSide, true)
        sleep(2)
        redstone.setOutput(redstoneSide, false)
        monitor.setCursorPos(1, 1)
        monitor.clear()
        monitor.write("Signal gesendet!")
        sleep(2)
        drawButton()
    end
end
