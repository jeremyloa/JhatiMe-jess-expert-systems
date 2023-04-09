package main;

import jess.JessException;
import jess.Rete;

public class Main {

	static Rete engine;
	public Main() {
		engine = new Rete();
		try {
			engine.batch("main/main.clp");
			engine.reset();
			engine.run();
		} catch (JessException e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		new Main();
	}
}
