package arena;

public class AnimationThread extends Thread{

	static AnimationThread theInstance;
	Animation toRun;
	public AnimationThread()
	{
		
	}
	
	public static AnimationThread getTheInstance()
	{
		//if (theInstance == null)
			//theInstance = new AnimationThread();
		return new AnimationThread();
	}
	
	public void setAnimation(Animation toRun)
	{
		this.toRun = toRun;
		this.start();
	}
	
	public void run()
	{
		int count = toRun.getImageCount();
		while (count> 0)
		{
			count--;
			toRun.setImage(count);
			try {
				Thread.sleep(toRun.getDelayTime());
			} catch (Exception e) {
				break;
			}
		}
		toRun.clear();
	}
}
