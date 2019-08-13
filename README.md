# LootToVehicle
Loot to Vehicle for ACE and Antistasi

Original by **Bear** - https://steamcommunity.com/sharedfiles/filedetails/?id=1439779114

Additional features added by **Ghosto27** - https://github.com/Ghosto27/LootToVehicle
```
• add looting action to white surrender crates 
• distance to vehicle increased from 15m to 20m
```
Personal changes

`functions\fn_transferToVehicle.sqf`

* changed `Box_T_East_Wps_F` to `Box_IND_Wps_F` based on Antistasi 1.4's `AI\surrenderAction.sqf`

`XEH_postInit.sqf`

* removed branding `1Tac Antistasi ` from action messages

* restructured Ghosto27's folder for easier PBO compiling
  - renamed directory `missions` to `bear_antistasi_looter` for consistency
  - removed `description.ext`
* no longer requires the original Loot to Vehicle by Bear