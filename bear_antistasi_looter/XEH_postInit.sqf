private _action = [
    "bear_antistasi_looter_transferAction", "Transfer Loot to Vehicle", "a3\ui_f\data\IGUI\Cfg\Actions\loadVehicle_ca.paa",
    {
        params ["_target", "_player"];
        
        (nearestObjects [_player, ace_cargo_cargoHolderTypes, 20]) select {
            (_x != _target) && {([_target, _x] call ace_interaction_fnc_getInteractionDistance) < 20}
        } params [["_nearestVehicle", objNull]];
        
        if (isNull _nearestVehicle) then {
            systemChat "Looter: Error: couldn't find any nearby vehicle";
        } else {
            systemChat "Looter: Using nearest vehicle";
            [_target, _nearestVehicle] call bear_antistasi_looter_fnc_transferToVehicle;
        };
    },
    {
        (_target isKindOf "WeaponHolderSimulated" || _target isKindOf "WeaponHolder" || !alive _target || typeOf _target == "Box_IND_Wps_F") &&
        {!(_target getVariable ["bear_antistasi_looter", false])} &&
        {[_player, _target] call ace_common_fnc_canInteractWith} &&
        {
            0 < {
                (_x != _target) && {([_target, _x] call ace_interaction_fnc_getInteractionDistance) < 20}
            } count (nearestObjects [_player, ace_cargo_cargoHolderTypes, 20])
        }
    },
    {
        private _statement = {
            params ["_target", "_player", "_vehicle"];
            [_target, _vehicle] call bear_antistasi_looter_fnc_transferToVehicle;
        };
        
        private _vehicles = (nearestObjects [_target, ace_cargo_cargoHolderTypes, 25]) select {
            (_x != _target) && {([_target, _x] call ace_interaction_fnc_getInteractionDistance) < 20}
        };

        [_vehicles, _statement, _target] call ace_interact_menu_fnc_createVehiclesActions;
    }
] call ace_interact_menu_fnc_createAction;

["CAManBase", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;
["WeaponHolder", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;
["WeaponHolderSimulated", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;
["Box_IND_Wps_F", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;