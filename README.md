# [CS] Kirby Deluxe!

Play as the pink puffball warrior with a moveset directly inspired by **Kirby and the Forgotten Land (2022)**, made to align within Kirby's N64 era!

This mod features:
* Copy abilities in the form of the base game's power-ups, with Copy Ability Essences replacing the cap models!
* Custom objects for the Air and Star bullets!
* Comes with both "Normal" and "Classic" costumes!
* A host-only configuration that allows Kirby to puff up infinitely, perfect for ROM-hacks!
* An API that allows modders to add objects for Kirby to inhale through LUA functions!

# Inhale API

To hook a custom object for Kirby to inhale, or if you want to edit an existing object, you first need to have its behavior ID, once you've obtained it, you can proceed with adding these functions:

## _G.kirbyInhaleHookBehavior
`_G.kirbyInhaleHookBehavior` allows the modder to hook a custom behavior for Kirby to inhale.

### Parameters

| Field | Type | Notes |
| ----- | ---- | ----- |
| id | `integer (BehaviorId)` | Behavior ID of the object to inhale. |
| canRotate | `bool`/`function` | Check to see if an object can rotate as its being inhaled, default is `true`. |
| canEat | `bool`/`function` | Check to see if an object can be removed once it reaches Kirby's mouth, default is `true`. |
| allowSuckFunc | `bool`/`function` | Special checks for special objects (I.E. Koopa the Quick), set `false` to stop the inhale, default is `true`. |
| deleteOnDetect | `bool` | Deletes an object if it's within Kirby's inhale range, default is `false`, set `true` to activate. |
| onEatFunc | `function?` | Special function that activates once the object's been deleted (I.E. add to Big Bully #2's condition once a bully has been eaten), default is `nil`. |

## _G.kirbyInhaleEditBehavior
`_G.kirbyInhaleEditBehavior` allows the modder to edit an existing behavior for Kirby to inhale.

### Parameters

| Field | Type | Notes |
| ----- | ---- | ----- |
| id | `integer (BehaviorId)` | Behavior ID of the object to modify. |
| canRotate | `bool?`/`function?` | Check to see if an object can rotate as its being inhaled, can be ignored. |
| canEat | `bool?`/`function?` | Check to see if an object can be removed once it reaches Kirby's mouth, can be ignored. |
| allowSuckFunc | `bool?`/`function?` | Special checks for special objects (I.E. Koopa the Quick), can be ignored. |
| deleteOnDetect | `bool?` | Deletes an object if it's within Kirby's inhale range, can be ignored. |
| onEatFunc | `function?` | Special function that activates once the object's been deleted (I.E. add to Big Bully #2's condition once a bully has been eaten), can be ignored. |
