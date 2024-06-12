local font = {}
local love = require("love")

function font.load_font()
	local font = love.graphics.newImageFont("art/font-white.png",
		" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789" .. 
		"!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~¡¢©ª´º¿÷ÀÁÂÃÄÈÉÊËÌÍÎÏÒÓÔÕÖÙÚÛÜ" ..
    "àáâãäèéêëìíîïòóôõöÑñÇç", -48)
	love.graphics.setFont(font)
end

return font
