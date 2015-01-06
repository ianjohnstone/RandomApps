package arena;

import java.awt.Point;

import javax.swing.JLabel;

public interface Animation {
	public int getImageCount();
	public int getDelayTime();
	public void setImage(int image);
	public void clear();
	public void setLocation(Point location);
}
