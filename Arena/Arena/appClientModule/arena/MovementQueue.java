package arena;

import java.util.Random;
import java.util.Vector;

public class MovementQueue extends Thread{

	static MovementQueue theInstance;
	Vector<Character> queue = new Vector<Character>();
	
	Random enemyMovement = new Random();
	
	final public static int DOWN = 0;
	final public static int UP = 1;
	final public static int LEFT = 2;
	final public static int RIGHT = 3;
	
	public MovementQueue()
	{
		
	}
	
	public static MovementQueue getTheQueue()
	{
		if (theInstance == null)
			theInstance = new MovementQueue();
		
		return theInstance;
	}
	
	public void run()
	{
		running = true;
		while (running)
		{
			Character top = queue.firstElement();
			int distance = top.getDistanceLeft();
			if (distance > 0)
			{
				switch(top.getDirection())
				{
				case MovementQueue.DOWN:
				{
					top.moved(0, 1);
					break;
				}
				case MovementQueue.UP:
				{
					top.moved(0, -1);
					break;
				}
				case MovementQueue.LEFT:
				{
					top.moved(-1, 0);
					break;
				}
				case MovementQueue.RIGHT:
				{
					top.moved(1, 0);
					break;
				}
				}
			}
			if (distance > 0)
				top.setDistanceToTravel(distance - 1);
			if (distance == 0 & top instanceof EnemyCharacter)
			{
				((EnemyCharacter)top).calculateNextMove();
			}
			queue.remove(top);
			queue.add(top);
			try
			{
				Thread.sleep(5);
			}
			catch (Exception e)
			{
				return;
			}
			
		}
	}
	private boolean running = false;
	public void add(Character character)
	{
		if (!queue.contains(character))
			queue.add(character);
		if (!running)
			this.start();
	}
	
	public void remove(Character character)
	{
		if (queue.contains(character))
			queue.remove(character);
	}
	
	public static void restart()
	{
		theInstance = new MovementQueue();
	}
}
