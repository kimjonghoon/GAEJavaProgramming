package net.java_school.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class DownloadController {

    private static final String FILE_DIR = "/resources/download/";

    @GetMapping("/download/{filename:.+}")
    public String download(@PathVariable String filename) {

    	return "redirect:" + FILE_DIR + filename; 
                
    }

}