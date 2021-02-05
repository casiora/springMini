package com.mini.map.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("map")
public class MapController {
	
	@RequestMapping("map")
	public String map() {
		
		return "map/map";
	}
	

}
