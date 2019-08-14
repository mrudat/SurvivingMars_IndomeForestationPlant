local orig_print = print
if Mods.mrudat_TestingMods then
  print = orig_print
else
  print = empty_func
end

local CurrentModId = rawget(_G, 'CurrentModId') or rawget(_G, 'CurrentModId_X')
local CurrentModDef = rawget(_G, 'CurrentModDef') or rawget(_G, 'CurrentModDef_X')
if not CurrentModId then

  -- copied shamelessly from Expanded Cheat Menu
  local Mods, rawset = Mods, rawset
  for id, mod in pairs(Mods) do
    rawset(mod.env, "CurrentModId_X", id)
    rawset(mod.env, "CurrentModDef_X", mod)
  end

  CurrentModId = CurrentModId_X
  CurrentModDef = CurrentModDef_X
end

orig_print("loading", CurrentModId, "-", CurrentModDef.title)

-- unforbid ForestationPlants from being built inside.
mrudat_AllowBuildingInDome.forbidden_template_classes.ForestationPlant = nil

local wrap_method = mrudat_AllowBuildingInDome.wrap_method

mrudat_AllowBuildingInDome.DomePosOrMyPos('ForestationPlant')

local prop_cache = {}

wrap_method('ForestationPlant', 'GetPropertyMetadata', function(self, orig_method, prop_name)
  if prop_name ~= "UIRange" then
    return orig_method(self, prop_name)
  end

  local dome = self.parent_dome
  if not dome then
    return orig_method(self, prop_name)
  end

  local prop = prop_cache[dome]

  if prop then return prop end

  prop = orig_method(self, prop_name)
  prop = table.copy(prop)

  local dome_radius = HexShapeRadius(dome:GetInteriorShape())

  local dome_work_radius = dome:GetOutsideWorkplacesDist()

  prop.base = prop.min
  prop.min = Max(dome_radius + 1, prop.min)
  prop.max = Max(prop.max, dome_work_radius)
  prop.default = prop.max

  prop_cache[dome] = prop
  print(prop)
  return prop
end)

wrap_method('ForestationPlant', 'GetPlantHexes', function(self, orig_method, prop_name)
  local dome = self.parent_dome
  if not dome then
    return orig_method(self)
  end

  local plant_hexes = self.plant_hexes

  if self.range_prev ~= self.UIRange then
    plant_hexes = false
    self.range_prev = self.UIRange
  end

  if plant_hexes then
    return plant_hexes
  end

  plant_hexes = GetHexesInCircle(dome, self:GetForestationRange())

  self.plant_hexes = plant_hexes

  return plant_hexes
end)

orig_print("loaded", CurrentModId, "-", CurrentModDef.title)
