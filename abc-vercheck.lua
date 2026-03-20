incompatibilityCond = false
local messages = {}

VERSION_REQUIRED = 41
CS_VERSION_REQUIRED = 16

if VERSION_NUMBER < VERSION_REQUIRED then
	table.insert(messages, "\\#D9D9D9\\\n\"[CS] \\#FF79AA\\Kirby \\#FFFF3C\\Deluxe!\\#D9D9D9\\\"\nRequires the latest version of\n\"SM64 Co-op DX\"!\n\nPlease update the Executable\nand Host a new Room!\\#FF7F7F\\\nVersion " .. tostring(VERSION_NUMBER) .. " < " .. tostring(VERSION_REQUIRED))
	incompatibilityCond = true
end

local csVersion = _G.charSelect and _G.charSelect.version_get_full()
if not _G.charSelectExists then
	table.insert(messages, "\\#D9D9D9\\\n\"[CS] \\#FF79AA\\Kirby \\#FFFF3C\\Deluxe!\\#D9D9D9\\\"\nRequires \"Character Select\"\nto use as a Library!\n\nPlease turn on \"Character Select\"\nand Restart the Room!")
	incompatibilityCond = true
elseif csVersion and csVersion.api == 1 and csVersion.major < CS_VERSION_REQUIRED then
	local verBase = tostring(csVersion.api) .. "." .. tostring(csVersion.major) .. "." .. tostring(csVersion.minor)
	local verWanted = "1." .. tostring(CS_VERSION_REQUIRED) .. ".0"
	table.insert(messages, "\\#D9D9D9\\\n\"[CS] \\#FF79AA\\Kirby \\#FFFF3C\\Deluxe!\\#D9D9D9\\\"\nRequires the latest version of \"Character Select\"!\n\nPlease update the Mod\nand Host a new Room!\\#FF7F7F\\\nVersion " .. verBase .. " < " .. verWanted)
	incompatibilityCond = true
end

if incompatibilityCond then
    local frameCount = 0
    hook_event(HOOK_UPDATE, function ()
        frameCount = frameCount + 1
        if frameCount == 5 then
			for i = 1, #messages do
				message = messages[i]
				djui_popup_create(message, 6)
			end
        end
    end)
	return 0
end

--if incompatibilityCond then return 0 end
