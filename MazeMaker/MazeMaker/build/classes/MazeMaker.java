import java.awt.BorderLayout;
import java.awt.ComponentOrientation;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.Image;
import java.awt.Panel;
import java.awt.Rectangle;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Vector;

import javax.swing.*;
import javax.swing.border.BevelBorder;

public class MazeMaker extends JFrame implements KeyListener{
	
	private JLabel label1;
	PlayerCharacter player;
	Box verticalBox1 = new Box(BoxLayout.Y_AXIS);
	Box verticalBox2 = new Box(BoxLayout.Y_AXIS);
	Box horizontalBox = new Box(BoxLayout.X_AXIS);
	JPanel mapField = new JPanel();
	JPanel infoField = new JPanel();
	JPanel logoField = new JPanel();
	
	private Vector floor;
	
	public MazeMaker()
	{
			label1 = new JLabel();
			floor = new Vector();
			
			mapField.setLayout(new BorderLayout());
			
			this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
			
			this.setSize(600, 400);
			this.setTitle("MazeMaker!");
			
			label1.setText("Up, Down, Left, and Right change walking direction");
			JLabel label2 = new JLabel();
			JTextField widthMaker = new JTextField();
			
			label2.setText("Testing layouts");
			JLabel logoLabel = new JLabel();
			
			this.setComponentOrientation(ComponentOrientation.LEFT_TO_RIGHT);
			this.add(horizontalBox);
			Dimension size1 = new Dimension(this.getSize().width * 7 / 10, this.getBounds().height);
			Dimension size2 = new Dimension(this.getSize().width * 3 / 10, this.getBounds().height);
		
			verticalBox1.setBorder(BorderFactory.createBevelBorder(BevelBorder.RAISED));
			verticalBox1.setPreferredSize(size1);
			mapField.setPreferredSize(new Dimension(size1.width - 2, size1.height -2));
			mapField.setBorder(BorderFactory.createBevelBorder(BevelBorder.LOWERED));
			
			verticalBox2.setBorder(BorderFactory.createBevelBorder(BevelBorder.RAISED));
			verticalBox2.setPreferredSize(size2);
			
			infoField.setPreferredSize(new Dimension(size2.width - 4, (size2.height * 7 / 10) - 4));
			infoField.setBorder(BorderFactory.createBevelBorder(BevelBorder.LOWERED));
			logoField.setPreferredSize(new Dimension(size2.width - 4, (size2.height * 3 / 10) - 4));
			logoField.setBorder(BorderFactory.createBevelBorder(BevelBorder.LOWERED));
			
			logoLabel.setPreferredSize(logoField.getPreferredSize());

			try
			{
				File logoFile = new File("resources/MazeMaker_logo.png");
				FileInputStream logoReader = new FileInputStream(logoFile);
				byte[] logoBytes = new byte[logoReader.available()];
				logoReader.read(logoBytes);
				ImageIcon logo = new ImageIcon(logoBytes);
				logoLabel.setIcon(logo);
			} catch (FileNotFoundException fofe) 
			{
				
			} catch (IOException ioe)
			{
			}

			horizontalBox.add(verticalBox1);
			horizontalBox.add(verticalBox2);
			
			verticalBox1.add(mapField);

			verticalBox2.add(infoField);
			verticalBox2.add(logoField);
			
			widthMaker.setPreferredSize(new Dimension(infoField.getPreferredSize().width, 1));
			infoField.add(label1);
//			infoField.add(label2);
			
			logoField.add(logoLabel);			
			
			this.setVisible(true);
			
			player = new PlayerCharacter();
			
			mapField.add(player);
			
			this.addKeyListener(this);
			//this.layDownFloor();
	}
	
	private void layDownFloor()
	{
		int rows = this.mapField.getSize().width / 16;
		int columns = this.mapField.getSize().height / 16;
		ImageIcon floorIcon = null;

		try
		{
			File floorFile = new File("resources/Maze/FloorTile.png");
			FileInputStream floorReader = new FileInputStream(floorFile);
			byte[] floorBytes = new byte[floorReader.available()];
			floorReader.read(floorBytes);
			floorIcon = new ImageIcon(floorBytes);
		} catch (FileNotFoundException fofe) 
		{
			return;
		} catch (IOException ioe)
		{
			return;
		}

		for (int i = 0; i < rows; i++)
		{
			JPanel row = new JPanel();
			for (int j = 0; j < columns; j++)
			{
				JLabel floorTile = new JLabel();
				floorTile.setIcon(floorIcon);
				row.add(floorTile);
				floor.add(row);
			}
			mapField.add(row);
		}
	}

	@Override
	public void keyPressed(KeyEvent ke) {
		// TODO Auto-generated method stub
		int pressed = ke.getKeyCode();
		
		switch (pressed)
		{
		case KeyEvent.VK_DOWN:
			player.direction = 0;
			break;
		case KeyEvent.VK_UP:
			player.direction = 1;
			break;
		case KeyEvent.VK_LEFT:
			player.direction = 2;
			break;
		case KeyEvent.VK_RIGHT:
			player.direction = 3;
			break;
		}
		
	}

	@Override
	public void keyReleased(KeyEvent ke) {
		// TODO Auto-generated method stub
		int pressed = ke.getKeyChar();
		
		switch (pressed)
		{
		case KeyEvent.VK_DOWN:
			player.direction = 0;
			break;
		case KeyEvent.VK_UP:
			player.direction = 1;
			break;
		case KeyEvent.VK_LEFT:
			player.direction = 2;
			break;
		case KeyEvent.VK_RIGHT:
			player.direction = 3;
			break;
		}
		
	}

	@Override
	public void keyTyped(KeyEvent ke) {
		// TODO Auto-generated method stub
		int pressed = ke.getKeyChar();
		
		switch (pressed)
		{
		case KeyEvent.VK_DOWN:
			player.direction = 0;
			break;
		case KeyEvent.VK_UP:
			player.direction = 1;
			break;
		case KeyEvent.VK_LEFT:
			player.direction = 2;
			break;
		case KeyEvent.VK_RIGHT:
			player.direction = 3;
			break;
		}
		
	}
}
