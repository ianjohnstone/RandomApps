package com.arena;

import android.app.Activity;
import android.os.Bundle;
import arena.Arena;

public class ArenaActivity extends Activity {

	public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(new Arena(this));
    }
}
