import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class Ex4Tester {

    @Test
    public void runValidTests() throws IOException {

        File ex1TestsDir = new File("examples\\ex4\\valid");
        File outputDir = new File("temp_out");

        File ex1TestsFiles[] = ex1TestsDir.listFiles();
        Map<String,File> testMap =new HashMap<>();

        for (File ex1File : ex1TestsFiles){
            if(!ex1File.getName().endsWith(".java"))
                continue;
            String line = "parse marshal "+ex1File.getPath()
                    +" "+outputDir+"\\"+ex1File.getName()+".xml";
            Main.main(line.split(" "));
            String inputString = Files.readString(new File("examples\\ex4\\valid\\"+ex1File.getName()+".xml").toPath()).trim();
            String outputString = Files.readString(new File("temp_out\\"+ex1File.getName()+".xml").toPath()).trim();
            while(inputString.contains("<lineNumber>")) {
                inputString = inputString.substring(0, inputString.indexOf("<lineNumber>")) +
                        inputString.substring(inputString.indexOf("</lineNumber>") + 13);
            }
            while(outputString.contains("<lineNumber>")) {
                outputString = outputString.substring(0, outputString.indexOf("<lineNumber>")) +
                        outputString.substring(outputString.indexOf("</lineNumber>") + 13);
            }
            assertEquals(inputString.replaceAll("\\s+", ""), outputString.replaceAll("\\s+", ""), "Problem in test: " + ex1File.getName());
        }

    }

}
