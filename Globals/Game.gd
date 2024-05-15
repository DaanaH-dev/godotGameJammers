extends Node

#These are the variables that deterimnes the default time that character
#has until the lights die around the player
const DEFAULTLIGHTTIME := 15.0
#lightTime is not a true repersentation of how much time has elapsed, it will
#stop decrementing once the final size of the light is reached
var lightTime := DEFAULTLIGHTTIME


const DEFAULTTIMETODIE := 10.0
var timeToDie := DEFAULTTIMETODIE


var currentScene

