package arena;

import java.awt.Component;
import java.awt.Dimension;
import java.awt.Point;
import java.awt.Rectangle;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Vector;

import javax.swing.*;

public class PlayerCharacter extends JLabel implements Character{

	int direction = 0;
	int distance = 0;
	private boolean left = true;
	
	int health = 3;
	int maxHealth = 3;
	
	Point position = new Point(0,0);
	Point gridPosition = new Point(0,0);
	Point finish = new Point(0,0);
	
	private Icon upOne;
	private Icon upTwo;
	private Icon rightOne;
	private Icon rightTwo;
	private Icon leftOne;
	private Icon leftTwo;
	private Icon downOne;
	private Icon downTwo;
	
	private long lasthit = 0L;
	
	public int rightLimit;
	public int downLimit;
	
	Animation attack = new AttackAnimation();
	
	private Walker stepHandler;
	
	public Vector pillars = new Vector();
	
	public PlayerCharacter(Dimension limits)
	{
		upOne = buildStepIcons("resources/Character/Up1.png");
		upTwo = buildStepIcons("resources/Character/Up2.png");
		downOne = buildStepIcons("resources/Character/Down1.png");
		downTwo = buildStepIcons("resources/Character/Down2.png");
		leftOne = buildStepIcons("resources/Character/Left1.png");
		leftTwo = buildStepIcons("resources/Character/Left2.png");
		rightOne = buildStepIcons("resources/Character/Right1.png");
		rightTwo = buildStepIcons("resources/Character/Right2.png");
		
		this.setIcon(downOne);
		
		this.direction = 0;
		this.rightLimit = limits.width;
		this.downLimit = limits.height;
		stepHandler = new Walker(this);
		stepHandler.start();
		Arena.getInstance().drawHealth(health, maxHealth);
	}
	
	private Icon buildStepIcons(String path)
	{
        java.net.URL imgURL = Arena.class.getResource(path);
        if (imgURL != null) {
            return new ImageIcon(imgURL);
        } else {
            System.err.println("Couldn't find file: " + path);
            return null;
        }
	}
	
	public void setPosition(Point newPosition)
	{
		this.position = newPosition;
	}
	public void setGridPosition(Point newPosition)
	{
		this.gridPosition = newPosition;
	}
	public void setFinish(Point newPosition)
	{
		this.finish = newPosition;
	}
	
	public void moved(int x, int y)
	{
		if (!this.detectCollision())
		{
			int posX = position.x;
			int posY = position.y;
			
			if (posX + x > 0 && posX + x < rightLimit)
				posX = posX + x;
			if (posY + y > 0 && posY + y < downLimit)
				posY = posY + y;
			this.position = new Point(posX, posY);
			this.setLocation(position);
			this.invalidate();
		}
	}
	
	public void stepped(boolean left)
	{
		this.setIcon(null);
		switch(direction)
		{
			case 0:
			{
				if (left)
				{
					this.setIcon(downOne);
				} 
				else
				{
					this.setIcon(downTwo);
				}
				break;
			}
			case 1:
			{
				if (left)
				{
					this.setIcon(upOne);
				} 
				else
				{
					this.setIcon(upTwo);
				}
				break;
			}
			case 2:
			{
				if (left)
				{
					this.setIcon(leftOne);
				} 
				else
				{
					this.setIcon(leftTwo);
				}
				break;
			}
			case 3:
			{
				if (left)
				{
					this.setIcon(rightOne);
				} 
				else
				{
					this.setIcon(rightTwo);
				}
				break;
			}
		}
		this.invalidate();
	}
	
	class Walker extends Thread
	{
		int direction = 0;
		boolean left = true;
		PlayerCharacter walkee;
		
		public Walker(PlayerCharacter walker)
		{
			this.walkee = walker;
		}
		
		public void run()
		{
			try {
				while (true)
				{
					walkee.stepped(left);
					left = !left;
				
					Thread.sleep(200);
				}
			}
			catch (InterruptedException ie)
			{
			}
			
		}
	}
	@Override
	public int getDistanceLeft() {
		return distance;
	}

	@Override
	public int getDirection() {
		return direction;
	}

	@Override
	public void setDistanceToTravel(int distance) {
		this.distance = distance;
	}

	@Override
	public void setDirection(int direction) {
		this.direction = direction;
	}

	@Override
	public void attack() {
		Point aniPos = null;
		switch (direction)
		{
		case MovementQueue.DOWN:
		{
			aniPos = new Point(this.position.x, (this.position.y + 16));
			break;
		}
		case MovementQueue.UP:
		{
			aniPos = new Point(this.position.x, (this.position.y - 16));
			break;
		}
		case MovementQueue.LEFT:
		{
			aniPos = new Point(this.position.x - 16, (this.position.y ));
			break;
		}
		case MovementQueue.RIGHT:
		{
			aniPos = new Point(this.position.x+ 16, (this.position.y));
			break;
		}
		}
		if (aniPos != null)
			attack.setLocation(aniPos);
		AnimationThread.getTheInstance().setAnimation(this.attack);
		
		Character enemyHit = runTargeting(new Rectangle(aniPos.x, aniPos.y, 16, 16));
		if (enemyHit != null)
			enemyHit.calculateHurt();
	}
	
	public Character runTargeting(Rectangle pointAttacked)
	{
		EnemyCharacter enemy = null;
		Vector<EnemyCharacter> enemies = Arena.getInstance().getEnemyList();
		for (int i = 0; i < enemies.size(); i++)
		{
			enemy = enemies.elementAt(i);
			Rectangle enemyLocation = enemy.getBounds();						//Intersection of 2 rectangles.   
			if (pointAttacked.x + pointAttacked.height < enemyLocation.x || 	//If X1+H1 < X2 or X2+H2 < X1 or
				enemyLocation.x + enemyLocation.height < pointAttacked.x ||		//Y1+W1 < Y2 or Y2+W2 < Y1, 
				pointAttacked.y + pointAttacked.width < enemyLocation.y ||		//they don't overlap (assuming
				enemyLocation.y + enemyLocation.width < pointAttacked.y)		//heights and widths are positive).
				enemy = null;
			else
				break;
			
		}
		return enemy;
	}
	
	public void calculateHurt()
	{
		// TODO Auto-generated method stub
		if (System.currentTimeMillis() > this.lasthit + 5000)
		{
			health--;
			Arena.getInstance().drawHealth(health, maxHealth);
			if (health == 0)
			{
				Arena.getInstance().getPane().remove(this);
				MovementQueue.getTheQueue().remove(this);
				this.setVisible(false);
				Arena.getInstance().gameOver();
			}
			this.lasthit  = System.currentTimeMillis();
		}
	}

	@Override
	public boolean detectCollision() {
		// TODO Auto-generated method stub
		boolean collided = false;
		JLayeredPane pane = Arena.getInstance().getPane();
		Point corner1 = null;
		Point corner2 = null;
		switch(direction)
		{
		case MovementQueue.DOWN:
		{
			corner1 = new Point(position.x, position.y + 16);
			corner2 = new Point(position.x + 16, position.y + 16);
			break;
		}
		case MovementQueue.UP:
		{
			corner1 = new Point(position.x, position.y - 1);
			corner2 = new Point(position.x + 16, position.y - 1);
			break;
		}
		case MovementQueue.LEFT:
		{
			corner1 = new Point(position.x - 1, position.y);
			corner2 = new Point(position.x - 1, position.y + 16);
			break;
		}
		case MovementQueue.RIGHT:
		{
			corner1 = new Point(position.x + 16, position.y);
			corner2 = new Point(position.x + 16, position.y + 16);
			break;
		}
		}
		Component com1 = pane.getComponentAt(corner1);
		Component com2 = pane.getComponentAt(corner2);
		if (com1 instanceof Character)
		{
			collided = true;
		}
		else if (com2 instanceof Character)
		{
			collided = true;
		}
			
		return collided;
	}

}
