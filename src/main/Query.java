package main;

import jess.JessException;
import jess.QueryResult;
import jess.ValueVector;

public class Query {

	public Query() {
		try {
			QueryResult res = Main.engine.runQueryStar("get-tea", new ValueVector());
			while (res.next()) {
				System.out.printf("%-30s %-8s %-10s\n", res.get("name"), res.get("price"), res.get("type"));
			}
		} catch (JessException e) {
			e.printStackTrace();
		}
		
	}
}
