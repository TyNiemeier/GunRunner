 [Gun Runner]
📖 Project Description:
The main character is an explorer who stumbled upon a tunnel that leads him into an underground sewage system that runs underground. The explorer will have to explore each room to find the Abyss King which guards the door to escape the underground. The game will have a dark aesthetic to it. Each room will have gross looking enemies that need to be killed to progress to the next room. The explorer will have to use his weapons to clear each room and the Abyss King in order to escape. The main source of inspiration for the game is Enter the Gungeon.


Gameplay Features and How To Test
[Feature Name]	[Instructions]
[Spear Attack] - When pressing left flick or L1 then the player will attack in the facing direction. If the gun is equiped then press R or X to switch weapons
[Ranged Attack] - When pressing left click or L1 then the player will shoot a projectile in the facing direcion that damages enemies. If the spear is equiped then press R or X to switch weapons
[Dash] - When pressing the space key or B then the player will dash forward at a faster speed holding the weapon equiped. When dashing past enemies and projectiles the player wont take damage to them.
[Bomb] - When pressing Q or R2 the player will drop a bomb doing damage to enemies in a large area. However the bomb has a cooldown.
[healing items] - healing items like apples will be spread out around the map. When the player comes in contact wiuth them their health will incrase with a max of 100.
[Sprint] - When holding shift or A the player will speed up and play sprinting aniamtions


OOP Elements And Godot Features:
[Inheritance] - Inheritacne is shown in the enemy.gd script. This allows us to replicate the enemy code for each different enemy and also be able to change their damage outputs.
[Polymorphism] - Polymorphism is primarly shown in the players animation code to check each of the variables
[Encapsulation] - Encapsulation is shown throughout our player code with the animations and dash functions and also is shown in the enemy code
[Abstraction] - Abstraction is shown in our enemy code in functions like enemy_hit()
[Private Signals] - Private Signals are used in the HUD to detect when the bomb cooldown in done, when the player swtiches weapons, and others


Group Members Role:
[Ty] - Worked primarly on all the player animations, making smaller features like the player death, and creating the needed documentation and templates for the reflections.
[Blake] - Worked a lot of the enemies, making different types of enemies and making them do damage to the player, also worked on the player attack and shoot
[Fiston] - Worked on the map for the majority of the project creating all the scenes needed, adding collison, and making the player transition to a new scene when walking through the door
[Mason] - Worked on the player dash and then mostly worked on the UI including the menu screens and the HUD


Resources Used:
https://drive.google.com/drive/folders/1h9PknkJ2PeYVXsihBQgex6HXNXhq-mK8?usp=sharing
