local PATH = (...):gsub('%.init$', '')

local Lovox = {
   newVoxelBatch = require(PATH..".voxelBatch"),
   newCamera     = require(PATH..".camera"    ),
   newTransform  = require(PATH..".transform" ),
}

local notSupported = false
do
   local supported = love.graphics.getSupported()

   if not supported.glsl3 then
      notSupported = "GLSL 3 shaders are not supported on this device"
   elseif not supported.instancing then
      notSupported = "Mesh instancing is not supported on this device"
   end

   local status = jit.status()
   if not status then
      notSupported = "FFI is not enabled"
   end
end

--- Checks if Lovox is supported on the system.
-- @returns boolean true if Lovox is supported. False otherwise.
function Lovox.isSupported()
   if notSupported then
      return false, notSupported
   end

   return true
end

return Lovox
