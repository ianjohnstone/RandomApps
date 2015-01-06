package arena;

import java.util.ArrayList;
import com.arena.*;
import android.R;
import android.content.Context;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.text.Editable;
import android.view.ViewGroup;
import android.view.View;
import android.widget.*;

public class Arena extends ViewGroup{

	View combatArea;
	ViewGroup optionsArea;
	ImageView logo;
	TextView scoreBoard;
	TextView sideBySide;
	
	ArrayList<View> touchables = new ArrayList<View>();
	
	public Arena(Context context) {
		super(context);
		// TODO Auto-generated constructor stub
		
		this.
		optionsArea = new LinearLayout(context);
		combatArea = new View(context);
		touchables.add(optionsArea);
		touchables.add(combatArea);
		
		logo = new ImageView(context);
		logo.setImageResource(com.arena.R.drawable.arena_logo);
		
		scoreBoard = new TextView(context);
		scoreBoard.setText(com.arena.R.string.hello);
		sideBySide = new TextView(context);
		sideBySide.setText("Test String");
		//this.addView(optionsArea, this.getWidth(), this.getHeight() / 2);
		//this.addView(combatArea, this.getWidth(), this.getHeight() / 2);
		this.addView(logo);
		this.addView(optionsArea);
		optionsArea.addView(scoreBoard);
		optionsArea.addView(sideBySide);
		startLayoutAnimation();
	}
	@Override
	protected void onLayout(boolean changed, int l, int t, int r, int b) {
		// TODO Auto-generated method stub
		//combatArea.layout(l, b/2, r, b);
		logo.layout(l, t, r, b / 2);
		optionsArea.layout(l, b/2, r, b);
		optionsArea.startLayoutAnimation();
	}

}
