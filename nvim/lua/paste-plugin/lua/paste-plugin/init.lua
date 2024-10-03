-- Imports the plugin's additional Lua modules.
local md = require("paste-plugin.md-paste")
local typst = require("paste-plugin.typst-paste")

-- Creates an object for the module. All of the module's
-- functions are associated with this object, which is
-- returned when the module is called with `require`.
local M = {}

-- Routes calls made to this module to functions in the
-- plugin's other modules.
M.insert_md = md.insert_image_md
M.insert_typst = typst.insert_image_typst

return M
    
