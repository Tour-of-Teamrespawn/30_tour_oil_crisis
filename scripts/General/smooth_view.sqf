//Smooth View Distance Changer by Trit
//v1.01

//Distance to change to
_vDistance = _this select 0;

//Incremental amount to change by
_changeBy = _this select 1;

//Delay in seconds between changes
_changeDelay = _this select 2;

//Time in seconds to delay start of change
_delay = _this select 3;

//Do not change anything below this line unless you know what you are doing

sleep _delay;
_curViewDis = viewDistance;
if (_curViewDis != _vDistance) then
{
 if (_curViewDis < _vDistance) then
 {
  while {_curViewDis < _vDistance} do
  {
   if ((_vDistance-_curViewDis)<_changeBy) then
   {
    _changeBy=_vDistance-_curViewDis;
   };
   _curViewDis=_curViewDis+_changeBy;
   setViewDistance _curViewDis;
   sleep _changeDelay;
  };
 }
 else
 {
  while {_curViewDis > _vDistance} do
  {
   if ((_curViewDis-_vDistance)<_changeBy) then
   {
    _changeBy=_curViewDis-_vDistance;
   };
   _curViewDis=_curViewDis-_changeBy;
   setViewDistance _curViewDis;
   sleep _changeDelay;
  };
 };
};