params ["_target", "_vehicle"];
    
private _items = [];
private _backpacks = [];
private _isMan = _target isKindOf "CAManBase";
private _targetTypeStr = ["ground", "body"] select _isMan;

systemChat format ["Looter: from %1 into %2", _targetTypeStr, getText (configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayname")];

if (_isMan) then {
    _items = magazines _target;
    _items append weapons _target;

    removeAllWeapons _target;
    
    private _backpack = backpack _target;
    if !(_backpack isEqualTo "") then {
        _backpacks pushBack _backpack;
        removeBackpackGlobal _target;
    };
    
    private _uniform = uniform _target;
    if !(_uniform isEqualTo "") then {
        if !(_target getVariable ["bear_antistasi_looter", false]) then {
            _items pushBack _uniform;
        };
        
        // removeUniform _target; // keep your pants on for muh immersions
    };
    private _vest = vest _target;
    if !(_vest isEqualTo "") then {
        _items pushBack _vest;
        removeVest _target;
    };
    private _headgear = headgear _target;
    if !(_headgear isEqualTo "") then {
        _items pushBack _headgear;
        removeHeadgear _target;
    };
    private _nvg = hmd _target;
    if !(_nvg isEqualTo "") then {
        _items pushBack _nvg;
        _target unlinkItem _nvg;
    };
    
    _target setVariable ["bear_antistasi_looter", true, true];
} else {
    _items = magazineCargo _target;
    _items append weaponCargo _target;
    _backpacks = backpackCargo _target;
    
    clearWeaponCargoGlobal _target;
    clearMagazineCargoGlobal _target;
    clearBackpackCargoGlobal _target;
};
    
    //get all box items
    private _boxStuff = ItemCargo _target;
    //delete box items
    clearItemCargoGlobal _target;
    //delete box
    if (typeOf _target == "Box_IND_Wps_F") then {
        deleteVehicle _target;
    };

    //add box items to vehicle
{
    _vehicle addItemCargoGlobal [_x, 1];
} forEach _boxStuff;

{
    _vehicle addItemCargoGlobal [_x, 1];
} forEach _items;

{
    _vehicle addBackpackCargoGlobal [_x, 1];
} forEach _backpacks;