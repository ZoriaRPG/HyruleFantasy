const int SPR_KODONGOFIRE = 130;
const int CSET_KODONGOICE = 10;

ffc script Kodongo
{
	void run(int enemyID)
	{
		npc Piko=Ghost_InitAutoGhost(this, enemyID);
		Ghost_SetFlag(GHF_NORMAL);
		int OrigTile = Piko->OriginalTile;
		int firecounter = 0;
		while(Piko->HP > 0 && Piko->isValid())
		{
			if (Piko->Tile >= OrigTile + 40)
			{
				int temptile = Piko->Tile;
				while (firecounter < 60)
				{
					Piko->Tile = temptile;
					Piko->Stun = 1;
					if (firecounter % 20 == 0)
					{
						if (Piko->Attributes[5] <= 0) FireFire(Piko->X, Piko->Y, Piko->Dir, 3, Piko->Damage);
						else FireIce(Piko->X, Piko->Y, Piko->Dir, 3, Piko->Damage);
					}
					firecounter++;
					Ghost_Waitframe2(this, Piko, true, true);
				}
			}
			
			//else if (Piko->Tile >= OrigTile + 20)
			//{
			//	firecounter = 0;
			//}
			
			else
			{
				firecounter = 0;
			}
			Ghost_Waitframe2(this, Piko, true, true);
		}
		this->Data = 0;
		this->Script = 0;
		Quit();
	}
	void FireFire(int x, int y, int dir, int speed, int damage){
		eweapon fire = CreateEWeaponAt(EW_FIRE2, x, y);
		Game->PlaySound(SFX_FIRE);
		fire->UseSprite(SPR_KODONGOFIRE);
		fire->Step = speed * 100;
		fire->Damage = damage;
		if(dir == DIR_UP){
			fire->Dir = DIR_UP;
			fire->Angle = PI/2;
			fire->Y -= 12;
		}
			
		else if(dir == DIR_DOWN){
			fire->Dir = DIR_DOWN;
			fire->Angle = PI/2 * -1;
			fire->Y += 12;
		}
		else if(dir == DIR_LEFT){
			fire->Dir = DIR_LEFT;
			fire->Angle = PI;
			fire->X -= 13;
			
		}
		else { //RIGHT
			fire->Dir = DIR_RIGHT;
			fire->Angle = 0;
			fire->X += 13;
		}
	}
	void FireIce(int x, int y, int dir, int speed, int damage){
		eweapon fire = CreateEWeaponAt(EW_SCRIPT3, x, y);
		Game->PlaySound(SFX_ICE);
		fire->UseSprite(SPR_KODONGOFIRE);
		fire->CSet = CSET_KODONGOICE;
		fire->Step = speed * 100;
		fire->Damage = damage;
		if(dir == DIR_UP){
			fire->Dir = DIR_UP;
			fire->Angle = PI/2;
			fire->Y -= 12;
		}
			
		else if(dir == DIR_DOWN){
			fire->Dir = DIR_DOWN;
			fire->Angle = PI/2 * -1;
			fire->Y += 12;
		}
		else if(dir == DIR_LEFT){
			fire->Dir = DIR_LEFT;
			fire->Angle = PI;
			fire->X -= 13;
			
		}
		else { //RIGHT
			fire->Dir = DIR_RIGHT;
			fire->Angle = 0;
			fire->X += 13;
		}
	}
}